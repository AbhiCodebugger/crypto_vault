import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_bloc_state.dart';
import '../../domain/entities/portfolio_item.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Portfolio')),
      body: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          return switch (state) {
            PortfolioInitial() || PortfolioLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            PortfolioLoaded(portfolio: var portfolio) =>
              portfolio.isEmpty
                  ? const Center(child: Text('No assets in portfolio'))
                  : ListView.builder(
                    itemCount: portfolio.length,
                    itemBuilder: (context, index) {
                      final item = portfolio[index];
                      return ListTile(
                        title: Text(item.coinId.toUpperCase()),
                        subtitle: Text('Amount: ${item.amount}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<PortfolioBloc>().add(
                              RemoveAssetEvent(item.coinId),
                            );
                          },
                        ),
                      );
                    },
                  ),
            PortfolioError(message: var message) => Center(
              child: Text(message),
            ),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAssetDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddAssetDialog(BuildContext context) {
    final coinController = TextEditingController();
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add Asset'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: coinController,
                  decoration: const InputDecoration(
                    labelText: 'Coin Symbol (e.g. btc)',
                  ),
                ),
                TextField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final amount = double.tryParse(amountController.text) ?? 0.0;
                  if (coinController.text.isNotEmpty && amount > 0) {
                    BlocProvider.of<PortfolioBloc>(context).add(
                      AddAssetEvent(
                        PortfolioItem(
                          coinId: coinController.text.toLowerCase(),
                          amount: amount,
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }
}

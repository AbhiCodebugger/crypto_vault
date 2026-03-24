import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/crypto_bloc.dart';
import '../bloc/crypto_bloc_state.dart';
import '../widgets/coin_list_item.dart';
import 'portfolio_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CryptoVault'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PortfolioScreen()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CryptoBloc>().add(GetTopCoinsEvent());
        },
        child: BlocBuilder<CryptoBloc, CryptoState>(
          builder: (context, state) {
            return switch (state) {
              CryptoInitial() || CryptoLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              CryptoLoaded(coins: var coins) => ListView.builder(
                itemCount: coins.length,
                itemBuilder: (context, index) {
                  return CoinListItem(coin: coins[index]);
                },
              ),
              CryptoError(message: var message) => Center(child: Text(message)),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}

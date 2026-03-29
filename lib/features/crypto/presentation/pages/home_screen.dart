import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/crypto_bloc.dart';
import '../bloc/crypto_bloc_state.dart';
import '../widgets/coin_list_item.dart';
import 'wishlist_screen.dart';
import '../../../../core/theme/theme_toggle_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CryptoVault'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WishlistScreen()),
              );
            },
          ),
          const ThemeToggleWidget(),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name or symbol...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                        : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<CryptoBloc>().add(GetTopCoinsEvent());
              },
              child: BlocBuilder<CryptoBloc, CryptoState>(
                builder: (context, state) {
                  return switch (state) {
                    CryptoInitial() || CryptoLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    CryptoLoaded(coins: var coins) => _buildCoinList(coins),
                    CryptoError(message: var message) => Center(
                      child: Text(message),
                    ),
                    _ => const SizedBox.shrink(),
                  };
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoinList(List coins) {
    final query = _searchController.text.toLowerCase();
    final filteredCoins =
        coins.where((coin) {
          return coin.name.toLowerCase().contains(query) ||
              coin.symbol.toLowerCase().contains(query);
        }).toList();

    if (filteredCoins.isEmpty) {
      return const Center(child: Text('No coins found'));
    }

    return ListView.separated(
      itemCount: filteredCoins.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return CoinListItem(coin: filteredCoins[index]);
      },
    );
  }
}

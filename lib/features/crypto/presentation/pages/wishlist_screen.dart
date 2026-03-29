import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/wishlist_bloc.dart';
import '../bloc/wishlist_bloc_state.dart';
import '../../domain/entities/coin.dart';
import '../widgets/coin_list_item.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          return switch (state) {
            WishlistInitial() || WishlistLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            WishlistLoaded(wishlist: var wishlist) =>
              wishlist.isEmpty
                  ? const Center(child: Text('No coins in wishlist'))
                  : ListView.separated(
                    itemCount: wishlist.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = wishlist[index];
                      return CoinListItem(coin: item);
                    },
                  ),
            WishlistError(message: var message) => Center(
              child: Text(message),
            ),
          };
        },
      ),
    );
  }
}

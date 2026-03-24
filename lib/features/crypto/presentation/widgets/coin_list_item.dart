import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/coin.dart';
import '../pages/details_screen.dart';

class CoinListItem extends StatelessWidget {
  final Coin coin;

  const CoinListItem({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');
    final percentFormat = NumberFormat.decimalPercentPattern(decimalDigits: 2);
    final isPositive = coin.priceChangePercentage24h >= 0;

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailsScreen(coin: coin)),
        );
      },
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.network(
          coin.imageUrl,
          errorBuilder: (_, __, ___) => const Icon(Icons.currency_bitcoin),
        ),
      ),
      title: Text(
        coin.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(coin.symbol.toUpperCase()),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            currencyFormat.format(coin.currentPrice),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            '${isPositive ? '+' : ''}${percentFormat.format(coin.priceChangePercentage24h / 100)}',
            style: TextStyle(
              color: isPositive ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

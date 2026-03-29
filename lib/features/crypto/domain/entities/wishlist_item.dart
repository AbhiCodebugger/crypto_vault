import 'coin.dart';

class WishlistItem extends Coin {
  const WishlistItem({
    required super.id,
    required super.symbol,
    required super.name,
    required super.currentPrice,
    required super.priceChangePercentage24h,
    required super.marketCap,
    required super.imageUrl,
  });

  factory WishlistItem.fromCoin(Coin coin) {
    return WishlistItem(
      id: coin.id,
      symbol: coin.symbol,
      name: coin.name,
      currentPrice: coin.currentPrice,
      priceChangePercentage24h: coin.priceChangePercentage24h,
      marketCap: coin.marketCap,
      imageUrl: coin.imageUrl,
    );
  }
}

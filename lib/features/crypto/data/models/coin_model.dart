import '../../domain/entities/coin.dart';

class CoinModel extends Coin {
  const CoinModel({
    required super.id,
    required super.symbol,
    required super.name,
    required super.currentPrice,
    required super.priceChangePercentage24h,
    required super.marketCap,
    required super.imageUrl,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id']?.toString() ?? json['symbol'] ?? '',
      symbol: json['symbol'] ?? '',
      name:
          (json['name'] != null && json['name'].toString().isNotEmpty)
              ? json['name']
              : (json['symbol'] ?? ''),
      currentPrice: (json['current_price'] as num?)?.toDouble() ?? 0.0,
      priceChangePercentage24h:
          (json['price_change_percentage_24h'] as num?)?.toDouble() ?? 0.0,
      marketCap: (json['market_cap'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'current_price': currentPrice,
      'price_change_percentage_24h': priceChangePercentage24h,
      'market_cap': marketCap,
      'image': imageUrl,
    };
  }
}

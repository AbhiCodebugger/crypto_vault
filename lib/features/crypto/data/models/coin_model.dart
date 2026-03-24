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
      id: json['symbol'] ?? '',
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      // /getCryptoList only returns symbol and name. 
      // Other fields are defaulted or could be fetched via /getData later.
      currentPrice: (json['price'] as num?)?.toDouble() ?? 0.0,
      priceChangePercentage24h: (json['change'] as num?)?.toDouble() ?? 0.0,
      marketCap: (json['marketCap'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['logo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'price': currentPrice,
      'change': priceChangePercentage24h,
      'marketCap': marketCap,
      'logo': imageUrl,
    };
  }
}

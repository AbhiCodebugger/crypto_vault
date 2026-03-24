import 'package:equatable/equatable.dart';

class Coin extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final double currentPrice;
  final double priceChangePercentage24h;
  final double marketCap;
  final String imageUrl;

  const Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    required this.marketCap,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
    id,
    symbol,
    name,
    currentPrice,
    priceChangePercentage24h,
    marketCap,
    imageUrl,
  ];
}

import 'package:equatable/equatable.dart';

class PortfolioItem extends Equatable {
  final String coinId;
  final double amount;

  const PortfolioItem({required this.coinId, required this.amount});

  @override
  List<Object?> get props => [coinId, amount];
}

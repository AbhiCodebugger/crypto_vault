import '../domain/entities/portfolio_item.dart';

class PortfolioItemModel extends PortfolioItem {
  const PortfolioItemModel({
    required super.coinId,
    required super.amount,
  });

  factory PortfolioItemModel.fromEntity(PortfolioItem entity) {
    return PortfolioItemModel(
      coinId: entity.coinId,
      amount: entity.amount,
    );
  }
}

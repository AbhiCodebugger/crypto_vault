import 'package:hive_ce/hive.dart';
import '../../domain/entities/portfolio_item.dart';

part 'portfolio_item_model.g.dart';

@HiveType(typeId: 0)
class PortfolioItemModel extends PortfolioItem {
  @HiveField(0)
  @override
  String get coinId => super.coinId;

  @HiveField(1)
  @override
  double get amount => super.amount;

  const PortfolioItemModel({required super.coinId, required super.amount});

  factory PortfolioItemModel.fromEntity(PortfolioItem entity) {
    return PortfolioItemModel(coinId: entity.coinId, amount: entity.amount);
  }
}

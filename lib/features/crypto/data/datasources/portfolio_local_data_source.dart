import 'package:hive_ce/hive.dart';
import '../models/portfolio_item_model.dart';

abstract class PortfolioLocalDataSource {
  Future<List<PortfolioItemModel>> getPortfolio();
  Future<void> addAsset(PortfolioItemModel item);
  Future<void> removeAsset(String coinId);
}

class PortfolioLocalDataSourceImpl implements PortfolioLocalDataSource {
  final Box<PortfolioItemModel> portfolioBox;

  PortfolioLocalDataSourceImpl({required this.portfolioBox});

  @override
  Future<List<PortfolioItemModel>> getPortfolio() async {
    return portfolioBox.values.toList();
  }

  @override
  Future<void> addAsset(PortfolioItemModel item) async {
    // Correctly using coinId from the model
    await portfolioBox.put(item.coinId, item);
  }

  @override
  Future<void> removeAsset(String coinId) async {
    await portfolioBox.delete(coinId);
  }
}

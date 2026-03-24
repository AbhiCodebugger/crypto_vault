import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/portfolio_item.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_data_source.dart';
import '../models/portfolio_item_model.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource localDataSource;

  PortfolioRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<PortfolioItem>>> getPortfolio() async {
    try {
      final localPortfolio = await localDataSource.getPortfolio();
      // Need to explicitly cast or map to the base Entity type
      return Right(
        localPortfolio.map((model) => model as PortfolioItem).toList(),
      );
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addAsset(PortfolioItem item) async {
    try {
      await localDataSource.addAsset(PortfolioItemModel.fromEntity(item));
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeAsset(String coinId) async {
    try {
      await localDataSource.removeAsset(coinId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

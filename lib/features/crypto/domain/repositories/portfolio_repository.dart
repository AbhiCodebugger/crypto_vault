import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/portfolio_item.dart';

abstract class PortfolioRepository {
  Future<Either<Failure, List<PortfolioItem>>> getPortfolio();
  Future<Either<Failure, void>> addAsset(PortfolioItem item);
  Future<Either<Failure, void>> removeAsset(String coinId);
}

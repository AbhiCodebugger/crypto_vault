import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/portfolio_item.dart';
import '../repositories/portfolio_repository.dart';

class GetPortfolio
    implements UseCase<Either<Failure, List<PortfolioItem>>, NoParams> {
  final PortfolioRepository repository;

  GetPortfolio(this.repository);

  @override
  Future<Either<Failure, List<PortfolioItem>>> call(NoParams params) async {
    return await repository.getPortfolio();
  }
}

class AddAsset implements UseCase<Either<Failure, void>, AddAssetParams> {
  final PortfolioRepository repository;

  AddAsset(this.repository);

  @override
  Future<Either<Failure, void>> call(AddAssetParams params) async {
    return await repository.addAsset(params.item);
  }
}

class AddAssetParams {
  final PortfolioItem item;
  AddAssetParams({required this.item});
}

class RemoveAsset implements UseCase<Either<Failure, void>, RemoveAssetParams> {
  final PortfolioRepository repository;

  RemoveAsset(this.repository);

  @override
  Future<Either<Failure, void>> call(RemoveAssetParams params) async {
    return await repository.removeAsset(params.coinId);
  }
}

class RemoveAssetParams {
  final String coinId;
  RemoveAssetParams({required this.coinId});
}

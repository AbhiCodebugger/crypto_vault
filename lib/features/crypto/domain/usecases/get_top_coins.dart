import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/coin.dart';
import '../repositories/crypto_repository.dart';

class GetTopCoins implements UseCase<Either<Failure, List<Coin>>, NoParams> {
  final CryptoRepository repository;

  GetTopCoins(this.repository);

  @override
  Future<Either<Failure, List<Coin>>> call(NoParams params) async {
    return await repository.getTopCoins();
  }
}

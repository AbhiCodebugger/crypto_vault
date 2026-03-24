import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/coin.dart';
import '../repositories/crypto_repository.dart';

class GetCoinDetails
    implements UseCase<Either<Failure, Coin>, GetCoinDetailsParams> {
  final CryptoRepository repository;

  GetCoinDetails(this.repository);

  @override
  Future<Either<Failure, Coin>> call(GetCoinDetailsParams params) async {
    return await repository.getCoinDetails(params.id);
  }
}

class GetCoinDetailsParams extends Equatable {
  final String id;

  const GetCoinDetailsParams({required this.id});

  @override
  List<Object?> get props => [id];
}

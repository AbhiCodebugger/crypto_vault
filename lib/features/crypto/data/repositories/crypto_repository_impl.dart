import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/coin.dart';
import '../../domain/entities/historical_data.dart';
import '../../domain/repositories/crypto_repository.dart';
import '../datasources/crypto_remote_data_source.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoRemoteDataSource remoteDataSource;

  CryptoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Coin>>> getTopCoins() async {
    try {
      final remoteCoins = await remoteDataSource.getTopCoins();
      return Right(remoteCoins);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Coin>> getCoinDetails(String id) async {
    try {
      final remoteCoin = await remoteDataSource.getCoinDetails(id);
      return Right(remoteCoin);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<HistoricalData>>> getHistoricalData(
    String id,
    int days,
  ) async {
    try {
      final remoteHistory = await remoteDataSource.getHistoricalData(id, days);
      return Right(remoteHistory);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/coin.dart';
import '../entities/historical_data.dart';

abstract class CryptoRepository {
  Future<Either<Failure, List<Coin>>> getTopCoins();
  Future<Either<Failure, Coin>> getCoinDetails(String id);
  Future<Either<Failure, List<HistoricalData>>> getHistoricalData(
    String id,
    int days,
  );
}

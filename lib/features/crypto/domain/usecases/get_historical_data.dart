import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/historical_data.dart';
import '../repositories/crypto_repository.dart';

class GetHistoricalData
    implements
        UseCase<
          Either<Failure, List<HistoricalData>>,
          GetHistoricalDataParams
        > {
  final CryptoRepository repository;

  GetHistoricalData(this.repository);

  @override
  Future<Either<Failure, List<HistoricalData>>> call(
    GetHistoricalDataParams params,
  ) async {
    return await repository.getHistoricalData(params.id, params.days);
  }
}

class GetHistoricalDataParams extends Equatable {
  final String id;
  final int days;

  const GetHistoricalDataParams({required this.id, required this.days});

  @override
  List<Object?> get props => [id, days];
}

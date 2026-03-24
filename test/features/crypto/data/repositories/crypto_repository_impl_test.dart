import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:crypto_vault/core/error/failures.dart';
import 'package:crypto_vault/features/crypto/data/datasources/crypto_remote_data_source.dart';
import 'package:crypto_vault/features/crypto/data/models/coin_model.dart';
import 'package:crypto_vault/features/crypto/data/repositories/crypto_repository_impl.dart';

class MockRemoteDataSource extends Mock implements CryptoRemoteDataSource {}

void main() {
  late CryptoRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = CryptoRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tCoinModels = [
    CoinModel(
      id: 'btc',
      symbol: 'btc',
      name: 'Bitcoin',
      currentPrice: 50000.0,
      priceChangePercentage24h: 5.0,
      marketCap: 1000000000.0,
      imageUrl: 'url',
    ),
  ];

  group('getCryptoList', () {
    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(() => mockRemoteDataSource.getTopCoins()).thenAnswer((_) async => tCoinModels);
      // act
      final result = await repository.getTopCoins();
      // assert
      verify(() => mockRemoteDataSource.getTopCoins());
      expect(result, equals(const Right(tCoinModels)));
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(() => mockRemoteDataSource.getTopCoins()).thenThrow(ServerFailure());
      // act
      final result = await repository.getTopCoins();
      // assert
      verify(() => mockRemoteDataSource.getTopCoins());
      expect(result, equals(Left(ServerFailure())));
    });
  });
}

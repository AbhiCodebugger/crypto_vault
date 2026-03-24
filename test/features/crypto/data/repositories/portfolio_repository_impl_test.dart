import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:crypto_vault/core/error/failures.dart';
import 'package:crypto_vault/features/crypto/data/datasources/portfolio_local_data_source.dart';
import 'package:crypto_vault/features/crypto/data/models/portfolio_item_model.dart';
import 'package:crypto_vault/features/crypto/data/repositories/portfolio_repository_impl.dart';
import 'package:crypto_vault/features/crypto/domain/entities/portfolio_item.dart';

class MockLocalDataSource extends Mock implements PortfolioLocalDataSource {}

void main() {
  late PortfolioRepositoryImpl repository;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = PortfolioRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  const tPortfolioItemModel = PortfolioItemModel(coinId: 'btc', amount: 1.5);
  final List<PortfolioItemModel> tPortfolioList = [tPortfolioItemModel];

  group('getPortfolio', () {
    test('should return local data when the call to local data source is successful', () async {
      // arrange
      when(() => mockLocalDataSource.getPortfolio()).thenAnswer((_) async => tPortfolioList);
      // act
      final result = await repository.getPortfolio();
      // assert
      verify(() => mockLocalDataSource.getPortfolio());
      expect(result, isA<Right<Failure, List<PortfolioItem>>>());
    });

    test('should return cache failure when the call to local data source is unsuccessful', () async {
      // arrange
      when(() => mockLocalDataSource.getPortfolio()).thenThrow(Exception());
      // act
      final result = await repository.getPortfolio();
      // assert
      expect(result, equals(Left(CacheFailure())));
    });
  });
}

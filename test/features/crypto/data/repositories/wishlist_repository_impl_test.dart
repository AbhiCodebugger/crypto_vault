import 'package:crypto_vault/features/crypto/data/datasources/wishlist_local_data_source.dart';
import 'package:crypto_vault/features/crypto/data/models/wishlist_item_model.dart';
import 'package:crypto_vault/features/crypto/data/repositories/wishlist_repository_impl.dart';
import 'package:crypto_vault/features/crypto/domain/entities/wishlist_item.dart';
import 'package:crypto_vault/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWishlistLocalDataSource extends Mock implements WishlistLocalDataSource {}

void main() {
  late WishlistRepositoryImpl repository;
  late MockWishlistLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockWishlistLocalDataSource();
    repository = WishlistRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  const tWishlistItemModel = WishlistItemModel(
    id: 'bitcoin',
    symbol: 'btc',
    name: 'Bitcoin',
    currentPrice: 50000,
    priceChangePercentage24h: 1.5,
    marketCap: 1000000,
    imageUrl: 'url',
  );

  const tWishlist = [tWishlistItemModel];

  group('getWishlist', () {
    test('should return local data when call to local datasource is successful',
        () async {
      when(() => mockLocalDataSource.getWishlist())
          .thenAnswer((_) async => tWishlist);

      final result = await repository.getWishlist();

      verify(() => mockLocalDataSource.getWishlist());
      expect(result.isRight(), true);
      result.fold(
        (l) => fail('Should be right'),
        (r) => expect(r, equals(tWishlist)),
      );
    });
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:crypto_vault/core/usecases/usecase.dart';
import 'package:crypto_vault/features/crypto/domain/entities/coin.dart';
import 'package:crypto_vault/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:crypto_vault/features/crypto/domain/usecases/get_top_coins.dart';

class MockCryptoRepository extends Mock implements CryptoRepository {}

void main() {
  late GetTopCoins usecase;
  late MockCryptoRepository mockCryptoRepository;

  setUp(() {
    mockCryptoRepository = MockCryptoRepository();
    usecase = GetTopCoins(mockCryptoRepository);
  });

  const tCoins = [
    Coin(
      id: 'btc',
      symbol: 'btc',
      name: 'Bitcoin',
      currentPrice: 50000.0,
      priceChangePercentage24h: 5.0,
      marketCap: 1000000000.0,
      imageUrl: 'url',
    ),
  ];

  test('should get top coins from the repository', () async {
    // arrange
    when(() => mockCryptoRepository.getTopCoins())
        .thenAnswer((_) async => const Right(tCoins));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, const Right(tCoins));
    verify(() => mockCryptoRepository.getTopCoins());
    verifyNoMoreInteractions(mockCryptoRepository);
  });
}

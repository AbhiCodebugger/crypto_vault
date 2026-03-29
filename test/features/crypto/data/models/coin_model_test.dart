import 'package:flutter_test/flutter_test.dart';
import 'package:crypto_vault/features/crypto/data/models/coin_model.dart';
import 'package:crypto_vault/features/crypto/domain/entities/coin.dart';

void main() {
  const tCoinModel = CoinModel(
    id: '30',
    symbol: 'MANA',
    name: 'Decentraland',
    currentPrice: 0.0,
    priceChangePercentage24h: 0.0,
    marketCap: 0.0,
    imageUrl: '',
  );

  test('should be a subclass of Coin entity', () async {
    expect(tCoinModel, isA<Coin>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is from getCryptoList', () async {
      final Map<String, dynamic> jsonMap = {
        'id': 30,
        'symbol': 'MANA',
        'name': 'Decentraland',
        'source': 'binance',
      };

      final result = CoinModel.fromJson(jsonMap);

      expect(result.id, '30');
      expect(result.symbol, 'MANA');
      expect(result.name, 'Decentraland');
    });

    test('should fall back to symbol if name is empty', () async {
      final Map<String, dynamic> jsonMap = {
        'id': 30,
        'symbol': 'MANA',
        'name': '',
      };

      final result = CoinModel.fromJson(jsonMap);

      expect(result.name, 'MANA');
    });
  });
}

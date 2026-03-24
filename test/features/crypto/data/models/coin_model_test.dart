import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:crypto_vault/features/crypto/data/models/coin_model.dart';
import 'package:crypto_vault/features/crypto/domain/entities/coin.dart';

void main() {
  const tCoinModel = CoinModel(
    id: 'btc',
    symbol: 'btc',
    name: 'Bitcoin',
    currentPrice: 50000.0,
    priceChangePercentage24h: 5.0,
    marketCap: 1000000000.0,
    imageUrl: 'https://logo.com/btc.png',
  );

  test('should be a subclass of Coin entity', () async {
    expect(tCoinModel, isA<Coin>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is correct', () async {
      final Map<String, dynamic> jsonMap = {
        'symbol': 'btc',
        'name': 'Bitcoin',
        'price': 50000.0,
        'change': 5.0,
        'marketCap': 1000000000.0,
        'logo': 'https://logo.com/btc.png',
      };

      final result = CoinModel.fromJson(jsonMap);

      expect(result, tCoinModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final result = tCoinModel.toJson();

      final expectedMap = {
        'symbol': 'btc',
        'name': 'Bitcoin',
        'price': 50000.0,
        'change': 5.0,
        'marketCap': 1000000000.0,
        'logo': 'https://logo.com/btc.png',
      };

      expect(result, expectedMap);
    });
  });
}

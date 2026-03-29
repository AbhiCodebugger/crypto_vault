import 'package:dio/dio.dart';
import '../../../../core/api_config.dart';
import '../../../../core/error/failures.dart';
import '../models/coin_model.dart';
import '../models/historical_data_model.dart';

abstract class CryptoRemoteDataSource {
  Future<List<CoinModel>> getTopCoins();
  Future<CoinModel> getCoinDetails(String id);
  Future<List<HistoricalDataModel>> getHistoricalData(String id, int days);
}

class CryptoRemoteDataSourceImpl implements CryptoRemoteDataSource {
  final Dio dio;

  CryptoRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CoinModel>> getTopCoins() async {
    final response = await dio.get(
      '${ApiConfig.baseUrl}/coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
        'order': 'market_cap_desc',
        'per_page': 50,
        'page': 1,
        'sparkline': false,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => CoinModel.fromJson(json)).toList();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<CoinModel> getCoinDetails(String id) async {
    final response = await dio.get(
      '${ApiConfig.baseUrl}/coins/markets',
      queryParameters: {'vs_currency': 'usd', 'ids': id},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return CoinModel.fromJson(data[0]);
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<List<HistoricalDataModel>> getHistoricalData(
    String id,
    int days,
  ) async {
    final response = await dio.get(
      '${ApiConfig.baseUrl}/coins/$id/market_chart',
      queryParameters: {'vs_currency': 'usd', 'days': days},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['prices'];
      return data.map((list) => HistoricalDataModel.fromList(list)).toList();
    } else {
      throw ServerFailure();
    }
  }
}

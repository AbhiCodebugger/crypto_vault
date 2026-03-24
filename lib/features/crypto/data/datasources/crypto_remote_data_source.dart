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
      '${ApiConfig.baseUrl}/getTop',
      options: Options(
        headers: {'Authorization': 'Bearer ${ApiConfig.apiKey}'},
      ),
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
      '${ApiConfig.baseUrl}/getData',
      queryParameters: {'symbol': id},
      options: Options(
        headers: {'Authorization': 'Bearer ${ApiConfig.apiKey}'},
      ),
    );

    if (response.statusCode == 200) {
      return CoinModel.fromJson(response.data[0]);
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
      '${ApiConfig.baseUrl}/getHistory',
      queryParameters: {'symbol': id, 'days': days},
      options: Options(
        headers: {'Authorization': 'Bearer ${ApiConfig.apiKey}'},
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => HistoricalDataModel.fromJson(json)).toList();
    } else {
      throw ServerFailure();
    }
  }
}

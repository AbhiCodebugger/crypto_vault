import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'features/crypto/domain/repositories/crypto_repository.dart';
import 'features/crypto/data/repositories/crypto_repository_impl.dart';
import 'features/crypto/data/datasources/crypto_remote_data_source.dart';
import 'features/crypto/domain/usecases/get_top_coins.dart';
import 'features/crypto/domain/usecases/get_coin_details.dart';
import 'features/crypto/domain/usecases/get_historical_data.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Crypto

  // Use cases
  sl.registerLazySingleton(() => GetTopCoins(sl()));
  sl.registerLazySingleton(() => GetCoinDetails(sl()));
  sl.registerLazySingleton(() => GetHistoricalData(sl()));

  // Repository
  sl.registerLazySingleton<CryptoRepository>(
    () => CryptoRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CryptoRemoteDataSource>(
    () => CryptoRemoteDataSourceImpl(dio: sl()),
  );

  //! Core

  //! External
  await Hive.initFlutter();
  sl.registerLazySingleton(() => Dio());
}

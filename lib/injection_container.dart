import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'features/crypto/domain/repositories/crypto_repository.dart';
import 'features/crypto/data/repositories/crypto_repository_impl.dart';
import 'features/crypto/data/datasources/crypto_remote_data_source.dart';
import 'features/crypto/domain/usecases/get_top_coins.dart';
import 'features/crypto/domain/usecases/get_coin_details.dart';
import 'features/crypto/domain/usecases/get_historical_data.dart';
import 'features/crypto/domain/repositories/portfolio_repository.dart';
import 'features/crypto/data/repositories/portfolio_repository_impl.dart';
import 'features/crypto/data/datasources/portfolio_local_data_source.dart';
import 'features/crypto/domain/usecases/portfolio_usecases.dart';
import 'features/crypto/data/models/portfolio_item_model.dart';
import 'features/crypto/presentation/bloc/crypto_bloc.dart';
import 'features/crypto/presentation/bloc/chart_bloc.dart';
import 'features/crypto/presentation/bloc/portfolio_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Crypto

  // BLoC
  sl.registerFactory(() => CryptoBloc(getTopCoins: sl(), getCoinDetails: sl()));
  sl.registerFactory(() => ChartBloc(getHistoricalData: sl()));
  sl.registerFactory(
    () => PortfolioBloc(getPortfolio: sl(), addAsset: sl(), removeAsset: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTopCoins(sl()));
  sl.registerLazySingleton(() => GetCoinDetails(sl()));
  sl.registerLazySingleton(() => GetHistoricalData(sl()));
  sl.registerLazySingleton(() => GetPortfolio(sl()));
  sl.registerLazySingleton(() => AddAsset(sl()));
  sl.registerLazySingleton(() => RemoveAsset(sl()));

  // Repository
  sl.registerLazySingleton<CryptoRepository>(
    () => CryptoRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CryptoRemoteDataSource>(
    () => CryptoRemoteDataSourceImpl(dio: sl()),
  );

  final portfolioBox = await Hive.openBox<PortfolioItemModel>('portfolio');
  sl.registerLazySingleton<PortfolioLocalDataSource>(
    () => PortfolioLocalDataSourceImpl(portfolioBox: sl()),
  );

  //! Core

  //! External
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(PortfolioItemModelAdapter());
  }
  sl.registerLazySingleton(() => portfolioBox);
  sl.registerLazySingleton(() => Dio());
}

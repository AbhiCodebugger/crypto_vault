import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'features/crypto/domain/repositories/crypto_repository.dart';
import 'features/crypto/data/repositories/crypto_repository_impl.dart';
import 'features/crypto/data/datasources/crypto_remote_data_source.dart';
import 'features/crypto/domain/usecases/get_top_coins.dart';
import 'features/crypto/domain/usecases/get_coin_details.dart';
import 'features/crypto/domain/usecases/get_historical_data.dart';
import 'features/crypto/domain/repositories/wishlist_repository.dart';
import 'features/crypto/data/repositories/wishlist_repository_impl.dart';
import 'features/crypto/data/datasources/wishlist_local_data_source.dart';
import 'features/crypto/domain/usecases/wishlist_usecases.dart';
import 'features/crypto/data/models/wishlist_item_model.dart';
import 'features/crypto/presentation/bloc/crypto_bloc.dart';
import 'features/crypto/presentation/bloc/chart_bloc.dart';
import 'features/crypto/presentation/bloc/wishlist_bloc.dart';
import 'core/theme/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(WishlistItemModelAdapter());
  }

  //! Features - Crypto

  // BLoC
  sl.registerFactory(() => CryptoBloc(getTopCoins: sl(), getCoinDetails: sl()));
  sl.registerFactory(() => ChartBloc(getHistoricalData: sl()));
  sl.registerFactory(
    () => WishlistBloc(
      getWishlist: sl(),
      addToWishlist: sl(),
      removeFromWishlist: sl(),
    ),
  );
  sl.registerLazySingleton(() => ThemeCubit());

  // Use cases
  sl.registerLazySingleton(() => GetTopCoins(sl()));
  sl.registerLazySingleton(() => GetCoinDetails(sl()));
  sl.registerLazySingleton(() => GetHistoricalData(sl()));
  sl.registerLazySingleton(() => GetWishlist(sl()));
  sl.registerLazySingleton(() => AddToWishlist(sl()));
  sl.registerLazySingleton(() => RemoveFromWishlist(sl()));

  // Repository
  sl.registerLazySingleton<CryptoRepository>(
    () => CryptoRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CryptoRemoteDataSource>(
    () => CryptoRemoteDataSourceImpl(dio: sl()),
  );

  final wishlistBox = await Hive.openBox<WishlistItemModel>('wishlist');
  sl.registerLazySingleton<WishlistLocalDataSource>(
    () => WishlistLocalDataSourceImpl(wishlistBox: sl()),
  );
  sl.registerLazySingleton<Box<WishlistItemModel>>(() => wishlistBox);

  //! Core

  //! External
  sl.registerLazySingleton(() => Dio());
}

import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Crypto

  //! Core

  //! External
  await Hive.initFlutter();
  sl.registerLazySingleton(() => Dio());
}

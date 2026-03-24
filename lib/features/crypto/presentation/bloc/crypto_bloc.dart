import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_top_coins.dart';
import '../../domain/usecases/get_coin_details.dart';
import 'crypto_bloc_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final GetTopCoins getTopCoins;
  final GetCoinDetails getCoinDetails;

  CryptoBloc({required this.getTopCoins, required this.getCoinDetails})
    : super(CryptoInitial()) {
    on<GetTopCoinsEvent>((event, emit) async {
      emit(CryptoLoading());
      final failureOrCoins = await getTopCoins(NoParams());
      failureOrCoins.fold(
        (failure) => emit(const CryptoError('Failed to fetch coins')),
        (coins) => emit(CryptoLoaded(coins)),
      );
    });

    on<GetCoinDetailsEvent>((event, emit) async {
      emit(CryptoLoading());
      final failureOrCoin = await getCoinDetails(
        GetCoinDetailsParams(id: event.id),
      );
      failureOrCoin.fold(
        (failure) => emit(const CryptoError('Failed to fetch coin details')),
        (coin) => emit(CryptoDetailLoaded(coin)),
      );
    });
  }
}

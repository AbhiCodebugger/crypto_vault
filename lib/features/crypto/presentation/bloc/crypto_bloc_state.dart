import 'package:equatable/equatable.dart';
import '../../domain/entities/coin.dart';

sealed class CryptoEvent extends Equatable {
  const CryptoEvent();
  @override
  List<Object?> get props => [];
}

class GetTopCoinsEvent extends CryptoEvent {}

class GetCoinDetailsEvent extends CryptoEvent {
  final String id;
  const GetCoinDetailsEvent(this.id);
  @override
  List<Object?> get props => [id];
}

sealed class CryptoState extends Equatable {
  const CryptoState();
  @override
  List<Object?> get props => [];
}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoLoaded extends CryptoState {
  final List<Coin> coins;
  const CryptoLoaded(this.coins);
  @override
  List<Object?> get props => [coins];
}

class CryptoDetailLoaded extends CryptoState {
  final Coin coin;
  const CryptoDetailLoaded(this.coin);
  @override
  List<Object?> get props => [coin];
}

class CryptoError extends CryptoState {
  final String message;
  const CryptoError(this.message);
  @override
  List<Object?> get props => [message];
}

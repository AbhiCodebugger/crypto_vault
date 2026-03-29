import 'package:equatable/equatable.dart';
import '../../domain/entities/wishlist_item.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();
  @override
  List<Object?> get props => [];
}

class GetWishlistEvent extends WishlistEvent {}

class AddToWishlistEvent extends WishlistEvent {
  final WishlistItem item;
  const AddToWishlistEvent(this.item);
  @override
  List<Object?> get props => [item];
}

class RemoveFromWishlistEvent extends WishlistEvent {
  final String coinId;
  const RemoveFromWishlistEvent(this.coinId);
  @override
  List<Object?> get props => [coinId];
}

sealed class WishlistState extends Equatable {
  const WishlistState();
  @override
  List<Object?> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<WishlistItem> wishlist;
  const WishlistLoaded(this.wishlist);
  @override
  List<Object?> get props => [wishlist];
}

class WishlistError extends WishlistState {
  final String message;
  const WishlistError(this.message);
  @override
  List<Object?> get props => [message];
}

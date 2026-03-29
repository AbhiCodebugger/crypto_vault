import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/wishlist_usecases.dart';
import 'wishlist_bloc_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final GetWishlist getWishlist;
  final AddToWishlist addToWishlist;
  final RemoveFromWishlist removeFromWishlist;

  WishlistBloc({
    required this.getWishlist,
    required this.addToWishlist,
    required this.removeFromWishlist,
  }) : super(WishlistInitial()) {
    on<GetWishlistEvent>((event, emit) async {
      emit(WishlistLoading());
      final failureOrWishlist = await getWishlist(NoParams());
      failureOrWishlist.fold(
        (failure) => emit(const WishlistError('Failed to load wishlist')),
        (wishlist) => emit(WishlistLoaded(wishlist)),
      );
    });

    on<AddToWishlistEvent>((event, emit) async {
      final failureOrVoid = await addToWishlist(AddToWishlistParams(item: event.item));
      failureOrVoid.fold(
        (failure) => emit(const WishlistError('Failed to add to wishlist')),
        (_) => add(GetWishlistEvent()),
      );
    });

    on<RemoveFromWishlistEvent>((event, emit) async {
      final failureOrVoid = await removeFromWishlist(
        RemoveFromWishlistParams(coinId: event.coinId),
      );
      failureOrVoid.fold(
        (failure) => emit(const WishlistError('Failed to remove from wishlist')),
        (_) => add(GetWishlistEvent()),
      );
    });
  }
}

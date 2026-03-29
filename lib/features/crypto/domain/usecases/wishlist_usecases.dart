import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/wishlist_item.dart';
import '../repositories/wishlist_repository.dart';

class GetWishlist
    implements UseCase<Either<Failure, List<WishlistItem>>, NoParams> {
  final WishlistRepository repository;

  GetWishlist(this.repository);

  @override
  Future<Either<Failure, List<WishlistItem>>> call(NoParams params) async {
    return await repository.getWishlist();
  }
}

class AddToWishlist implements UseCase<Either<Failure, void>, AddToWishlistParams> {
  final WishlistRepository repository;

  AddToWishlist(this.repository);

  @override
  Future<Either<Failure, void>> call(AddToWishlistParams params) async {
    return await repository.addToWishlist(params.item);
  }
}

class AddToWishlistParams {
  final WishlistItem item;
  AddToWishlistParams({required this.item});
}

class RemoveFromWishlist implements UseCase<Either<Failure, void>, RemoveFromWishlistParams> {
  final WishlistRepository repository;

  RemoveFromWishlist(this.repository);

  @override
  Future<Either<Failure, void>> call(RemoveFromWishlistParams params) async {
    return await repository.removeFromWishlist(params.coinId);
  }
}

class RemoveFromWishlistParams {
  final String coinId;
  RemoveFromWishlistParams({required this.coinId});
}

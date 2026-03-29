import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/wishlist_item.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_local_data_source.dart';
import '../models/wishlist_item_model.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistLocalDataSource localDataSource;

  WishlistRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<WishlistItem>>> getWishlist() async {
    try {
      final localWishlist = await localDataSource.getWishlist();
      return Right(
        localWishlist.map((model) => model as WishlistItem).toList(),
      );
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addToWishlist(WishlistItem item) async {
    try {
      await localDataSource.addToWishlist(WishlistItemModel.fromEntity(item));
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFromWishlist(String coinId) async {
    try {
      await localDataSource.removeFromWishlist(coinId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

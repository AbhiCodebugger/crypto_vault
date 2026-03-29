import 'package:hive_ce/hive.dart';
import '../models/wishlist_item_model.dart';

abstract class WishlistLocalDataSource {
  Future<List<WishlistItemModel>> getWishlist();
  Future<void> addToWishlist(WishlistItemModel item);
  Future<void> removeFromWishlist(String coinId);
}

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  final Box<WishlistItemModel> wishlistBox;

  WishlistLocalDataSourceImpl({required this.wishlistBox});

  @override
  Future<List<WishlistItemModel>> getWishlist() async {
    return wishlistBox.values.toList();
  }

  @override
  Future<void> addToWishlist(WishlistItemModel item) async {
    await wishlistBox.put(item.id, item);
  }

  @override
  Future<void> removeFromWishlist(String coinId) async {
    await wishlistBox.delete(coinId);
  }
}

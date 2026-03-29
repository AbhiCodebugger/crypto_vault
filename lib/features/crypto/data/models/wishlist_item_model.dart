import 'package:hive_ce/hive.dart';
import '../../domain/entities/wishlist_item.dart';

part 'wishlist_item_model.g.dart';

@HiveType(typeId: 0)
class WishlistItemModel extends WishlistItem {
  @HiveField(0)
  @override
  String get id => super.id;

  @HiveField(1)
  @override
  String get symbol => super.symbol;

  @HiveField(2)
  @override
  String get name => super.name;

  @HiveField(3)
  @override
  double get currentPrice => super.currentPrice;

  @HiveField(4)
  @override
  double get priceChangePercentage24h => super.priceChangePercentage24h;

  @HiveField(5)
  @override
  double get marketCap => super.marketCap;

  @HiveField(6)
  @override
  String get imageUrl => super.imageUrl;

  const WishlistItemModel({
    required super.id,
    required super.symbol,
    required super.name,
    required super.currentPrice,
    required super.priceChangePercentage24h,
    required super.marketCap,
    required super.imageUrl,
  });

  factory WishlistItemModel.fromEntity(WishlistItem entity) {
    return WishlistItemModel(
      id: entity.id,
      symbol: entity.symbol,
      name: entity.name,
      currentPrice: entity.currentPrice,
      priceChangePercentage24h: entity.priceChangePercentage24h,
      marketCap: entity.marketCap,
      imageUrl: entity.imageUrl,
    );
  }
}

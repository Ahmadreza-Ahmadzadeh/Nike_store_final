import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nike_store/data/product.dart';

final favoriteManager = FavoriteManager();

class FavoriteManager {
  static final ValueNotifier<int> changeFavorite = ValueNotifier(0);
  static ValueListenable<Box<ProductEntity>> get listnable =>
      Hive.box<ProductEntity>(_openBox).listenable();
  static const _openBox = "favorites";
  final _box = Hive.box<ProductEntity>(_openBox);

  static init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductEntityAdapter());
    Hive.openBox<ProductEntity>(_openBox);
  }

  void addFavorite(ProductEntity productEntity) {
    changeFavorite.value++;
    _box.put(productEntity.id, productEntity);
  }

  void delete(ProductEntity productEntity) {
    changeFavorite.value++;
    _box.delete(productEntity.id);
  }

  bool isFavorite(ProductEntity productEntity) {
    return _box.containsKey(productEntity.id);
  }

  List<ProductEntity> getAll() {
    return _box.values.toList();
  }
}

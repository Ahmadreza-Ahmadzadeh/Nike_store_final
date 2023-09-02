import 'package:flutter/material.dart';
import 'package:nike_store/common/http_baseUrl.dart';

import '../add_to_cart.dart';
import '../cart_response.dart';
import '../source/cart_dataSource.dart';

final cartRepository = CartRepository(CardRemoteDataSource(httpClient));

abstract class ICartRepository {
  Future<AddToCartResponseEntity> add(int productId);
  Future<CartResponse> getAll();
  Future<AddToCartResponseEntity> changeCount(int cartItemId, int newCount);
  Future<int> count();
  Future<void> delete(int cartId);
}

class CartRepository implements ICartRepository {
  static ValueNotifier<int> changeCountCart = ValueNotifier(0);
  static ValueNotifier<int> changeProductFromDetailScreen = ValueNotifier(0);

  final ICartDataSource dataSource;

  CartRepository(this.dataSource);
  @override
  Future<AddToCartResponseEntity> add(int productId) {
    return dataSource.add(productId);
  }

  @override
  Future<AddToCartResponseEntity> changeCount(int cartItemId, int newCount) {
    return dataSource.changeCount(cartItemId, newCount);
  }

  @override
  Future<int> count() async {
    int count = await dataSource.count();
    changeCountCart.value = count;
    return count;
  }

  @override
  Future<void> delete(int cartId) {
    return dataSource.delete(cartId);
  }

  @override
  Future<CartResponse> getAll() => dataSource.getAll();
}

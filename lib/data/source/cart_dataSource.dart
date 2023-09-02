import 'package:dio/dio.dart';

import '../add_to_cart.dart';
import '../cart_response.dart';
import 'package:nike_store/common/response_validator.dart';

abstract class ICartDataSource {
  Future<AddToCartResponseEntity> add(int productId);
  Future<CartResponse> getAll();
  Future<AddToCartResponseEntity> changeCount(int cartItemId, int newCount);
  Future<int> count();
  Future<void> delete(int cartId);
}

class CardRemoteDataSource with ResponseValidator implements ICartDataSource {
  final Dio httpClient;

  CardRemoteDataSource(this.httpClient);

  @override
  Future<AddToCartResponseEntity> add(int productId) async {
    final response =
        await httpClient.post("cart/add", data: {"product_id": productId});
    validateResponse(response);

    return AddToCartResponseEntity.fromJson(response.data);
  }

  @override
  Future<AddToCartResponseEntity> changeCount(
      int cartItemId, int newCount) async {
    final response = await httpClient.post("cart/changeCount", data: {
      "cart_item_id": cartItemId,
      "count": newCount,
    });
    validateResponse(response);

    return AddToCartResponseEntity.fromJson(response.data);
  }

  @override
  Future<int> count() async {
    final response = await httpClient.get("cart/count");
    validateResponse(response);
    return response.data["count"];
  }

  @override
  Future<void> delete(int cartId) async {
    await httpClient.post("cart/remove", data: {
      "cart_item_id": cartId,
    });
  }

  @override
  Future<CartResponse> getAll() async {
    final response = await httpClient.get("cart/list");
    validateResponse(response);

    return CartResponse.fromJson(response.data);
  }
}

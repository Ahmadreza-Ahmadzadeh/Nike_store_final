import 'dart:convert';

import 'package:nike_store/data/product.dart';

class CartItemEntity {
  final ProductEntity productEntity;
  final int cart_item_id;
  int count;
  bool loadingOnDeleting = false;
  bool loadingOnChangeCount = false;

  CartItemEntity(this.productEntity, this.cart_item_id, this.count);

  CartItemEntity.fromJson(Map<String, dynamic> json)
      : productEntity = ProductEntity.fromJson(json["product"]),
        cart_item_id = json["cart_item_id"],
        count = json["count"];

  static List<CartItemEntity> parseCartItems(List<dynamic> jsonArray) {
    List<CartItemEntity> res = [];
    jsonArray.forEach((element) {
      res.add(CartItemEntity.fromJson(element));
    });
    return res;
  }
}

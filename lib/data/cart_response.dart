import 'package:nike_store/data/cart_item.dart';

class CartResponse {
  final List<CartItemEntity> cartItems;
  int payablePrice;
  int totalPrice;
  int shippingCosts;

  CartResponse(
      this.cartItems, this.payablePrice, this.totalPrice, this.shippingCosts);

  CartResponse.fromJson(Map<String, dynamic> json)
      : cartItems = CartItemEntity.parseCartItems(json["cart_items"]),
        payablePrice = json["payable_price"],
        totalPrice = json["total_price"],
        shippingCosts = json["shipping_cost"];
}

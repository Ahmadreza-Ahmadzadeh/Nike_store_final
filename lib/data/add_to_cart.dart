class AddToCartResponseEntity {
  final int cartItemId;
  final int count;
  final int productId;

  AddToCartResponseEntity(this.cartItemId, this.count, this.productId);

  AddToCartResponseEntity.fromJson(Map<String, dynamic> json)
      : cartItemId = json["id"],
        productId = json["product_id"],
        count = json["count"];
}

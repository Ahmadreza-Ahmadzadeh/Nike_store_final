import 'package:nike_store/data/product.dart';

class HistoryEntity {
  final int id;

  final int payable;

  final List<ProductEntity> products;

  final int countProducts;
  HistoryEntity(this.id, this.payable, this.products, this.countProducts);

  HistoryEntity.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        payable = json["payable"],
        products = (json["order_items"] as List)
            .map((e) => ProductEntity.fromJson(e["product"]))
            .toList(),
        countProducts =
            (json["order_items"] as List).map((e) => e["count"]).toList()[0];
}

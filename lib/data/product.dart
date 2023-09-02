import 'package:hive_flutter/hive_flutter.dart';

part "product.g.dart";

class ProductSort {
  static const int latest = 0;
  static const int popular = 1;
  static const int hifhToLow = 2;
  static const int lowToHigh = 3;

  static List<String> names = [
    "جدیدترین",
    "پربازدیدترین",
    "گران قیمت ترین",
    "ارزان ترین",
  ];
}

@HiveType(typeId: 0)
class ProductEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int price;
  @HiveField(3)
  final int discount;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final int previousPrice;

  ProductEntity(this.id, this.title, this.price, this.discount, this.image,
      this.previousPrice);

  ProductEntity.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        price = json["previous_price"] == null
            ? json["price"] - json["discount"]
            : json["price"],
        discount = json["discount"],
        image = json["image"],
        previousPrice = json["previous_price"] ?? json['price'];
}

class BannerEntity {
  final int id;
  final String image;

  BannerEntity(this.id, this.image);
  BannerEntity.fromJason(Map<String, dynamic> json)
      : id = json["id"],
        image = json["image"];
}

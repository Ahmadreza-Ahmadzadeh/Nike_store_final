import 'package:dio/dio.dart';
import 'package:nike_store/data/banner.dart';

import '../../common/response_validator.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAll();
}

class BannerRemoteDataSource
    with ResponseValidator
    implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource(this.httpClient);
  @override
  Future<List<BannerEntity>> getAll() async {
    final response = await httpClient.get("banner/slider");
    validateResponse(response);
    final banners = <BannerEntity>[];
    (response.data as List).forEach((element) {
      banners.add(BannerEntity.fromJason(element));
    });
    return banners;
  }
}

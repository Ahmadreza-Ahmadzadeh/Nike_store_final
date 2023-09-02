import 'package:nike_store/data/banner.dart';
import 'package:nike_store/data/source/banner_dataSource.dart';

import '../../common/http_baseUrl.dart';

final bannerRepository = BannerRepository(BannerRemoteDataSource(httpClient));

abstract class IBannnerRepository {
  Future<List<BannerEntity>> getAll();
}

class BannerRepository implements IBannnerRepository {
  final IBannerDataSource bannerDataSource;

  BannerRepository(this.bannerDataSource);
  @override
  Future<List<BannerEntity>> getAll() => bannerDataSource.getAll();
}

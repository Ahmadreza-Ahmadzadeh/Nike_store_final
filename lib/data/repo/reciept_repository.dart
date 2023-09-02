import 'package:nike_store/common/http_baseUrl.dart';
import 'package:nike_store/data/reciept.dart';
import 'package:nike_store/data/source/reciept_data_source.dart';

final recieptRepository =
    RecieptRepository(RecieptRemoteDataSource(httpClient));

abstract class IRecieptRepository {
  Future<RecieptResult> checkout(int orderId);
}

class RecieptRepository implements IRecieptRepository {
  final IRecieptDataSource shippingDataSource;

  RecieptRepository(this.shippingDataSource);

  @override
  Future<RecieptResult> checkout(int orderId) {
    return shippingDataSource.checkout(orderId);
  }
}

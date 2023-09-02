import 'package:nike_store/common/http_baseUrl.dart';
import 'package:nike_store/data/order.dart';
import 'package:nike_store/data/source/order_data_source.dart';

final orderRepository = OrderRepository(OrderRemoteDataSource(httpClient));

abstract class IOrderRepository {
  Future<OrderResult> create(OrderParams params);
}

class OrderRepository implements IOrderRepository {
  final IOrderDataSource orderDataSource;

  OrderRepository(this.orderDataSource);
  @override
  Future<OrderResult> create(OrderParams params) {
    return orderDataSource.create(params);
  }
}

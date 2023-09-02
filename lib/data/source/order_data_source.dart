import 'package:dio/dio.dart';
import 'package:nike_store/common/response_validator.dart';
import 'package:nike_store/data/order.dart';

abstract class IOrderDataSource {
  Future<OrderResult> create(OrderParams params);
}

class OrderRemoteDataSource with ResponseValidator implements IOrderDataSource {
  final Dio httpClient;

  OrderRemoteDataSource(this.httpClient);

  @override
  Future<OrderResult> create(OrderParams params) async {
    final response = await httpClient.post("order/submit", data: {
      "first_name": params.name,
      "last_name": params.lastName,
      "address": params.address,
      "postal_code": params.postalCode,
      "mobile": params.mobile,
      "payment_method": params.paymentMethode.toString().split(".")[1]
    });
    validateResponse(response);
    return OrderResult.fromJson(response.data);
  }
}

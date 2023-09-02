import 'package:dio/dio.dart';
import 'package:nike_store/common/response_validator.dart';
import 'package:nike_store/data/reciept.dart';

abstract class IRecieptDataSource {
  Future<RecieptResult> checkout(int orderId);
}

class RecieptRemoteDataSource
    with ResponseValidator
    implements IRecieptDataSource {
  final Dio httpClient;

  RecieptRemoteDataSource(this.httpClient);

  @override
  Future<RecieptResult> checkout(int orderId) async {
    final response = await httpClient.get("order/checkout?order_id=$orderId");
    validateResponse(response);
    return RecieptResult.fromJson(response.data);
  }
}

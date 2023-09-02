import 'package:dio/dio.dart';
import 'package:nike_store/common/response_validator.dart';
import 'package:nike_store/data/history_payment.dart';

abstract class IHistoryDataSource {
  Future<List<HistoryEntity>> getAllHistoryOrder();
}

class HistoryRemoteDataSource
    with ResponseValidator
    implements IHistoryDataSource {
  final Dio httpClient;

  HistoryRemoteDataSource(this.httpClient);
  @override
  Future<List<HistoryEntity>> getAllHistoryOrder() async {
    final response = await httpClient.get("order/list");
    validateResponse(response);
    return (response.data as List)
        .map((e) => HistoryEntity.fromJson(e))
        .toList();
  }
}

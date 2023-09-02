import 'package:nike_store/common/http_baseUrl.dart';
import 'package:nike_store/data/history_payment.dart';
import 'package:nike_store/data/source/history_dataSource.dart';

final historyRepository =
    HistoryRepository(HistoryRemoteDataSource(httpClient));

abstract class IHistoryRepository {
  Future<List<HistoryEntity>> getAllHistoryOrder();
}

class HistoryRepository implements IHistoryRepository {
  final IHistoryDataSource iHistoryDataSource;

  HistoryRepository(this.iHistoryDataSource);
  @override
  Future<List<HistoryEntity>> getAllHistoryOrder() {
    return iHistoryDataSource.getAllHistoryOrder();
  }
}

import 'package:nike_store/data/comment.dart';
import 'package:nike_store/data/source/comment_dataSource.dart';

import '../../common/http_baseUrl.dart';

final commentRepository =
    CommentRepository(CommentRemoteDataSource(httpClient));

abstract class ICommentRepository {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRepository extends ICommentRepository {
  final ICommentDataSource dataSource;

  CommentRepository(this.dataSource);
  @override
  Future<List<CommentEntity>> getAll({required int productId}) {
    return dataSource.getAll(productId: productId);
  }
}

import 'package:dio/dio.dart';
import 'package:nike_store/common/http_baseUrl.dart';
import 'package:nike_store/common/response_validator.dart';
import 'package:nike_store/data/comment.dart';

abstract class ICommentDataSource {
  Future<List<CommentEntity>> getAll({required productId});
}

class CommentRemoteDataSource extends ICommentDataSource
    with ResponseValidator {
  final Dio httpClient;

  CommentRemoteDataSource(this.httpClient);
  @override
  Future<List<CommentEntity>> getAll({required productId}) async {
    final comments = <CommentEntity>[];
    final response = await httpClient.get("comment/list?product_id=$productId");
    validateResponse(response);
    (response.data as List).forEach((element) {
      comments.add(CommentEntity.fromJson(element));
    });
    return comments;
  }
}

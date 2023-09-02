import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/appExeption.dart';
import 'package:nike_store/data/comment.dart';
import 'package:nike_store/data/repo/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository repository;
  final int productId;
  CommentBloc(this.repository, this.productId) : super(CommentLoading()) {
    on<CommentEvent>((event, emit) async {
      if (event is CommentStarted) {
        emit(CommentLoading());
        try {
          final comments = await repository.getAll(productId: productId);
          emit(CommentSuccess(comments));
        } catch (e) {
          emit(CommentError(AppException()));
        }
      }
    });
  }
}

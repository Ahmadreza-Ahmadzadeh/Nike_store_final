part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState {}

class CommentSuccess extends CommentState {
  final List<CommentEntity> data;

  CommentSuccess(this.data);
  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class CommentError extends CommentState {
  final AppException exception;

  CommentError(this.exception);

  @override
  // TODO: implement props
  List<Object> get props => [exception];
}

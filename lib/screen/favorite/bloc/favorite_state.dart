part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteLoading extends FavoriteState {}

class FavoriteError extends FavoriteState {
  final AppException appException;

  const FavoriteError(this.appException);
}

class FavoriteSuccess extends FavoriteState {
  final List<ProductEntity> favoriteList;

  const FavoriteSuccess(this.favoriteList);
}

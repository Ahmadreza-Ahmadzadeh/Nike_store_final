part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteEvent {}

class DeleteFavoriteOnHold extends FavoriteEvent {
  final ProductEntity productEntity;

  const DeleteFavoriteOnHold(this.productEntity);
}

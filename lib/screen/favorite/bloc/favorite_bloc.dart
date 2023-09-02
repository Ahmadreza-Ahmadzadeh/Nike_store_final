import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nike_store/common/appExeption.dart';
import 'package:nike_store/data/favorite_manager.dart';
import 'package:nike_store/data/product.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteLoading()) {
    on<FavoriteEvent>((event, emit) {
      try {
        emit(FavoriteLoading());
        if (event is FavoriteInitial) {
          final resultList = favoriteManager.getAll();
          emit(FavoriteSuccess(resultList));
        } else if (event is DeleteFavoriteOnHold) {
          favoriteManager.delete(event.productEntity);
          final resultList = favoriteManager.getAll();
          emit(FavoriteSuccess(resultList));
        }
      } catch (e) {
        emit(FavoriteError(AppException()));
      }
    });
  }
}

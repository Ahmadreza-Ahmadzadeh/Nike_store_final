part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final AppException messageError;

  HomeError({required this.messageError});

  @override
  List<Object> get props => [messageError];
}

class HomeSuccess extends HomeState {
  final List<BannerEntity> banners;
  final List<ProductEntity> latestProduct;
  final List<ProductEntity> pupolarProduct;

  HomeSuccess(
      {required this.banners,
      required this.latestProduct,
      required this.pupolarProduct});
}

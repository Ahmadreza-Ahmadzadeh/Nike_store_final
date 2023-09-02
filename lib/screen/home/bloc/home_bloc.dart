import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/appExeption.dart';
import 'package:nike_store/data/banner.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/repo/banner_repository.dart';
import 'package:nike_store/data/repo/product_repository.dart';

import '../../../common/appExeption.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannnerRepository bannnerRepository;
  final IProductRepository productRepository;
  HomeBloc({required this.bannnerRepository, required this.productRepository})
      : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      try {
        emit(HomeLoading());
        if (event is HomeStarted || event is HomeRefresh) {
          final banners = await bannnerRepository.getAll();
          final latestProduct =
              await productRepository.getAll(ProductSort.latest);
          final pupolarProduct =
              await productRepository.getAll(ProductSort.popular);
          emit(HomeSuccess(
              banners: banners,
              latestProduct: latestProduct,
              pupolarProduct: pupolarProduct));
        }
      } catch (e) {
        emit(HomeError(messageError: e is AppException ? e : AppException()));
      }
    });
  }
}

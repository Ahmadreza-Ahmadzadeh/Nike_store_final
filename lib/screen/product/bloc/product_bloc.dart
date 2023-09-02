import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/appExeption.dart';

import '../../../data/repo/cart_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ICartRepository repository;
  ProductBloc(this.repository) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is ProductAddCart) {
        try {
          emit(ProductButtonLoading());
          // await Future.delayed(Duration(seconds: 1));
          final result = await repository.add(event.productId);
          await repository.count();
          CartRepository.changeProductFromDetailScreen.value++;
          emit(ProductButtonSuccess());
        } catch (e) {
          emit(ProductButtonError(AppException()));
        }
      }
    });
  }
}

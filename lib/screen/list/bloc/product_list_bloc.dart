import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/appExeption.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/repo/product_repository.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final IProductRepository productRepository;
  ProductListBloc(this.productRepository) : super(ProductListLoading()) {
    on<ProductListEvent>((event, emit) async {
      try {
        if (event is ProductListInitial) {
          final result = await productRepository.getAll(event.sort);
          emit(ProductListSuccess(result, event.sort, ProductSort.names));
        }
      } catch (e) {
        emit(ProductListError(AppException()));
      }
    });
  }
}

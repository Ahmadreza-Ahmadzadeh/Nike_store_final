part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListLoading extends ProductListState {}

class ProductListSuccess extends ProductListState {
  final List<ProductEntity> products;
  final int sort;
  final List<String> sortName;

  const ProductListSuccess(this.products, this.sort, this.sortName);

  @override
  // TODO: implement props
  List<Object> get props => [products, sort, sortName];
}

class ProductListError extends ProductListState {
  final AppException appException;

  ProductListError(this.appException);

  @override
  // TODO: implement props
  List<Object> get props => [appException];
}

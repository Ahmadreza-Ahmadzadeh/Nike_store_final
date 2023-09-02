part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductAddCart extends ProductEvent {
  final int productId;

  ProductAddCart(this.productId);

  @override
  // TODO: implement props
  List<Object> get props => [productId];
}

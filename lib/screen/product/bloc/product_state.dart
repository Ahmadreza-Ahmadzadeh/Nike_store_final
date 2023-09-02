part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductButtonLoading extends ProductState {}

class ProductButtonError extends ProductState {
  final AppException exception;

  ProductButtonError(this.exception);

  @override
  // TODO: implement props
  List<Object> get props => [exception];
}

class ProductButtonSuccess extends ProductState {}

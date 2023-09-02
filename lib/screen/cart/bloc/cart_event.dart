part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {
  final AuthInfo? authInfo;
  final bool isRefreshed;

  const CartStarted(this.authInfo, {this.isRefreshed = false});
}

class CartAuthInfoChanged extends CartEvent {
  final AuthInfo? authInfo;

  const CartAuthInfoChanged(this.authInfo);
}

class CartOnClickedDeleteButton extends CartEvent {
  final int cartItemId;

  const CartOnClickedDeleteButton(this.cartItemId);
}

class CartIncreaseProductCount extends CartEvent {
  final int cartItemId;

  const CartIncreaseProductCount(this.cartItemId);

  @override
  // TODO: implement props
  List<Object> get props => [cartItemId];
}

class CartDecreaseProductCount extends CartEvent {
  final int cartItemId;

  const CartDecreaseProductCount(this.cartItemId);

  @override
  // TODO: implement props
  List<Object> get props => [cartItemId];
}

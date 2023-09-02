part of 'reciept_bloc.dart';

abstract class RecieptEvent extends Equatable {
  const RecieptEvent();

  @override
  List<Object> get props => [];
}

class RecieptReturnHome extends RecieptEvent {}

class RecieptCheckout extends RecieptEvent {
  final int orderId;

  const RecieptCheckout(this.orderId);
}

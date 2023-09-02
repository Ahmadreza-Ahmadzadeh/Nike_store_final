part of 'history_order_bloc.dart';

abstract class HistoryOrderEvent extends Equatable {
  const HistoryOrderEvent();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryOrderEvent {}

part of 'history_order_bloc.dart';

abstract class HistoryOrderState extends Equatable {
  const HistoryOrderState();

  @override
  List<Object> get props => [];
}

class HistoryLoading extends HistoryOrderState {}

class HistoryError extends HistoryOrderState {
  final AppException appException;

  const HistoryError(this.appException);

  @override
  // TODO: implement props
  List<Object> get props => [appException];
}

class HistorySuccess extends HistoryOrderState {
  final List<HistoryEntity> historyOrder;

  const HistorySuccess(this.historyOrder);

  @override
  // TODO: implement props
  List<Object> get props => [historyOrder];
}

part of 'reciept_bloc.dart';

abstract class RecieptState extends Equatable {
  const RecieptState();

  @override
  List<Object> get props => [];
}

class RecieptInitial extends RecieptState {}

class RecieptLoading extends RecieptState {}

class RecieptSuceess extends RecieptState {
  final RecieptResult recieptResult;

  const RecieptSuceess(this.recieptResult);

  @override
  // TODO: implement props
  List<Object> get props => [recieptResult];
}

class RecieptError extends RecieptState {
  final AppException appException;

  const RecieptError(this.appException);

  @override
  // TODO: implement props
  List<Object> get props => [appException];
}

class RecieptReturn extends RecieptState {}

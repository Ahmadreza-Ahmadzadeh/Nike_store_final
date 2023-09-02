import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/appExeption.dart';
import 'package:nike_store/data/history_payment.dart';
import 'package:nike_store/data/repo/history_repository.dart';

part 'history_order_event.dart';
part 'history_order_state.dart';

class HistoryOrderBloc extends Bloc<HistoryOrderEvent, HistoryOrderState> {
  final IHistoryRepository historyRepository;
  HistoryOrderBloc(this.historyRepository) : super(HistoryLoading()) {
    on<HistoryOrderEvent>((event, emit) async {
      try {
        if (event is HistoryInitial) {
          emit(HistoryLoading());
          final result = await historyRepository.getAllHistoryOrder();
          emit(HistorySuccess(result));
        }
      } catch (e) {
        emit(HistoryError(AppException()));
      }
    });
  }
}

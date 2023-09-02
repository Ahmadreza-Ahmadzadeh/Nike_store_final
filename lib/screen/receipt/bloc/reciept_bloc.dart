import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/appExeption.dart';
import 'package:nike_store/data/order.dart';
import 'package:nike_store/data/reciept.dart';
import 'package:nike_store/data/repo/order_repository.dart';
import 'package:nike_store/data/repo/reciept_repository.dart';
import 'package:nike_store/screen/shipping/bloc/shipping_bloc.dart';

part 'reciept_event.dart';
part 'reciept_state.dart';

class RecieptBloc extends Bloc<RecieptEvent, RecieptState> {
  final IRecieptRepository shippingRepository;
  RecieptBloc(this.shippingRepository) : super(RecieptInitial()) {
    on<RecieptEvent>((event, emit) async {
      try {
        if (event is RecieptCheckout) {
          final result = await shippingRepository.checkout(event.orderId);
          emit(RecieptSuceess(result));
        } else if (event is RecieptReturnHome) {
          emit(RecieptReturn());
        }
      } catch (e) {
        emit(RecieptError(AppException()));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/appExeption.dart';
import 'package:nike_store/data/order.dart';
import 'package:nike_store/data/repo/order_repository.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  final IOrderRepository orderRepository;
  ShippingBloc(this.orderRepository) : super(ShippingInitial()) {
    on<ShippingEvent>((event, emit) async {
      try {
        if (event is ShippingCreateOrder) {
          emit(ShippingLoading());
          final result = await orderRepository.create(event.params);
          emit(ShippingSuccess(result));
        }
      } catch (e) {
        ShippingError(AppException());
      }
    });
  }
}

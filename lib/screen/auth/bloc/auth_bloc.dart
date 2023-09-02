import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/appExeption.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isLoginMode;
  final IAuthRepository repository;
  final ICartRepository cartRepository;
  AuthBloc(this.repository,
      {required this.cartRepository, this.isLoginMode = true})
      : super(AuthInitial(isLoginMode)) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is ButtonSaveAuthInfo) {
          emit(AuthLoading(isLoginMode));
          if (isLoginMode) {
            await repository.login(event.username, event.password);
            await cartRepository.count();
            emit(AuthSuccess(isLoginMode));
          } else {
            await repository.register(event.username, event.password);
            emit(AuthSuccess(isLoginMode));
          }
        } else if (event is ButtonChangeMode) {
          isLoginMode = !isLoginMode;
          emit(AuthInitial(isLoginMode));
        }
      } catch (e) {
        emit(AuthError(isLoginMode, AppException()));
      }
    });
  }
}

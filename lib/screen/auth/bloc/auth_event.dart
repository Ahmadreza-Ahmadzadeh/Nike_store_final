part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class ButtonSaveAuthInfo extends AuthEvent {
  final String username;
  final String password;

  const ButtonSaveAuthInfo(this.username, this.password);
}

class ButtonChangeMode extends AuthEvent {}

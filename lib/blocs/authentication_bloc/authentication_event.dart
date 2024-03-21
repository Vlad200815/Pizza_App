part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChange extends AuthenticationEvent {
  final User? user;

  const AuthenticationUserChange(this.user);
}

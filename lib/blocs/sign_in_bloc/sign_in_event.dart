part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInUserChange extends SignInEvent {
  final String email;
  final String password;

  const SignInUserChange({
    required this.email,
    required this.password,
  });
}

class SignUserOutEvent extends SignInEvent {}

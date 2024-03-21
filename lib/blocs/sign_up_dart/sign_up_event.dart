part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SingUpUserChangeEvent extends SignUpEvent {
  final MyUser myUser;
  final String password;

  const SingUpUserChangeEvent(
    this.myUser,
    this.password,
  );
}

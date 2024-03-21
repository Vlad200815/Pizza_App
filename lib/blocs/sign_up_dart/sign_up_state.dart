part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SingUpInitial extends SignUpState {}

class SignUpSuccessState extends SignUpState {}

class SignUpFailureState extends SignUpState {
  final String message;

  const SignUpFailureState({
    required this.message,
  });
}

class SignUpProgress extends SignUpState {}

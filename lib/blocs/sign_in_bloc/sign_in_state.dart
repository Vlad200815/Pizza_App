part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SingInSuccessState extends SignInState {}

class SingInFailureState extends SignInState {
  final String message;

  const SingInFailureState({required this.message});
}

class SingInProgressState extends SignInState {}

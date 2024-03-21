import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;

  SignInBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignInInitial()) {
    on<SignInUserChange>((event, emit) async {
      emit(SingInProgressState());

      try {
        await _userRepository.signIn(event.email, event.password);
        emit(SingInSuccessState());
      } on FirebaseAuthException catch (e) {
        emit(SingInFailureState(message: e.code));
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    on<SignUserOutEvent>((event, emit) async {
      await _userRepository.logOut();
    });
  }
}

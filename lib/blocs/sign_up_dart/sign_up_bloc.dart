import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SingUpInitial()) {
    on<SingUpUserChangeEvent>((event, emit) async {
      emit(SignUpProgress());

      try {
        MyUser user =
            await _userRepository.singUp(event.myUser, event.password);
        await _userRepository.set(user);
        emit(SignUpSuccessState());
      } on FirebaseException catch (e) {
        emit(SignUpFailureState(message: e.code));
      } catch (e) {
        debugPrint(e.toString());
        emit(SignUpFailureState(message: e.toString()));
      }
    });
  }
}

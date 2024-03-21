import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/pizza_repository.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  final PizzaRepo _pizzaRepo;

  FormBloc(this._pizzaRepo) : super(FormInitial()) {
    on<AddOdrenEvent>((event, emit) async {
      emit(FormProgress());
      try {
        await _pizzaRepo.createNewOrder(
          event.orderId,
          event.name,
          event.phoneNumber,
          event.city,
          event.house,
          event.apartament,
          event.payment,
          event.wish,
          event.isRecall,
        );
        emit(FormSuccess());
      } catch (e) {
        emit(FormFailed());
        log(e.hashCode);
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pizza_repository/pizza_repository.dart';

part 'total_event.dart';
part 'total_state.dart';

class TotalBloc extends Bloc<TotalEvent, TotalSumState> {
  TotalBloc() : super(const TotalSumState(total: 0)) {
    on<TotalSumEvent>((event, emit) {
      double total = 0;

      for (var i = 0; i < event.pizzas.length; i++) {
        total += event.pizzas[i].price * event.pizzas[i].itemCount -
            event.pizzas[i].price *
                event.pizzas[i].itemCount *
                event.pizzas[i].discount /
                100;
        debugPrint("$total");
      }

      emit(TotalSumState(total: total));
    });
  }
}

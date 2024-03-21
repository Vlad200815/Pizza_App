import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/pizza_repository.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, ItemState> {
  final PizzaRepo _pizzaCartRepo;
  CounterBloc(this._pizzaCartRepo) : super(const ItemState(counter: 1)) {
    on<AddItemEvent>((event, emit) async {
      try {
        // int counter = 1;
        int counter = state.counter + 1;
        emit(ItemState(counter: counter));
        await _pizzaCartRepo.updateItemCount(
            "itemCount", event.pizzaId, counter);
        List<Pizza> pizzas = await _pizzaCartRepo.getAddedPizzas();
        emit(ItemSuccessState(counter: counter, cartPizzas: pizzas));
      } catch (e) {
        log(e.hashCode);
      }
    });

    on<SubItemEvent>((event, emit) async {
      int counter = state.counter;
      try {
        if (state.counter == 1) {
          await _pizzaCartRepo.deletePizzas(event.pizzaId);
        } else {
          counter = state.counter - 1;
        }

        emit(ItemState(counter: counter));
        await _pizzaCartRepo.updateItemCount(
            "itemCount", event.pizzaId, counter);
        List<Pizza> pizzas = await _pizzaCartRepo.getAddedPizzas();
        emit(ItemSuccessState(counter: counter, cartPizzas: pizzas));
      } catch (e) {
        log(e.hashCode);
      }
    });
  }
}

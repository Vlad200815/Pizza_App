import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pizza_repository/pizza_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final PizzaRepo _pizzaCartRepo;

  CartBloc(this._pizzaCartRepo) : super(CartInitial()) {
    on<GetCartEvent>((event, emit) async {
      emit(CartProgressState());
      try {
        List<Pizza> pizzas = await _pizzaCartRepo.getAddedPizzas();
        emit(CartSuccessState(pizzas));
      } catch (e) {
        emit(CartFailureState());
        debugPrint(e.toString());
      }
    });

    on<AddCartEvent>((event, emit) async {
      emit(CartProgressState());
      try {
        await _pizzaCartRepo.createNewPizzas(
          event.pizzaId,
          event.description,
          event.discount,
          event.price,
          event.isVeg,
          event.macros,
          event.name,
          event.picture,
          event.spicy,
          event.itemCount,
        );
        List<Pizza> pizzas = await _pizzaCartRepo.getAddedPizzas();
        emit(CartSuccessState(pizzas));
      } catch (e) {
        emit(CartFailureState());
        debugPrint(e.toString());
      }
    });

    on<DeleteCartPizzasEvent>((event, emit) async {
      emit(CartProgressState());
      try {
        await _pizzaCartRepo.deletePizzas(event.pizzaId);
        List<Pizza> pizzas = await _pizzaCartRepo.getAddedPizzas();
        emit(CartSuccessState(pizzas));
      } catch (e) {
        emit(CartFailureState());
        debugPrint(e.toString());
      }
    });

    on<DeleteAllPizzaEvent>((event, emit) async {
      emit(CartProgressState());
      try {
        await _pizzaCartRepo.deleteAllPizzas();
        List<Pizza> pizzas = await _pizzaCartRepo.getAddedPizzas();
        emit(CartSuccessState(pizzas));
      } catch (e) {
        emit(CartFailureState());
        debugPrint(e.toString());
      }
    });
  }
}

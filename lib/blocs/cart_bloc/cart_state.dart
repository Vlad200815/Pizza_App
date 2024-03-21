part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartProgressState extends CartState {}

class CartFailureState extends CartState {}

class CartSuccessState extends CartState {
  final List<Pizza> cartPizzas;

  const CartSuccessState(this.cartPizzas);

  @override
  List<Object> get props => [cartPizzas];
}

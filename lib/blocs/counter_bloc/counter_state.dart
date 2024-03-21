part of 'counter_bloc.dart';

class ItemState extends Equatable {
  final int counter;

  const ItemState({required this.counter});

  @override
  List<Object> get props => [counter];
}

class ItemSuccessState extends ItemState {
  final List<Pizza> cartPizzas;

  const ItemSuccessState({
    required super.counter,
    required this.cartPizzas,
  });

  @override
  List<Object> get props => [cartPizzas];
}

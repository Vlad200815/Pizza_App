part of 'counter_bloc.dart';

sealed class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class AddItemEvent extends CounterEvent {
  final String pizzaId;

  const AddItemEvent({required this.pizzaId});
}

class SubItemEvent extends CounterEvent {
  final String pizzaId;

  const SubItemEvent({required this.pizzaId});
}

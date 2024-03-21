part of 'total_bloc.dart';

sealed class TotalEvent extends Equatable {
  const TotalEvent();

  @override
  List<Object> get props => [];
}

class TotalSumEvent extends TotalEvent {
  final List<Pizza> pizzas;

  const TotalSumEvent({required this.pizzas});

  @override
  List<Object> get props => [pizzas];
}

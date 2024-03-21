part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartEvent extends CartEvent {}

class AddCartEvent extends CartEvent {
  final String pizzaId;
  final String description;
  final int discount;
  final int price;
  final bool isVeg;
  final Macros macros;
  final String name;
  final String picture;
  final int spicy;
  final int itemCount;

  const AddCartEvent({
    required this.pizzaId,
    required this.description,
    required this.discount,
    required this.price,
    required this.isVeg,
    required this.macros,
    required this.name,
    required this.picture,
    required this.spicy,
    required this.itemCount,
  });

  @override
  List<Object> get props => [
        pizzaId,
        description,
        discount,
        price,
        isVeg,
        macros,
        name,
        picture,
        spicy,
        itemCount,
      ];
}

class DeleteCartPizzasEvent extends CartEvent {
  final String pizzaId;

  const DeleteCartPizzasEvent({required this.pizzaId});

  @override
  List<Object> get props => [pizzaId];
}

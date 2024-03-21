import 'package:pizza_repository/src/entitites/pizza_entity.dart';
import 'package:pizza_repository/src/models/models.dart';

class Pizza {
  String pizzaId;
  String picture;
  bool isVeg;
  int spicy;
  String name;
  String description;
  int price;
  int discount;
  Macros macros;
  int itemCount;

  Pizza({
    required this.pizzaId,
    required this.description,
    required this.discount,
    required this.isVeg,
    required this.macros,
    required this.name,
    required this.picture,
    required this.price,
    required this.spicy,
    required this.itemCount,
  });

  PizzaEntity toEntity() {
    return PizzaEntity(
      pizzaId: pizzaId,
      isVeg: isVeg,
      description: description,
      discount: discount,
      macros: macros,
      name: name,
      picture: picture,
      price: price,
      spicy: spicy,
      itemCount: itemCount,
    );
  }

  static Pizza fromPizzaEntity(PizzaEntity entity) {
    return Pizza(
      pizzaId: entity.pizzaId,
      isVeg: entity.isVeg,
      description: entity.description,
      discount: entity.discount,
      macros: entity.macros,
      name: entity.name,
      picture: entity.picture,
      price: entity.price,
      spicy: entity.spicy,
      itemCount: entity.itemCount,
    );
  }
}

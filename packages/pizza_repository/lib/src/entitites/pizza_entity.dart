import 'package:pizza_repository/src/entitites/macros_entity.dart';
import 'package:pizza_repository/src/models/models.dart';

class PizzaEntity {
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

  PizzaEntity({
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

  Map<String, Object?> toDocument() {
    return {
      'pizzaId': pizzaId,
      'description': description,
      'discount': discount,
      "isVeg": isVeg,
      'macros': macros.toEntity().toDocument(),
      'name': name,
      'picture': picture,
      'price': price,
      'spicy': spicy,
      'itemCount': itemCount,
    };
  }

  static PizzaEntity fromDocument(Map<String, dynamic> doc) {
    return PizzaEntity(
      pizzaId: doc['pizzaId'],
      description: doc['description'],
      discount: doc['discount'],
      isVeg: doc['isVeg'],
      macros: Macros.fromEntity(
        MacrosEntity.fromDocument(doc['macros']),
      ),
      name: doc['name'],
      picture: doc['picture'],
      price: doc['price'],
      spicy: doc['spicy'],
      itemCount: doc['itemCount'],
    );
  }
}

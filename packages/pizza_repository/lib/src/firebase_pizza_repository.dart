import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:pizza_repository/src/models/form_model.dart';

class FirebasePizzaRepo implements PizzaRepo {
  final pizzaCollection = FirebaseFirestore.instance.collection('pizzas');
  final pizzaCartCollection =
      FirebaseFirestore.instance.collection('addedPizzas');
  final pizzaOrderForm = FirebaseFirestore.instance.collection('orders');

  @override
  Future<List<Pizza>> getPizzas() async {
    try {
      return await pizzaCollection.get().then((value) => value.docs
          .map(
            (e) => Pizza.fromPizzaEntity(
              PizzaEntity.fromDocument(
                e.data(),
              ),
            ),
          )
          .toList());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Pizza>> getAddedPizzas() async {
    try {
      return await pizzaCartCollection.get().then((value) => value.docs
          .map(
            (e) => Pizza.fromPizzaEntity(
              PizzaEntity.fromDocument(
                e.data(),
              ),
            ),
          )
          .toList());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createNewPizzas(
    String pizzaId,
    String description,
    int discount,
    int price,
    bool isVeg,
    Macros macros,
    String name,
    String picture,
    int spicy,
    int itemCount,
  ) async {
    try {
      await pizzaCartCollection.doc(pizzaId).set(
            Pizza(
              pizzaId: pizzaId,
              description: description,
              discount: discount,
              isVeg: isVeg,
              macros: macros,
              name: name,
              picture: picture,
              price: price,
              spicy: spicy,
              itemCount: itemCount,
            ).toEntity().toDocument(),
          );
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createNewOrder(
    String orderId,
    String name,
    int phoneNumber,
    String city,
    int house,
    int apartament,
    String payment,
    String wish,
    bool isRecall,
  ) async {
    try {
      await pizzaOrderForm.doc(orderId).set(
            OrderForm(
                    orderId: orderId,
                    name: name,
                    phoneNumber: phoneNumber,
                    city: city,
                    house: house,
                    apartament: apartament,
                    payment: payment,
                    wish: wish,
                    isRecall: isRecall)
                .toEntity()
                .toDoument(),
          );
    } catch (e) {
      log(e.hashCode);
      rethrow;
    }
  }

  @override
  Future<void> deletePizzas(String pizzaId) async {
    await pizzaCartCollection.doc(pizzaId).delete();
  }

  @override
  Future<void> updateItemCount(String field, pizzaId, var newFieldValue) async {
    await pizzaCartCollection.doc(pizzaId).update({field: newFieldValue});
  }
}

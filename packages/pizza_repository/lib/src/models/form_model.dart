// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pizza_repository/src/entitites/form_entity.dart';

class OrderForm {
  String orderId;
  String name;
  int phoneNumber;
  String city;
  int house;
  int apartament;
  String payment;
  String wish;
  bool isRecall;

  OrderForm({
    required this.orderId,
    required this.name,
    required this.phoneNumber,
    required this.city,
    required this.house,
    required this.apartament,
    required this.payment,
    required this.wish,
    required this.isRecall,
  });

  OrderFormEntity toEntity() {
    return OrderFormEntity(
      orderId: orderId,
      name: name,
      phoneNumber: phoneNumber,
      city: city,
      house: house,
      apartament: apartament,
      payment: payment,
      wish: wish,
      isRecall: isRecall,
    );
  }

  static OrderForm fromEntity(OrderFormEntity entity) {
    return OrderForm(
      orderId: entity.orderId,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      city: entity.city,
      house: entity.house,
      apartament: entity.apartament,
      payment: entity.payment,
      wish: entity.wish,
      isRecall: entity.isRecall,
    );
  }
}

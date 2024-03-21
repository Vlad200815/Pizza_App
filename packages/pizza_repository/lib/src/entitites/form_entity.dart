import 'package:pizza_repository/src/models/form_model.dart';

class OrderFormEntity {
  String orderId;
  String name;
  int phoneNumber;
  String city;
  int house;
  int apartament;
  String payment;
  String wish;
  bool isRecall;

  OrderFormEntity(
      {required this.orderId,
      required this.name,
      required this.phoneNumber,
      required this.city,
      required this.house,
      required this.apartament,
      required this.payment,
      required this.wish,
      required this.isRecall});

  Map<String, Object> toDoument() {
    return {
      "orderId": orderId,
      "name": name,
      "phoneNumber": phoneNumber,
      "city": city,
      "house": house,
      "apartament": apartament,
      "payment": payment,
      "wish": wish,
      "isRecall": isRecall,
    };
  }

  static OrderFormEntity fromDocument(Map<String, dynamic> doc) {
    return OrderFormEntity(
      orderId: doc['orderId'],
      name: doc['name'],
      phoneNumber: doc["phoneNumber"],
      city: doc['city'],
      house: doc['house'],
      apartament: doc['apartament'],
      payment: doc['payment'],
      wish: doc['wish'],
      isRecall: doc['isRecall'],
    );
  }
}

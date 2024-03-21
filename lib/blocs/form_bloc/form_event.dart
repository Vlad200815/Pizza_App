part of 'form_bloc.dart';

sealed class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class AddOdrenEvent extends FormEvent {
  final String orderId;
  final String name;
  final int phoneNumber;
  final String city;
  final int house;
  final int apartament;
  final String payment;
  final String wish;
  final bool isRecall;

  const AddOdrenEvent({
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

  @override
  List<Object> get props => [
        orderId,
        name,
        phoneNumber,
        city,
        house,
        apartament,
        payment,
        wish,
        isRecall,
      ];
}

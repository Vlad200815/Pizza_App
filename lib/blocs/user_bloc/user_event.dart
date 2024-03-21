// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserCreateEvent extends UserEvent {
  final String collName;
  final String docName;
  final String name;
  final String animal;
  final int age;

  const UserCreateEvent({
    required this.collName,
    required this.docName,
    required this.name,
    required this.age,
    required this.animal,
  });
}

class UserUpdateEvent extends UserEvent {
  final String collName;
  final String docName;
  final String field;
  final dynamic newFieldValue;

  const UserUpdateEvent({
    required this.collName,
    required this.docName,
    required this.field,
    required this.newFieldValue,
  });
}

class UserDeleteEvent extends UserEvent {
  final String collName;
  final String docName;

  const UserDeleteEvent({
    required this.collName,
    required this.docName,
  });
}

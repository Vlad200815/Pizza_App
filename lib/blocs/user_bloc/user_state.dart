part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserUnknown extends UserState {}

class UserInitial extends UserState {}

class UserSuccess extends UserState {}

class UserFailed extends UserState {}

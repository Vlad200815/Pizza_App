part of 'form_bloc.dart';

abstract class FormState extends Equatable {
  const FormState();

  @override
  List<Object> get props => [];
}

class FormInitial extends FormState {}

class FormProgress extends FormState {}

class FormSuccess extends FormState {}

class FormFailed extends FormState {}

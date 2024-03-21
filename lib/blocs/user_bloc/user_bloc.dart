import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserUnknown()) {
    on<UserCreateEvent>((event, emit) async {
      await _userRepository.create(
        event.collName,
        event.docName,
        event.name,
        event.animal,
        event.age,
      );
    });
    on<UserUpdateEvent>((event, emit) async {
      await _userRepository.update(
        event.collName,
        event.docName,
        event.field,
        event.newFieldValue,
      );
    });
    on<UserDeleteEvent>((event, emit) async {
      await _userRepository.delete(event.collName, event.docName);
    });
  }
}

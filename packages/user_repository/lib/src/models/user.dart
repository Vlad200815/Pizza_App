import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/entity.dart';

class MyUser extends Equatable {
  final String name;
  final String email;
  final String userId;

  const MyUser({
    required this.name,
    required this.email,
    required this.userId,
  });

  MyUser copyWith({
    String? name,
    String? email,
    String? userId,
  }) {
    return MyUser(
      email: email ?? this.email,
      name: name ?? this.name,
      userId: userId ?? this.email,
    );
  }

  static const empty = MyUser(
    name: "",
    email: "",
    userId: "",
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
      name: name,
      userId: userId,
      email: email,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      name: entity.name,
      email: entity.email,
      userId: entity.userId,
    );
  }

  @override
  List<Object?> get props => [name, email, userId];
}

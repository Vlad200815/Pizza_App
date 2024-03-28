import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/entity.dart';

class MyUser extends Equatable {
  final String name;
  final String email;
  final String userId;
  final bool isAdmin;

  const MyUser({
    required this.name,
    required this.email,
    required this.userId,
    required this.isAdmin,
  });

  MyUser copyWith({
    String? name,
    String? email,
    String? userId,
    bool? isAdmin,
  }) {
    return MyUser(
      isAdmin: isAdmin ?? this.isAdmin,
      email: email ?? this.email,
      name: name ?? this.name,
      userId: userId ?? this.email,
    );
  }

  static const empty = MyUser(
    isAdmin: false,
    name: "",
    email: "",
    userId: "",
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
      name: name,
      userId: userId,
      email: email,
      isAdmin: isAdmin,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      name: entity.name,
      email: entity.email,
      userId: entity.userId,
      isAdmin: entity.isAdmin,
    );
  }

  @override
  List<Object?> get props => [name, email, userId, isAdmin];
}

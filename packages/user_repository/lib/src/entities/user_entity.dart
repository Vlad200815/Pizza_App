import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String name;
  final String email;
  final String userId;

  const MyUserEntity({
    required this.name,
    required this.email,
    required this.userId,
  });

  Map<String, Object?> toDocument() {
    return {
      "name": name,
      "email": email,
      'userId': userId,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      name: doc['name'],
      userId: doc['userId'],
      email: doc['email'],
    );
  }

  @override
  List<Object?> get props => [name, email, userId];
}

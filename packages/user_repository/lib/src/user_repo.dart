import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/model.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<void> signIn(String email, String password);

  Future<MyUser> singUp(MyUser myUser, String password);

  Future<void> set(MyUser myUser);

  Future<void> logOut();

  Future<void> resetPassword(String email);

  Future<MyUser> getMyUser(String userId);

  Future<void> create(String collName, docName, name, animal, int age);

  Future<void> update(String collName, docName, field, var newFieldValue);

  Future<void> delete(String collName, docName);
}

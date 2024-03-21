import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:user_repository/user_repository.dart';

class FirebaseRepository implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection("users");

  FirebaseRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> singUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );

      myUser = myUser.copyWith(userId: user.user!.uid);

      return myUser;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> set(MyUser myUser) async {
    try {
      await userCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<MyUser> getMyUser(String userId) {
    try {
      return userCollection.doc(userId).get().then(
            (value) => MyUser.fromEntity(
              MyUserEntity.fromDocument(
                value.data()!,
              ),
            ),
          );
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> create(String collName, docName, name, animal, int age) async {
    try {
      await FirebaseFirestore.instance
          .collection(collName)
          .doc(docName)
          .set({"name": name, "animal": animal, 'age': age});
      debugPrint("Database Updated");
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> update(
      String collName, docName, field, var newFieldValue) async {
    try {
      await FirebaseFirestore.instance
          .collection(collName)
          .doc(docName)
          .update({field: newFieldValue});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> delete(String collName, docName) async {
    try {
      await FirebaseFirestore.instance
          .collection(collName)
          .doc(docName)
          .delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

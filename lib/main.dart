import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just/auth/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:just/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';
import 'auth/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(FirebaseRepository()));
  Bloc.observer = SimpleBlocObserver();
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just/app_view.dart';
import 'package:just/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:just/blocs/cart_bloc/cart_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(FirebasePizzaRepo()),
      child: RepositoryProvider(
        create: (context) => AuthenticationBloc(
          userRepository: userRepository,
        ),
        child: const MyAppView(),
      ),
    );
  }
}

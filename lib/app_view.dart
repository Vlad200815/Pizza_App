import 'package:flutter/material.dart';
import 'package:just/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:just/blocs/cart_bloc/cart_bloc.dart';
import 'package:just/blocs/get_pizza_bloc/get_pizza_bloc.dart';
import 'package:just/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:just/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just/screens/wellcome_screen.dart';
import 'package:pizza_repository/pizza_repository.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade100,
          onSurface: Colors.black,
          primary: Colors.blue,
          onPrimary: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository,
                  ),
                ),
                BlocProvider(
                  create: (context) => GetPizzaBloc(
                    FirebasePizzaRepo(),
                  )..add(GetPizza()),
                ),
                BlocProvider(
                  create: (context) => CartBloc(
                    FirebasePizzaRepo(),
                    // )..add(
                    //     GetCartEvent(),
                  ),
                ),
              ],
              child: const HomeScreen(),
            );
          } else {
            return const WellcomeScreen();
          }
        },
      ),
    );
  }
}

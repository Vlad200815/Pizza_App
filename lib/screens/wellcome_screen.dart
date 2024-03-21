import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:just/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:just/blocs/sign_up_dart/sign_up_bloc.dart';
import 'package:just/screens/sign_in_screen.dart';
import 'package:just/screens/sign_up_screen.dart';

class WellcomeScreen extends StatefulWidget {
  const WellcomeScreen({super.key});

  @override
  State<WellcomeScreen> createState() => _WellcomeScreenState();
}

class _WellcomeScreenState extends State<WellcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(20, -1.2),
                child: Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-2.7, -1.2),
                child: Container(
                  height: MediaQuery.of(context).size.width / 1.3,
                  width: MediaQuery.of(context).size.width / 1.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              // Align(
              //   alignment: const AlignmentDirectional(2.7, -1.2),
              //   child: Container(
              //     height: MediaQuery.of(context).size.width / 1.3,
              //     width: MediaQuery.of(context).size.width / 1.3,
              //     decoration: const BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: Colors.deepPurple,
              //     ),
              //   ),
              // ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 100.0,
                  sigmaY: 100.0,
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 150),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Wellcome 👏",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Good to see you back !",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.8,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50.0,
                        ),
                        child: TabBar(
                          controller: tabController,
                          unselectedLabelColor:
                              Colors.transparent.withOpacity(0.5),
                          labelColor: Colors.black,
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                "Sing In",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                "Sing Up",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                        controller: tabController,
                        children: [
                          BlocProvider(
                            create: (context) => SignInBloc(
                              userRepository: context
                                  .read<AuthenticationBloc>()
                                  .userRepository,
                            ),
                            child: const SignInScreen(),
                          ),
                          BlocProvider(
                            create: (context) => SignUpBloc(
                              userRepository: context
                                  .read<AuthenticationBloc>()
                                  .userRepository,
                            ),
                            child: const SignUpScreen(),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

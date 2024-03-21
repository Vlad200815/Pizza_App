import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just/blocs/sign_up_dart/sign_up_bloc.dart';
import 'package:just/screens/widgets/mybutton_widget.dart';
import 'package:just/screens/widgets/mytextfield_widget.dart';
import 'package:user_repository/user_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                MyTextField(
                  keyboardType: TextInputType.emailAddress,
                  radius: 20,
                  vertical: 10,
                  horizontal: 18,
                  prefixIcon: const Icon(CupertinoIcons.person_alt),
                  hint: "name",
                  controller: nameController,
                ),
                MyTextField(
                  keyboardType: TextInputType.emailAddress,
                  radius: 20,
                  vertical: 10,
                  horizontal: 18,
                  prefixIcon: const Icon(CupertinoIcons.mail_solid),
                  hint: "email",
                  controller: emailController,
                ),
                MyTextField(
                  keyboardType: TextInputType.emailAddress,
                  radius: 20,
                  vertical: 10,
                  horizontal: 18,
                  prefixIcon: const Icon(CupertinoIcons.lock_fill),
                  hint: "password",
                  controller: passwordController,
                ),
                MyButton(
                  radius: 20,
                  color: Theme.of(context).colorScheme.primary,
                  text: 'Sign Up',
                  onPressed: () {
                    MyUser myUser = MyUser.empty;
                    myUser = myUser.copyWith(
                      email: emailController.text,
                      name: nameController.text,
                    );

                    // myUser.email = emailController.text;
                    // myUser.name = nameController;
                    setState(() {
                      context.read<SignUpBloc>().add(
                            SingUpUserChangeEvent(
                              myUser,
                              passwordController.text,
                            ),
                          );
                    });
                    BlocListener<SignUpBloc, SignUpState>(
                      listener: (context, state) {
                        if (passwordController.text != "") {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              });

                          if (state == SignUpSuccessState()) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                    );
                  },
                ),
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    if (state is SignUpProgress) {
                      return const SizedBox(
                        height: 20,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

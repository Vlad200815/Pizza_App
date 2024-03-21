import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:just/screens/widgets/mybutton_widget.dart';
import 'package:just/screens/widgets/mytextfield_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void singInUser() {
    context.read<SignInBloc>().add(
          SignInUserChange(
            email: emailController.text,
            password: passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              MyTextField(
                keyboardType: TextInputType.emailAddress,
                radius: 20,
                vertical: 10,
                horizontal: 18,
                hint: "email",
                controller: emailController,
                prefixIcon: const Icon(
                  CupertinoIcons.mail_solid,
                ),
              ),
              MyTextField(
                keyboardType: TextInputType.emailAddress,
                radius: 20,
                vertical: 10,
                horizontal: 18,
                hint: "password",
                controller: passwordController,
                prefixIcon: const Icon(
                  CupertinoIcons.lock_fill,
                ),
              ),
              const SizedBox(height: 40),
              MyButton(
                radius: 20,
                color: Theme.of(context).colorScheme.primary,
                text: 'Sign In',
                onPressed: singInUser,
              ),
              const SizedBox(height: 10),
              BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state) {
                  if (state is SingInProgressState) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

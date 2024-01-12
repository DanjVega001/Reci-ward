import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/user_entity.dart';
import 'package:reciward_flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_button.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Reciward',
        ),
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: Pallete.color1,
      ),
      backgroundColor: Pallete.color1,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is AuthenticatedState) {
            Navigator.pushNamed(context, '/home');
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
  padding: const EdgeInsets.all(12.0),
  child: ListView(
    children: <Widget>[
      AuthFormField(
        label: 'Email',
        controller: emailController,
        type: TextInputType.emailAddress,
      ),
      const SizedBox(
        height: 10.0,
      ),
      AuthFormField(
        label: 'Password',
        controller: passwordController,
        type: TextInputType.text,
        isPassword: true,
      ),
      const SizedBox(
        height: 10.0,
      ),
      AuthFormButton(
        onPressed: () {
          BlocProvider.of<AuthBloc>(context).add(AuthLoginRequested(
              userEntity: UserEntity(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim())));
        },
        text: 'Login',
      ),
      const SizedBox(
        height: 10.0,
      ),
      AuthFormButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, '/signup');
        },
        text: 'Sign up',
      ),
    ],
  ),
);

        },
      ),
    );
  }
}

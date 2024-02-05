import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_button.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_field.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {

    String token =
        ModalRoute.of(context)?.settings.arguments as String;


    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset password'),
        backgroundColor: Pallete.color1,
        foregroundColor: Pallete.colorWhite,
      ),
      backgroundColor: Pallete.color1,
      body: BlocListener<AuthBloc, AuthState>(
        listener: ((context, state) {
            print("STATE $state");
          
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AuthInitialLogin) {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false, arguments: false);
          }
        }),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              AuthFormField(
                label: 'New password',
                controller: passwordController,
                type: TextInputType.text,
                isPassword: true,
              ),
              const SizedBox(
                height: 10.0,
              ),
              AuthFormField(
                label: 'Confirm password',
                controller: confirmPassword,
                type: TextInputType.text,
                isPassword: true,
              ),
              const SizedBox(
                height: 10.0,
              ),
              AuthFormButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(ResetPasswordRequested(
                      password: passwordController.text.trim(),
                      confirmPassword: confirmPassword.text.trim(),
                      token: token));
                },
                text: 'Reset password',
              )
            ],
          ),
        ),
      ),
    );
  }
}

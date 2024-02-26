import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/core/widgets/snackbar_reciward.dart';
import 'package:reciward_flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_button.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_field.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    int token = ModalRoute.of(context)?.settings.arguments as int;

    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    return Scaffold(
      backgroundColor: Pallete.colorWhite,
      body: BlocListener<AuthBloc, AuthState>(
        listener: ((context, state) {

          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(MySnackBar.showSnackBar(state.error, true));
          } else if (state is AuthInitialLogin) {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false,
                arguments: false);
          }
        }),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Image(image: AssetImage("assets/images/logo_reciward.jpg")),
              const Text(
                "Reset Password",
                style: TextStyle(
                    color: Pallete.colorBlack,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your new password.",
                style: TextStyle(
                    color: Pallete.colorGrey3,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.start,
              ),
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

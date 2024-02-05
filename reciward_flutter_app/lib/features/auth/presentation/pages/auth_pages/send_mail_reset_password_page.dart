import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_button.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_field.dart';

class SendMailResetPasswordPage extends StatelessWidget {
  const SendMailResetPasswordPage({super.key});


  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reset password via email'
        ),
        backgroundColor: Pallete.color1,
        foregroundColor: Pallete.colorWhite,
      ),
      backgroundColor: Pallete.color1,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SendMailFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is SendMailSuccess) {
            print(state.message);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          }
       },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              AuthFormField(label: 'Email', controller: emailController, type: TextInputType.emailAddress),
              const SizedBox(height: 10.0,),
              AuthFormButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(SendMailRequested(
                    email: emailController.text.trim()
                  ));
                },
                text: 'Send email',
              )
            ],
          ),
        ),
      ),

    );
  }
}
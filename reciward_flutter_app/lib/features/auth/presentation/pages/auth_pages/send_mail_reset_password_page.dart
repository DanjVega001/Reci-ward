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
      appBar: AppBar(),
      backgroundColor: Pallete.colorWhite,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SendMailFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is SendMailSuccess) {            
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pushNamed(context, "/verify-password", arguments: state.code);
          }
       },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(image: AssetImage("assets/images/logo_reciward.jpg")),
                const Text(
                  "Reset password via email",
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
                  "Enter your email.",
                  style: TextStyle(
                      color: Pallete.colorGrey3,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 10,
                ),
                AuthFormField(label: 'Email', controller: emailController, type: TextInputType.emailAddress),
                const SizedBox(height: 20.0,),
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
      ),

    );
  }
}
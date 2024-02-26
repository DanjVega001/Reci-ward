import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reciward_flutter_app/features/auth/presentation/widgets/form_button.dart';

class VerificationReserPassword extends StatelessWidget {
  VerificationReserPassword({super.key});
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Verifica que eres tú',
          style: TextStyle(
              fontSize: 18, fontFamily: 'Ubuntu', fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        foregroundColor: Pallete.colorBlack,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SendVerificationResetPasswordFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
            BlocProvider.of<AuthBloc>(context).add(RecoverInvalidCode(code: state.code!,));
          }
          if (state is SendVerificationResetPasswordSuccess) {
            Navigator.pushNamed(context, '/reset-password', arguments: state.code);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is SendMailSuccess) {
            return Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const Text(
                    'Se ha enviado un correo de verificación a tu correo registrado. Ingresa el codigo que te aparece allí',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w700),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 45,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 30,
                    ),
                    controller: codeController,
                    decoration: const InputDecoration(
                        labelText: "Ingrese el codigo",
                        focusColor: Colors.white,
                        border: UnderlineInputBorder(),
                        labelStyle: TextStyle(
                            color: Pallete.colorGrey3,
                            fontFamily: 'Ubuntu',
                            fontSize: 20)),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AuthFormButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                          SendVerificationResetPasswordRequested(
                              code: state.code,
                              enterCode:
                                  int.parse(codeController.text.trim())));
                    },
                    text: "Confirmar código",
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
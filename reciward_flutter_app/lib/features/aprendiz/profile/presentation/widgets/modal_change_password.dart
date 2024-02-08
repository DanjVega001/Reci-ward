import 'package:flutter/material.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/presentation/widgets/update_user_form_field.dart';

// ignore: must_be_immutable
class ModalChangePassword extends StatelessWidget {
  Function(String, String, String, bool) onChangePassword;
  bool editar;

  ModalChangePassword(
      {super.key, required this.onChangePassword, required this.editar});

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController oldPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool updatePassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          const Text(
            "Editar contraseña",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 20,
          ),
          UpdateUserFormField(
            controller: oldPasswordController,
            editar: editar,
            label: "Old password",
            type: TextInputType.text,
            isPassword: true,
          ),
          UpdateUserFormField(
            controller: passwordController,
            editar: editar,
            label: "New password",
            type: TextInputType.text,
            isPassword: true,
          ),
          UpdateUserFormField(
            controller: confirmPasswordController,
            editar: editar,
            label: "Confirm password",
            type: TextInputType.text,
            isPassword: true,
          ),
          const SizedBox(
            height: 25,
          ),
          TextButton(
            onPressed: () {
              onChangePassword(
                  oldPasswordController.text.trim(),
                  passwordController.text.trim(),
                  confirmPasswordController.text.trim(),
                  updatePassword = true);
              //Navigator.pop(context);
            },
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Pallete.color1)),
            child: const Text(
              "Save Password",
              style: TextStyle(color: Pallete.colorWhite),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class UpdateUserFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;
  final bool editar;
  final bool? isPassword;
  const UpdateUserFormField(
      {super.key,
      required this.controller,
      required this.type,
      required this.label,
      required this.editar,
      this.isPassword});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          "$label:",
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextField(
            obscureText: isPassword == null ? false : true,
            enabled: !editar,
            controller: controller,
            keyboardType: type,
          ),
        )
      ],
    );
  }
}

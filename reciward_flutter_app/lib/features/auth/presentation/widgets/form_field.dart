import 'package:flutter/material.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';

class AuthFormField extends StatelessWidget {

  final String label;
  final TextEditingController controller;
  final TextInputType type;
  final bool ? isPassword;
  const AuthFormField({super.key, required this.label, required this.controller, required this.type,
  this.isPassword});
  @override
  Widget build(BuildContext context) {
    return 
       TextFormField(
        style: const TextStyle(
          color: Pallete.colorBlack,
          fontWeight: FontWeight.w700,
          fontFamily:'Ubuntu',
        ),
        keyboardType: type,
        obscureText: isPassword==null ? false : true,
        decoration: InputDecoration(
          labelText: label,
          focusColor: Colors.white,
          border: const UnderlineInputBorder(),
          labelStyle: const TextStyle(color: Pallete.colorGrey3, fontFamily:'Ubuntu',)
        ),
        controller: controller,
      
    );
  }
}

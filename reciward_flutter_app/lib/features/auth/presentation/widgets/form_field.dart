import 'package:flutter/material.dart';

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
        keyboardType: type,
        obscureText: isPassword==null ? false : true,
        decoration: InputDecoration(
          labelText: label,
          focusColor: Colors.white,
          border: const OutlineInputBorder( ),
          labelStyle: const TextStyle(color: Colors.white)
        ),
        controller: controller,
      
    );
  }
}

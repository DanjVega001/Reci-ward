import 'package:flutter/material.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';

class AuthFormButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const AuthFormButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            //Pallete.color1,
            Pallete.color2,
            Pallete.color3,
            Pallete.color4,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 19,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}
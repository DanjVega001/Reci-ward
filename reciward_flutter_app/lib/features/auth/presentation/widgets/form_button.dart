import 'package:flutter/material.dart';
import 'package:reciward_flutter_app/core/constants/pallete_colors.dart';

class AuthFormButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const AuthFormButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Pallete.color1,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Pallete.colorWhite,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily:'Ubuntu',
            ),
          ),
        ),
      ),
    );
    /*ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        backgroundColor: const MaterialStatePropertyAll(Pallete.color1),
        
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Pallete.colorWhite
        ),
      ),
    );*/
  }
}
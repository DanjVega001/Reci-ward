import 'package:flutter/material.dart';

class MySnackBar {
  static SnackBar showSnackBar(String text, bool isError) {
    Color color;
    IconData icon;

    if (isError) {
      color = Colors.red[700]!;
      icon = Icons.error;
    } else {
      icon = Icons.check_circle;
      color = Colors.green[700]!;
    }

    return SnackBar(
      content: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(
              width: 5,
            ),
            Text(text),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

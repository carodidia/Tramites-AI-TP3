// snack_bar_widget.dart
import 'package:flutter/material.dart';

class SnackBarWidget {
  static void show(BuildContext context, String mensaje, Color color) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(
        mensaje,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

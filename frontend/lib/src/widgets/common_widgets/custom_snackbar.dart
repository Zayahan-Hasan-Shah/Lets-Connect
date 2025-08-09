import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required Color backgroundColor,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

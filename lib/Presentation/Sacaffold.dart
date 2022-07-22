import 'package:flutter/material.dart';

void ShowScaffold(BuildContext context, final String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(title),
    duration: const Duration(seconds: 1),
    backgroundColor: Colors.black,
  ));
}

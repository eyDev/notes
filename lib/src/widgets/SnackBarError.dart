import 'package:flutter/material.dart';

void showInSnackBar(BuildContext context, String text, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: 1500),
      backgroundColor: color,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    ),
  );
}

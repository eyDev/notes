import 'package:flutter/material.dart';

class Constants {
  static final Constants _instancia = new Constants._();
  factory Constants() {
    return _instancia;
  }
  Constants._();

  List<Color> get colors {
    return [
      Color(0xFFFF80AB),
      Color(0xFFFFB74C),
      Color(0xFFFFD54E),
      Color(0xFFAED581),
      Color(0xFF4EC3F7),
      Color(0xFFE1BEE7),
    ];
  }

  Color get primaryColor => Color.fromRGBO(104, 117, 245, 1);
  Color get bgColor => Color.fromRGBO(29, 35, 48, 1);
}

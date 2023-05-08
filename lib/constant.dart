import 'package:flutter/material.dart';

class Constant {
  static Color White = Color.fromRGBO(247, 239, 234, 1);
  static Color Background = Color.fromRGBO(223, 201, 189, 1);
  static Color Yellow = Color.fromRGBO(232, 153, 77, 1);
  static Color Red = Color.fromRGBO(200, 77, 43, 1);
  static Color Creamy = Color.fromRGBO(180, 162, 145, 1);
  static Color Green = Color.fromRGBO(85, 107, 47, 1);
}

class Auth {
  String label;
  String value;

  Auth(String this.label, String this.value);
}

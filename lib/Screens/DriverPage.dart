import 'package:rayto/Models/User.dart';
import 'package:flutter/material.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({super.key, required this.user});
  final User user;
  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

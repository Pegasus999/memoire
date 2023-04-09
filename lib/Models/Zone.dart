import 'package:admins/Models/Kid.dart';

class Zone {
  int id = 0;
  String name = '';
  String? kidId;
  String? userId;

  Zone.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        kidId = json['kidId'],
        userId = json['userId'];
}

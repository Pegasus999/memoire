import 'dart:async';
import 'package:admins/Models/Zone.dart';
import 'package:admins/Models/Flags.dart';

class Kid {
  String id = '';
  String name = '';
  String lastname = '';
  String parentId = '';
  DateTime birthday;
  String picture = '';
  List<Flag>? flag = [];
  Zone? zone;
  String grade;
  String? phone;
  String position;

  Kid.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        lastname = json['lastname'],
        phone = json["User"]["phone"] != null ? json["User"]["phone"] : null,
        parentId = json['userId'],
        picture = json['picture'],
        position = json['position'],
        grade = json['grade'],
        birthday = DateTime.parse(json['birthday']),
        flag = json['flags'] != null
            ? json['flags'].map((json) => Flag.fromJson(json)).toList()
            : null,
        zone = json['zone'] != null ? Zone.fromJson(json['zone']) : null;

  static List<Kid> parseKids(List<dynamic> kids) {
    return kids.map((json) => Kid.fromJson(json)).toList();
  }
}

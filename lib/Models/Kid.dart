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
  Zone zone;
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
        position = json['position'] == "HOME"
            ? 'في المنزل'
            : json["position"] == "ROAD"
                ? "في الطريق"
                : "في الروضة",
        grade = json['grade'],
        birthday = DateTime.parse(json['birthday']),
        flag = json['flags'] != null && json['flags'].length != 0
            ? Flag.parseFlags(json['flags'])
            : null,
        zone = Zone.fromJson(json['User']["zone"]);

  static List<Kid> parseKids(List<dynamic> kids) {
    return kids.map((json) => Kid.fromJson(json)).toList();
  }
}

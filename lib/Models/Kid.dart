import 'dart:async';
import 'dart:convert';
import 'package:rayto/Models/Zone.dart';
import 'package:rayto/Models/Flags.dart';

class Kid {
  String id = '';
  String name = '';
  String lastname = '';
  String parentId = '';
  DateTime birthday;
  String picture = '';
  Zone zone;
  String school;
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
        school = json['school'],
        birthday = json['birthday'],
        zone = Zone.fromJson({"name": json['User']['zone']['name']});

  static List<Kid> parseKids(List<dynamic> kids) {
    return kids.map((json) => Kid.fromJson(json)).toList();
  }
}

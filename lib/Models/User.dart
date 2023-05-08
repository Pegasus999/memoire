import 'dart:async';
import 'package:rayto/Models/Kid.dart';
import 'package:rayto/Models/Zone.dart';
import 'package:rayto/Models/Notification.dart';

class User {
  String id = '';
  String name = '';
  String lastname = '';
  String phone = '';
  String adress = '';
  DateTime? subscription;
  String auth = '';
  Zone? zone;
  String gender;
  String picture = '';
  List<Kid>? kids;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        lastname = json['lastname'],
        phone = json['phone'],
        adress = json['adress'],
        auth = json['auth'],
        picture = json['picture'],
        subscription = json['subscription'] != null
            ? DateTime.parse(json['subscription'])
            : null, //
        zone = json['zone'] != null ? Zone.fromJson(json['zone']) : null,
        kids = json['kids'] != null ? Kid.parseKids(json['kids']) : null,
        gender = json['gender'] != null ? "FEMALE" : "MALE";

  static List<User> parseUser(List<dynamic> users) {
    return users.map((json) => User.fromJson(json)).toList();
  }
}

import 'dart:async';
import 'package:admins/Models/Kid.dart';
import 'package:admins/Models/Zone.dart';
import 'package:admins/Models/Notification.dart';

class User {
  String id = '';
  String username = '';
  String password = '';
  String name = '';
  String lastname = '';
  String phone = '';
  String adress = '';
  DateTime? subscription;
  String auth = '';
  Zone? zone;
  String picture = '';
  List<Kid>? kids;
  List<Notifications>? notifications;

  User(
      this.id,
      this.name,
      this.lastname,
      this.username,
      this.password,
      this.auth,
      this.phone,
      this.adress,
      this.zone,
      this.picture,
      this.subscription,
      this.kids,
      this.notifications);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        username = json['username'],
        password = json['password'],
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
        notifications = json['notifications'] != null
            ? Notifications.parseNotif(json['notifications'])
            : null;

  static List<User> parseUser(List<dynamic> users) {
    return users.map((json) => User.fromJson(json)).toList();
  }
}
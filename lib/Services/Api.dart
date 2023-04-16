import 'dart:convert';
import 'package:admins/Models/Flags.dart';
import 'package:admins/Models/Kid.dart';
import 'package:admins/Screens/HomePage.dart';
import 'package:admins/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:admins/Models/User.dart';
import 'package:admins/Models/Notification.dart';

class API {
  static Future<void> login(
      String username, String password, BuildContext context) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final url = Uri.parse('http://10.0.2.2:5000/api/auth/signin');
      final body = jsonEncode({'username': username, 'password': password});

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var user = User.fromJson(jsonDecode(response.body));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => HomePage(
                      user: user,
                    ))));
        ;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      //   // Handle any exceptions that occurred during the request
      print('Request failed with error: $error');
    }
  }

  static Future<List<User>?> getUsers(Function(List<User>) updateState) async {
    var baseUrl = "http://10.0.2.2:5000/api/";
    var type = "user/getAll";
    var url = Uri.parse('${baseUrl}${type}');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    if (data.runtimeType == String) {
      return null;
    }
    List<User> loadedUsers = User.parseUser(data);
    updateState(loadedUsers);
    return User.parseUser(data);
  }

  static Future<List<Notifications>?> getNotifications(
      Function(List<Notifications>) updateState) async {
    var baseUrl = "http://10.0.2.2:5000/api/";
    var type = "notif/getAll";
    var url = Uri.parse('${baseUrl}${type}');
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    if (data.runtimeType == String) {
      return null;
    }
    List<Notifications> loadedNotif = Notifications.parseNotif(data);
    print(loadedNotif);
    updateState(loadedNotif);
    return Notifications.parseNotif(data);
  }

  static Future<List<Kid>?> getKids(Function(List<Kid>) updateState) async {
    try {
      var baseUrl = "http://10.0.2.2:5000/api/";
      var type = "kids/getAll";
      var url = Uri.parse('${baseUrl}${type}');
      var response = await http.get(url);
      var data = jsonDecode(response.body);
      if (data.runtimeType == String) {
        return null;
      }
      List<Kid> loadedKids = Kid.parseKids(data);
      updateState(loadedKids);
      return Kid.parseKids(data);
    } catch (err) {
      print(err);
    }
  }

  static Future<String> addUser(
      String username,
      String password,
      String name,
      String lastname,
      String phone,
      String adress,
      String zone,
      String authority) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final url = Uri.parse('http://10.0.2.2:5000/api/user/addUser');
      final body = jsonEncode({
        'username': username,
        'password': password,
        'name': name,
        'lastname': lastname,
        'phone': phone,
        'adress': adress,
        'zone': zone,
        'auth': authority,
      });

      final response = await http.post(url, headers: headers, body: body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return jsonEncode(User.fromJson(result.result));
      } else {
        return 'Request failed with status: ${response.statusCode}.';
      }
    } catch (error) {
      //   // Handle any exceptions that occurred during the request
      return 'Request failed with error: $error';
    }
  }

  static Future<String> addKid(Kid kid, List<Map<String, String>> flag) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final url = Uri.parse('http://10.0.2.2:5000/api/kids/addKid');
      final body = jsonEncode({
        "user": kid.parentId,
        "name": kid.name,
        "lastname": kid.lastname,
        "date": kid.birthday.toString(),
        "grade": kid.grade,
        "zone": kid.zone.name,
        "flags": flag
      });
      final response = await http.post(url, headers: headers, body: body);
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return jsonEncode(User.fromJson(result.result));
      } else {
        return 'Request failed with status: ${response.statusCode}.';
      }
    } catch (error) {
      //   // Handle any exceptions that occurred during the request
      return 'Request failed with error: $error';
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:admins/Models/Zone.dart';
import 'package:admins/Models/Kid.dart';
import 'package:admins/Screens/HomePage.dart';
import 'package:admins/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:admins/Models/User.dart';
import 'package:admins/Models/Notification.dart';
import 'package:image_picker/image_picker.dart';

class API {
  static Future<void> login(
      String username, String password, BuildContext context) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final url = Uri.parse('http://192.168.43.25:5000/api/auth/signin');
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
    var baseUrl = "http://192.168.43.25:5000/api/";
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
    var baseUrl = "http://192.168.43.25:5000/api/";
    var type = "notif/getAll";
    var url = Uri.parse('${baseUrl}${type}');
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    if (data.runtimeType == String) {
      return null;
    }
    List<Notifications> loadedNotif = Notifications.parseNotif(data);
    updateState(loadedNotif);
    return Notifications.parseNotif(data);
  }

  static Future<List<Kid>?> getKids(Function(List<Kid>) updateState) async {
    try {
      var baseUrl = "http://192.168.43.25:5000/api/";
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

  static Future<List<Zone>?> getZones(Function(List<Zone>) updateState) async {
    try {
      var url = Uri.parse('http://192.168.43.25:5000/api/user/getZones');
      var response = await http.get(url);
      var data = jsonDecode(response.body);
      if (data.runtimeType == String) {
        return null;
      }
      List<Zone> loadedZones = Zone.parseZones(data);
      print(loadedZones);
      updateState(loadedZones);
      return loadedZones;
    } catch (err) {
      throw Exception("$err");
    }
  }

  static Future<Map<String, dynamic>> addUser(User user, String username,
      String password, String authority, String zone) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final url = Uri.parse('http://192.168.43.25:5000/api/user/addUser');
      final body = jsonEncode({
        'id': user.id,
        'username': username,
        'password': password,
        'name': user.name,
        'lastname': user.lastname,
        'phone': user.phone,
        'adress': user.adress,
        'zone': zone,
        'auth': authority,
      });

      final response = await http.post(url, headers: headers, body: body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return result;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      // Handle any exceptions that occurred during the request
      throw Exception('$error');
    }
  }

  static Future<String> addKid(
      Kid kid, List<Map<String, String>> flag, XFile? file) async {
    try {
      final headers = {'Content-Type': 'multipart/form-data'};
      final url = Uri.parse('http://192.168.43.25:5000/api/kids/addKid');
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields.addAll({
        "user": kid.parentId,
        "name": kid.name,
        "lastname": kid.lastname,
        "date": kid.birthday.toString(),
        "grade": kid.grade,
        "zone": kid.zone.name,
        "flags": jsonEncode(flag)
      });
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath("file", file.path));
      }
      final response = await request.send();
      if (response.statusCode == 200) {
        return "kids added successfully";
      } else {
        return 'Request failed with status: ${response.statusCode}.';
      }
    } catch (error) {
      return 'Request failed with error: $error';
    }
  }

  static Future<String> addNotification(String title, String details) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final url = Uri.parse('http://192.168.43.25:5000/api/notif/post');
      final body = jsonEncode({"title": title, "content": details});
      final response = await http.post(url, headers: headers, body: body);

      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return result['message'];
      } else {
        return 'Request failed with status: ${response.statusCode}.';
      }
    } catch (error) {
      //   // Handle any exceptions that occurred during the request
      return 'Request failed with error: $error';
    }
  }
}

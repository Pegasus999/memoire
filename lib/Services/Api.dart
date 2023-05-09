import 'dart:async';
import 'dart:convert';
import 'package:rayto/Models/Zone.dart';
import 'package:rayto/Models/Kid.dart';
import 'package:rayto/Screens/DriverPage.dart';
import 'package:rayto/Screens/EmployeeHomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rayto/Models/User.dart';
import 'package:rayto/Models/Notification.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class API {
  static String baseUrl = "http://192.168.1.112:5000/";
  static Future<void> login(
      String username, String password, BuildContext context) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final url = Uri.parse('${baseUrl}api/auth/signin');
      final body = jsonEncode({'username': username, 'password': password});

      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        var user = User.fromJson(jsonDecode(response.body));
        ;
        user.auth == "ADMIN" || user.auth == "WORKER"
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => EmployeeHomePage(
                        user: user,
                      )),
                ),
              )
            : user.auth == "DRIVER"
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => DriverPage(
                            user: user,
                          )),
                    ),
                  )
                : throw Exception("معلومات خاطئة");
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      //   // Handle any exceptions that occurred during the request
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(error.toString()),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  static Future<List<User>?> getUsers(Function(List<User>) updateState) async {
    var url = Uri.parse("${baseUrl}api/user/getEmployees");
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    if (data.runtimeType == String) {
      return null;
    }
    List<User> loadedUsers = User.parseUser(data);
    updateState(loadedUsers);
    return User.parseUser(data);
  }

  static Future<List<User>?> getParents(
      Function(List<User>) updateState) async {
    var url = Uri.parse("${baseUrl}api/user/getParents");
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
    var url = Uri.parse("${baseUrl}api/notif/getAll");
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
      var url = Uri.parse("${baseUrl}api/kids/getAll");
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
      var url = Uri.parse('${baseUrl}api/user/getZones');
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

  static Future<Map<String, dynamic>> addWorker(
      User user, String username, String password, XFile? file) async {
    try {
      final headers = {'Content-Type': 'multipart/form-data'};
      final url = Uri.parse('${baseUrl}api/user/addWorker');
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields.addAll({
        'username': username,
        'password': password,
        'name': user.name,
        'lastname': user.lastname,
        'phone': user.phone,
        'gender': user.gender,
        'job': user.job ?? "",
      });
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
      }
      final response = await request.send();
      final result = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        return jsonDecode(result.body);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      // Handle any exceptions that occurred during the request
      print(error);
      throw Exception('$error');
    }
  }

  static Future<Map<String, dynamic>> addDriver(User user, String username,
      String password, String? zone, XFile? file) async {
    try {
      final headers = {'Content-Type': 'multipart/form-data'};
      final url = Uri.parse('${baseUrl}api/user/addDriver');
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields.addAll({
        'username': username,
        'password': password,
        'name': user.name,
        'lastname': user.lastname,
        'phone': user.phone,
        'gender': user.gender,
        'zone': zone ?? "",
      });
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
      }
      final response = await request.send();
      final result = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        return jsonDecode(result.body);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      // Handle any exceptions that occurred during the request
      throw Exception('$error');
    }
  }

  static Future<Map<String, dynamic>> addParent(User user, String username,
      String password, String? zone, XFile? file) async {
    try {
      final headers = {'Content-Type': 'multipart/form-data'};
      final url = Uri.parse('${baseUrl}api/user/addParent');
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields.addAll({
        'username': username,
        'password': password,
        'name': user.name,
        'lastname': user.lastname,
        'phone': user.phone,
        'gender': user.gender,
        'zone': zone ?? "",
      });
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
      }
      final response = await request.send();
      final result = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        return jsonDecode(result.body);
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
      final url = Uri.parse('${baseUrl}api/kids/addKid');
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
      final url = Uri.parse('${baseUrl}api/notif/post');
      final body = jsonEncode({
        "title": title,
        "content": details,
        "date": DateFormat('dd-MM-yyyy').format(DateTime.now())
      });
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

  static Future<List<Kid>?> getZoneRelatedKids(
      Function(List<Kid>) updateState, String zone) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      var url = Uri.parse('${baseUrl}api/kids/getZoneRelated');
      var body = jsonEncode({"zone": zone});
      final response = await http.post(url, headers: headers, body: body);

      var data = jsonDecode(response.body);
      if (data.runtimeType == String) {
        return null;
      }

      List<Kid> loadedKids = Kid.parseKids(data);
      updateState(loadedKids);
      return Kid.parseKids(data);
    } catch (err) {
      throw Exception(err);
    }
  }

  static Future<String> updateAllPosition(
      String newPosition, String zone) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final url = Uri.parse('${baseUrl}api/kids/updateAll');
      final body = jsonEncode({"position": newPosition, "zone": zone});
      final response = await http.put(url, body: body, headers: headers);
      return "Position Updated";
    } catch (err) {
      return "Request failed";
    }
  }

  static Future<String> updateSinglePosition(String position, String id) async {
    try {
      final newPosition = position == 'في المنزل'
          ? "HOME"
          : position == "في الطريق"
              ? "ROAD"
              : "DAYCARE";
      final headers = {'Content-Type': 'application/json'};
      final url = Uri.parse('${baseUrl}api/kids/updateSingle');

      final body = jsonEncode({"position": newPosition, "id": id});
      final response = await http.put(url, body: body, headers: headers);

      return "Position Updated";
    } catch (err) {
      return "Request failed";
    }
  }
}

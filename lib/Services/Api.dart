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
import 'package:rayto/Screens/ParentHomePage.dart';

class API {
  static String baseUrl = "http://192.168.43.25:5000/api/";
  static Future<void> login(
      String username, String password, BuildContext context) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final url = Uri.parse('${baseUrl}auth/signin');
      final body = jsonEncode(
          {'username': username.trim(), 'password': password.trim()});

      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        var user = User.fromJson(jsonDecode(response.body));
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
                : user.auth == "PARENT"
                    ? Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => ParentHomePage(
                                parent: user,
                              )),
                        ),
                      )
                    : Exception("معلومات خاطئة");
      } else {
        throw Exception("معلومات خاطئة");
      }
    } catch (error) {
      //   // Handle any exceptions that occurred during the request
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(error.toString()),
              actions: [
                TextButton(
                  child: const Text("OK"),
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
    var url = Uri.parse("${baseUrl}user/getEmployees");
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
    var url = Uri.parse("${baseUrl}user/getParents");
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
    var url = Uri.parse("${baseUrl}notif/getAll");
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
      var url = Uri.parse("${baseUrl}kids/getAll");
      var response = await http.get(url);
      var data = jsonDecode(response.body);
      if (data.runtimeType == String) {
        return null;
      }
      List<Kid> loadedKids = Kid.parseKids(data);
      updateState(loadedKids);
      return Kid.parseKids(data);
    } catch (err) {
      throw Exception("$err");
    }
  }

  static Future<List<Kid>?> getMine(
      Function(List<Kid>) updateState, String id) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'id': id});

      final url = Uri.parse("${baseUrl}kids/getMine");
      var response = await http.post(url, headers: headers, body: body);
      var data = jsonDecode(response.body);
      if (data.runtimeType == String) {
        return null;
      }
      List<Kid> loadedKids = Kid.parseKids(data);
      updateState(loadedKids);
      return loadedKids;
    } catch (err) {
      throw Exception("$err");
    }
  }

  static Future<List<Zone>?> getZones(Function(List<Zone>) updateState) async {
    try {
      var url = Uri.parse('${baseUrl}user/getZones');
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
      final url = Uri.parse('${baseUrl}user/addWorker');
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields.addAll({
        'username': username.trim(),
        'password': password.trim(),
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
      final url = Uri.parse('${baseUrl}user/addDriver');
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields.addAll({
        'username': username.trim(),
        'password': password.trim(),
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

  static Future<Map<String, dynamic>> addParent(
      User user, String username, String password, XFile? file) async {
    try {
      final headers = {'Content-Type': 'multipart/form-data'};
      final url = Uri.parse('${baseUrl}user/addParent');
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields.addAll({
        'username': username,
        'password': password,
        'name': user.name,
        'lastname': user.lastname,
        'phone': user.phone,
        'gender': user.gender,
        'adress': user.adress ?? "",
        'zone': user.zone!.name,
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

  static Future<String> addKid(Kid kid, XFile? file) async {
    try {
      final headers = {'Content-Type': 'multipart/form-data'};
      final url = Uri.parse('${baseUrl}kids/addKid');
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields.addAll({
        "user": kid.parentId,
        "name": kid.name,
        "lastname": kid.lastname,
        "school": kid.school,
        "gender": kid.gender,
        "zone": kid.zone.name,
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
      final url = Uri.parse('${baseUrl}notif/post');
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
      var url = Uri.parse('${baseUrl}kids/getZoneRelated');
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

  static Future<String> updateSinglePosition(String position, String id) async {
    try {
      final newPosition = position == 'في المنزل'
          ? "HOME"
          : position == "في الطريق"
              ? "ROAD"
              : position == "في الموؤسسة"
                  ? "SCHOOL"
                  : "DAYCARE";
      final headers = {'Content-Type': 'application/json'};
      final url = Uri.parse('${baseUrl}attendence/updatePosition');

      final body = jsonEncode({"position": newPosition, "kid_id": id});
      await http.put(url, body: body, headers: headers);

      return "Position Updated";
    } catch (err) {
      return "Request failed";
    }
  }

  static Future<String> resub(String id) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      var url = Uri.parse('${baseUrl}kids/resub');
      var body = jsonEncode({"id": id});
      await http.put(url, headers: headers, body: body);

      return "resubbed";
    } catch (err) {
      throw Exception(err);
    }
  }

  static Future<List<Kid>?> getAttendence(
      Function(List<Kid>) updateState) async {
    try {
      var url = Uri.parse("${baseUrl}attendence/getAll");
      var response = await http.get(url);
      var data = jsonDecode(response.body);
      if (data.runtimeType == String) {
        return null;
      }
      List<Kid> loadedKids = Kid.parseKids(data);
      updateState(loadedKids);
      return loadedKids;
    } catch (err) {
      throw Exception("$err");
    }
  }

  static Future<String> resetAttendence(String zone) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'zone': zone});

      final url = Uri.parse("${baseUrl}attendence/restAll");
      await http.put(url, headers: headers, body: body);
      return "reseted";
    } catch (err) {
      throw Exception("$err");
    }
  }
}

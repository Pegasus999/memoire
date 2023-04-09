import 'dart:convert';
import 'package:admins/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:admins/Models/User.dart';

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
}

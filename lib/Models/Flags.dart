import 'package:admins/Models/Kid.dart';

class Flag {
  String title = '';
  String details = '';
  Flag.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        details = json['details'];
  static List<Flag> parseFlags(List<dynamic> flags) {
    return flags.map((json) => Flag.fromJson(json)).toList();
  }
}

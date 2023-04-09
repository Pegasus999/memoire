import 'package:admins/Models/Kid.dart';

class Flag {
  String id = '';
  String title = '';
  String details = '';
  Flag.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        details = json['Details'];
}

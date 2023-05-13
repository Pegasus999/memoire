import 'package:rayto/Models/Zone.dart';

class Kid {
  String id = '';
  String name = '';
  String lastname = '';
  String parentId = '';
  String gender;
  DateTime subscription;
  String picture = '';
  Zone zone;
  bool morningPresent;
  bool eveningPresent;
  String school;
  String adress;
  String? phone;
  String position;

  Kid.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        morningPresent = json['morningPresent'] ?? false,
        eveningPresent = json['eveningPresent'] ?? false,
        adress = json['User']['adress'],
        gender = json['gender'],
        subscription = json['subscription'] != null
            ? DateTime.parse(json['subscription'])
            : DateTime.now(),
        lastname = json['lastname'],
        phone = json["User"]["phone"],
        parentId = json['userId'],
        picture = json['picture'],
        position = json['position'] == "HOME"
            ? 'في المنزل'
            : json["position"] == "ROAD"
                ? "في الطريق"
                : json["position"] == "SCHOOL"
                    ? "في الموؤسسة"
                    : "في الروضة",
        school = json['school'],
        zone = Zone.fromJson({"name": json['User']['zone']['name']});

  static List<Kid> parseKids(List<dynamic> kids) {
    return kids.map((json) => Kid.fromJson(json)).toList();
  }
}

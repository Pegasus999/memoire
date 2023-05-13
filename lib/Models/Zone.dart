
class Zone {
  int? id;
  String name = '';

  Zone.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  static List<Zone> parseZones(List<dynamic> zones) {
    return zones.map((json) => Zone.fromJson(json)).toList();
  }
}

class Notifications {
  int id = 0;
  String title = "";
  String content = "";
  DateTime date = DateTime.now();

  Notifications.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'];

  static List<Notifications> parseNotif(List<dynamic> notifications) {
    return notifications.map((json) => Notifications.fromJson(json)).toList();
  }
}

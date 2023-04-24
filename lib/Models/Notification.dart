class Notifications {
  String title = "";
  String content = "";
  DateTime date = DateTime.now();

  Notifications.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'];

  static List<Notifications> parseNotif(List<dynamic> notifications) {
    return notifications.map((json) => Notifications.fromJson(json)).toList();
  }
}

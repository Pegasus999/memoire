class Notifications {
  String title = "";
  String content = "";
  String date;

  Notifications.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        date = json['date'];

  static List<Notifications> parseNotif(List<dynamic> notifications) {
    return notifications.map((json) => Notifications.fromJson(json)).toList();
  }
}

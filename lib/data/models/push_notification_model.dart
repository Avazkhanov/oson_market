class PushNotificationModel {
  final String title;
  final String body;
  final int id;

  PushNotificationModel({
    required this.title,
    required this.body,
    required this.id,
  });

  factory PushNotificationModel.fromJson(Map<String, dynamic> json) {
    return PushNotificationModel(
      title: json['title'],
      body: json['body'],
      id: json['id'],
    );
  }
}

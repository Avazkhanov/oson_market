import 'package:flutter/material.dart';
import 'package:oson_market/data/models/push_notification_model.dart';

class PushNotificationViewModel extends ChangeNotifier {
  List<PushNotificationModel> pushNotifications = [];

  addPushNotification(PushNotificationModel model) {
    pushNotifications.add(model);
    notifyListeners();
  }

  clearPushNotifications() {
    pushNotifications.clear();
    notifyListeners();
  }
}

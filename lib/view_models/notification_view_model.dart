import 'package:flutter/material.dart';
import 'package:oson_market/data/models/notification_model.dart';

class NotificationViewModel extends ChangeNotifier {
  List<NotificationModel> notificationList = [];

  List<NotificationModel> get notifications => notificationList;

  addToNotification(NotificationModel model) {
    notificationList.add(model);
    notifyListeners();
  }

  removeFromList(NotificationModel model) {
    notificationList.remove(model);
    notifyListeners();
  }

  removeAll() {
    notificationList.removeRange(0, notificationList.length);
    notifyListeners();
  }
}

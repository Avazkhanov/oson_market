import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static getStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isDenied) {
      PermissionStatus status = await Permission.storage.request();
    }
  }

  static getCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    if (status.isDenied) {
      PermissionStatus status = await Permission.camera.request();
    }
  }

  static getLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    if (status.isDenied) {
      PermissionStatus status = await Permission.location.request();
    }
  }

  static getContactsPermission() async {
    PermissionStatus status = await Permission.contacts.status;
    if (status.isDenied) {
      PermissionStatus status = await Permission.contacts.request();
    }
  }
  static getSmsPermission() async {
    PermissionStatus status = await Permission.sms.status;
    if (status.isDenied) {
      PermissionStatus status = await Permission.sms.request();
    }
  }
  static getCalendarPermission() async {
    PermissionStatus status = await Permission.calendarFullAccess.status;
    if (status.isDenied) {
      PermissionStatus status = await Permission.calendarFullAccess.request();
    }
  }

  static getMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;
    if (status.isDenied) {
      PermissionStatus status = await Permission.microphone.request();
    }
  }
  static getBLUETOOTHPermission() async {
    PermissionStatus status = await Permission.bluetooth.status;
    if (status.isDenied) {
      PermissionStatus status = await Permission.bluetooth.request();
    }
  }
  static getTelephonePermission() async {
    var status = await Permission.phone.serviceStatus;
    if (status.isDisabled) {
      var status = await Permission.phone.request();
    }
  }

  static getImportantPermissions() async {
    List<Permission> permissions = [
      Permission.notification,
      Permission.camera,
      Permission.storage,
    ];
    Map<Permission, PermissionStatus> somePermissionsResults =
        await permissions.request();
  }
}

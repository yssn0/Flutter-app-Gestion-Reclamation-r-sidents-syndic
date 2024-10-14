//lib\user\data\services\local_notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  int _notificationCount = 0;
  late String _packageName;

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notificationsPlugin.initialize(initializationSettings);

    // Get the package name
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _packageName = packageInfo.packageName;
  }

  Future<bool> requestPermissions() async {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      return true;
    } else {
      print('Notification permission denied');
      return false;
    }
  }

  Future<void> showNotification(String title, String body) async {
    if (await Permission.notification.isGranted) {
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          const AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        importance: Importance.max,
        priority: Priority.high,
      );
      NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await _notificationsPlugin.show(
        0,
        title,
        body,
        platformChannelSpecifics,
      );

      _notificationCount++;
      await updateBadge();
    } else {
      print('Notification permission not granted');
    }
  }

  Future<void> updateBadge() async {
    try {
      await AppBadgePlus.updateBadge(_notificationCount);
    } catch (e) {
      print('Error updating badge: $e');
    }
  }

  Future<void> resetBadge() async {
    _notificationCount = 0;
    try {
      await AppBadgePlus.updateBadge(0);
    } catch (e) {
      print('Error removing badge: $e');
    }
  }
}
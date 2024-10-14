//lib\notification_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verve_appv3/user/data/services/notification_service.dart';
import 'package:verve_appv3/user/data/realm/database.dart';
import 'package:verve_appv3/user/data/services/notification_controller.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}
class _NotificationPageState extends State<NotificationPage> {
  final NotificationService _notificationService = NotificationService();
  final NotificationController notificationController = Get.find<NotificationController>();
  List<AppNotification> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    try {
      final notifications = await _notificationService.getNotifications();
    //  await _notificationService.markAllNotificationsAsRead();
      await notificationController.markAllAsRead();
      setState(() {
        _notifications = notifications;
      });
    } catch (e) {
      print("Error loading notifications: $e");
      // Handle error (e.g., show a snackbar)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return ListTile(
            title: Text(notification.title),
            subtitle: Text(notification.content),
            trailing: Text(notification.createdAt.toString()),
          );
        },
      ),
    );
  }
}
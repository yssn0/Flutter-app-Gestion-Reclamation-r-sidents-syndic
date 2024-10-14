//lib\user\data\services\notification_controller.dart
import 'package:get/get.dart';
import 'package:verve_appv3/user/data/services/notification_service.dart';

class NotificationController extends GetxController {
  final NotificationService _notificationService = NotificationService();
  final RxInt unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    updateUnreadCount();
  }

  Future<void> updateUnreadCount() async {
    try {
      final count = await _notificationService.getUnreadNotificationCount();
      unreadCount.value = count;
    } catch (e) {
      print("Error updating unread count: $e");
    }
  }

  Future<void> markAllAsRead() async {
    await _notificationService.markAllNotificationsAsRead();
    await updateUnreadCount();
  }
}
//lib\user\data\services\notification_service.dart

import 'package:realm/realm.dart';
import 'package:verve_appv3/user/data/realm/database.dart';
import 'package:verve_appv3/user/data/realm/realm.dart';
import 'package:get/get.dart';
import 'package:verve_appv3/user/data/services/notification_controller.dart';
import 'package:verve_appv3/user/data/services/local_notification_service.dart';


class NotificationService {
  final LocalNotificationService localNotificationService = LocalNotificationService();

  NotificationService() {
    localNotificationService.initialize();
    _setupRealmListener();
  }

  void _setupRealmListener() async {
    AppUser? currentUser = await getCurrentUser();
    if (realm != null && currentUser != null) {
      realm!.all<AppNotification>().changes.listen((RealmResultsChanges<AppNotification> changes) {
        for (var index in changes.inserted) {
          final AppNotification notification = changes.results[index];  
          if (!notification.isRead && (notification.userId == currentUser.id)) {
            localNotificationService.showNotification(notification.title, notification.content);
          }
        }
      });
    }
  }



  Future<List<AppNotification>> getNotifications() async {
    AppUser? currentUser = await getCurrentUser();
    if (currentUser == null || realm == null) {
      throw Exception("User not logged in or Realm not initialized");
    }

    return realm!.all<AppNotification>().query('userId == \$0', [currentUser.id]).toList();
  }

  Future<int> getUnreadNotificationCount() async {
    AppUser? currentUser = await getCurrentUser();
    if (currentUser == null || realm == null) {
      throw Exception("User not logged in or Realm not initialized");
    }

    return realm!.all<AppNotification>().query('userId == \$0 AND isRead == false', [currentUser.id]).length;
  }

  Future<void> markAllNotificationsAsRead() async {
    AppUser? currentUser = await getCurrentUser();
    if (currentUser == null || realm == null) {
      throw Exception("User not logged in or Realm not initialized");
    }

    realm!.write(() {
      final unreadNotifications = realm!.all<AppNotification>().query('userId == \$0 AND isRead == false', [currentUser.id]);
      for (var notification in unreadNotifications) {
        notification.isRead = true;
      }
    });
    // Reset the badge count
    await localNotificationService.resetBadge();

    // Update the unread count in the controller
    Get.find<NotificationController>().updateUnreadCount();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../utility/logger.dart';
import '../notification_message.model.dart';

// setup default
const bool _useDefaultNotificationDetails = false;

@immutable
abstract final class LocalNotification {
// Instance of Flutternotification plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // TODO: implement token
  Future<String?> get token => throw UnimplementedError();

  /// call in [App.setup]
  static Future<void> setup({
    String defaultIcon = '@drawable/ic_launcher',
  }) async {
    // Initialization setting for android
    final initializationSettingsAndroid = InitializationSettings(
        android: AndroidInitializationSettings(defaultIcon));
    _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );
  }

  /// final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  /// String? title, // message.notification?.title,
  /// String? body, // message.notification?.body,
  /// String? payload, // message.data['route'], -> [route] is a random key
  ///
  static Future<void> show({
    required NotificationMessageModel notificationMessage,
  }) async {
    // To display the notification in device
    try {
      await _notificationsPlugin.show(
        notificationMessage.id,
        notificationMessage.title,
        notificationMessage.body,
        notificationMessage.notificationDetails ??
            (_useDefaultNotificationDetails
                ? _getNotificationDetails(
                    sound: notificationMessage
                        .notificationDetails?.android?.sound?.sound,
                    channelId: notificationMessage
                        .notificationDetails?.android?.sound?.sound,
                    channelName: notificationMessage
                        .notificationDetails?.android?.sound?.sound,
                  )
                : null),
        payload: notificationMessage.payload,
      );
    } catch (e, s) {
      logger.error('LocalNotification', e: e, s: s);
    }
  }

  static Future<void> cancel(int id, {String? tag}) async {
    await _notificationsPlugin.cancel(id, tag: tag);
  }

  static Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
  }

  static NotificationDetails _getNotificationDetails({
    String? channelId,
    String? channelName,
    String? sound,
  }) {
    // To display the notification in device
    return NotificationDetails(
      android: AndroidNotificationDetails(
          channelId ?? 'Channel Id', channelName ?? 'Main Channel',
          groupKey: sound ?? 'gfg',
          color: Colors.green,
          importance: Importance.max,
          sound: RawResourceAndroidNotificationSound(sound ?? 'gfg'),
          // different sound for
          // different notification
          playSound: true,
          priority: Priority.high),
    );
  }
}

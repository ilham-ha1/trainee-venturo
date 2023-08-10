import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/route_manager.dart';
import 'package:trainee/configs/routes/main_route.dart';

class FirebaseMessagingService {
  static FirebaseMessaging instance = FirebaseMessaging.instance;
  static FlutterLocalNotificationsPlugin localNotification =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // init notif channel
    const channel = AndroidNotificationChannel(
      'order_notification_channel',
      'order channel',
      description: 'order data channel',
      importance: Importance.high,
    );

    // init local notif
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await localNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    // create init channel
    await localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // request permission
    await localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    // listen to foreground notif
    FirebaseMessaging.onMessage.listen(
      (message) async {
        //show notification
        log('onMessage: $message');
        await FirebaseMessagingService.handleNotif(message);
      },
      onError: (e) {
        log(e);
      },
    );
  }

  @pragma('vm:entry-point')
  static Future<void> handleNotif(RemoteMessage message) async {
    log("Foreground ${message.data}");
    // get remote message data
    final notificationData = message.notification;

    final androidNotifDetail = AndroidNotificationDetails(
        'order_notification_channel', 'order channel',
        channelDescription: 'order data channel',
        icon: notificationData?.android?.smallIcon,
        priority: Priority.high);

    final NotificationDetails notifDetail = NotificationDetails(
      android: androidNotifDetail,
    );

    if (notificationData != null) {
      localNotification.show(
        notificationData.hashCode,
        notificationData.title,
        notificationData.body,
        notifDetail,
        payload: message.data['id_order'],
      );
    }
  }

  @pragma('vm:entry-point')
  static Future<void> handleBackgroundNotif(RemoteMessage message) async {
    log("Background ${message.data}");

    // get remote message data
    final notificationData = message.notification;

    final androidNotifDetail = AndroidNotificationDetails(
        'order_notification_channel', 'order channel',
        channelDescription: 'order data channel',
        icon: notificationData?.android?.smallIcon,
        priority: Priority.high);

    const darwinNotifDetail = DarwinNotificationDetails();

    final NotificationDetails notifDetail = NotificationDetails(
      android: androidNotifDetail,
      iOS: darwinNotifDetail,
    );

    if (notificationData != null) {
      localNotification.show(
        notificationData.hashCode,
        notificationData.title,
        notificationData.body,
        notifDetail,
        payload: message.data['id_order'],
      );
    }
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) {
    // handle notif payload when user click the notification item
    log("payload ${response.payload}");
    if (response.payload != null) {
      final idOrder = int.parse(response.payload!);
      Get.toNamed('${MainRoute.order}/$idOrder');
    }
  }
}
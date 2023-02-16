import 'dart:convert';

import 'package:apricart/app/locator.dart';
import 'package:apricart/models/notification_payload_model.dart';
import 'package:apricart/services/misc_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../widgets/snackbars/app_default_snackbars.dart';

class LocalNotificationService {
  static MiscService get miscService => locator<MiscService>();

  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() async {
    // initializationSettings  for Android
    InitializationSettings initializationSettings = InitializationSettings(
      android: const AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: IOSInitializationSettings(
        onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
        ) async {
          AppDefaultSnackbars.showIOSNotificationSnackbar(title.toString(), body.toString(), () {
            String? encodedData = payload;
            if (encodedData != null) {
              print(jsonDecode(encodedData));
              Map<String, dynamic> data = jsonDecode(encodedData);
              print(data);
              if (data.containsKey("type")) {
                if (locator<MiscService>().viewActive == true) {
                  miscService.initialPayload = NotificationPayload(type: data["type"], data: data["sku"]);
                } else {
                  miscService.handleNotificationPayload(NotificationPayload(type: data["type"], data: data["sku"]));
                }
              }
            }
          });
        },
      ),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? encodedData) async {
        if (encodedData != null) {
          print(jsonDecode(encodedData));
          Map<String, dynamic> data = jsonDecode(encodedData);
          print(data);
          if (data.containsKey("type")) {
            if (locator<MiscService>().viewActive == true) {
              miscService.initialPayload = NotificationPayload(type: data["type"], data: data["sku"]);
            } else {
              miscService.handleNotificationPayload(NotificationPayload(type: data["type"], data: data["sku"]));
            }
          }
        }
      },
    );
    print(await FirebaseMessaging.instance.getToken());
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "apricart",
          "apricartNotificationChannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}

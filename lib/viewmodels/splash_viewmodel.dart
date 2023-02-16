import 'dart:convert';
import 'dart:io';

import 'package:apricart/app/app.router.dart';
import 'package:apricart/app/locator.dart';
import 'package:apricart/models/notification_payload_model.dart';
import 'package:apricart/models/user_data_model.dart';
import 'package:apricart/services/auth_service.dart';
import 'package:apricart/services/cart_service.dart';
import 'package:apricart/services/data_service.dart';
import 'package:apricart/services/location_service.dart';
import 'package:apricart/services/misc_service.dart';
import 'package:apricart/services/storage_service.dart';
import 'package:apricart/widgets/snackbars/app_default_snackbars.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/local_notification_service.dart';

@lazySingleton
class SplashViewModel extends BaseViewModel {
  final navigator = locator<NavigationService>();
  final locationService = locator<LocationService>();
  final miscService = locator<MiscService>();
  final dataService = locator<DataService>();
  final storageService = locator<StorageService>();
  final authService = locator<AuthService>();
  final cartService = locator<CartService>();

  bool get viewActive => miscService.viewActive;

  initializeViewModel(BuildContext context) async {
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) async {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          if (message.data.containsKey("type")) {
            miscService.initialPayload = NotificationPayload(type: message.data["type"], data: message.data["sku"]);
          }
        }
        // if (message != null) {
        //   if (message.data != null) {
        //     final notificationData = message.data;
        //     if ((notificationData as Map<String, dynamic>).containsKey("message_thread_id")) {
        //       await Get.toNamed(Routes.CHAT_SCREEN_ROUTE,
        //           arguments: [notificationData["message_thread_id"], notificationData["to_phone_number"], null]);
        //       if (con.initializedd == true) {
        //         Get.offAllNamed(Routes.BASE_SCREEN_ROUTE);
        //       }
        //     }
        //   }
        // }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        print(message.data.toString());
        if (message.notification != null) {
          if (Platform.isIOS) {
            AppDefaultSnackbars.showIOSNotificationSnackbar(
                message.notification!.title.toString(), message.notification!.body.toString(), () {
              Map<String, dynamic> data = message.data;
              print(data);
              if (data.containsKey("type")) {
                if (locator<MiscService>().viewActive == true) {
                  miscService.initialPayload = NotificationPayload(type: data["type"], data: data["sku"]);
                } else {
                  miscService.handleNotificationPayload(NotificationPayload(type: data["type"], data: data["sku"]));
                }
              }
            });
          } else {
            LocalNotificationService.createanddisplaynotification(message);
          }
        }
        // if (message.notification != null) {
        //   print(message.notification!.title);
        //   print(message.notification!.body);
        //   print("message.data11 ${message.data}");
        //   if (Get.currentRoute == Routes.CHAT_SCREEN_ROUTE) {
        //   } else {
        //     LocalNotificationService.createanddisplaynotification(message);
        //   }
        // }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          if (message.data.containsKey("type")) {
            if (viewActive == true) {
              miscService.initialPayload = NotificationPayload(type: message.data["type"], data: message.data["sku"]);
            } else {
              miscService.handleNotificationPayload(
                  NotificationPayload(type: message.data["type"], data: message.data["sku"]));
            }
          }
          //   print(message.notification!.title);
          //   print(message.notification!.body);
          //   print("message.data22 ${message.data}");
          //   if (message != null) {
          //     if (message.data != null) {
          //       final notificationData = message.data;
          //       if ((notificationData as Map<String, dynamic>).containsKey("message_thread_id")) {
          //         Get.toNamed(Routes.CHAT_SCREEN_ROUTE,
          //             arguments: [notificationData["message_thread_id"], notificationData["to_phone_number"], null]);
          //       }
          //     }
          //   }
        }
      },
    );
    miscService.setViewActive(true);
    await Future.delayed(
      const Duration(milliseconds: 1500),
    );
    try {
      //Subscribe to topics
      if (Platform.isAndroid) {
        await FirebaseMessaging.instance.subscribeToTopic("android");
      }
      if (kDebugMode) {
        await FirebaseMessaging.instance.subscribeToTopic("topics-alldev");
      }
      await FirebaseMessaging.instance.subscribeToTopic("topics-all");

      //Load Existing User
      String? userData = storageService.instance.getString(StorageService.userDataKey);
      if (userData != null) {
        authService.userData = UserData.fromJson(jsonDecode(userData));
      }

      //Load Data
      await dataService.loadOptions();
      await dataService.loadAddressCities();

      //Load Location
      await locationService.getLocation();

      //Load Cart
      await cartService.loadCartItem();
    } catch (e) {
      null;
    }
    navigator.clearStackAndShow(Routes.navWrapperView);
    miscService.setViewActive(false);
  }
}

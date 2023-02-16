import 'package:apricart/app/locator.dart';
import 'package:apricart/models/order_history_model.dart';
import 'package:apricart/services/auth_service.dart';
import 'package:apricart/services/data_service.dart';
import 'package:apricart/services/local_notification_service.dart';
import 'package:apricart/services/storage_service.dart';
import 'package:apricart/viewmodels/splash_viewmodel.dart';
import 'package:apricart/views/add_address/add_address_view.dart';
import 'package:apricart/views/contact_us/contact_us_view.dart';
import 'package:apricart/views/create_account/create_account_view.dart';
import 'package:apricart/views/delivery_details/delivery_details_view.dart';
import 'package:apricart/views/forgot_password/forgot_password_view.dart';
import 'package:apricart/views/home/home_view.dart';
import 'package:apricart/views/login/login_view.dart';
import 'package:apricart/views/my_addresses/my_addresses_view.dart';
import 'package:apricart/views/nav_wrapper/nav_wrapper_view.dart';
import 'package:apricart/views/online_payment/online_payment_view.dart';
import 'package:apricart/views/order_history/order_history_view.dart';
import 'package:apricart/views/order_placed/order_placed_view.dart';
import 'package:apricart/views/order_type/order_type_view.dart';
import 'package:apricart/views/otp/otp_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.router.dart';
import 'views/splash/splash_view.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  await locator<StorageService>().initializeStorageInstance();
  await locator<AuthService>().generateUid();
  await locator<DataService>().initializeDeviceInfo();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _scaffodlKey = GlobalKey<ScaffoldMessengerState>();
    locator<DataService>().initializeScaffoldMessegerKey(_scaffodlKey);
    return MaterialApp(
      title: 'Apri Cart',
      scaffoldMessengerKey: _scaffodlKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: OnlinePaymentView(webViewUrl: 'https://google.com'),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}


// Enable location Service
// Upadte app Dialog unpopable
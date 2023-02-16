import 'dart:convert';

import 'package:apricart/app/locator.dart';
import 'package:apricart/models/user_data_model.dart';
import 'package:apricart/services/api_service.dart';
import 'package:apricart/services/cart_service.dart';
import 'package:apricart/services/storage_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class AuthService {
  final apiService = locator<ApiService>();
  final cartService = locator<CartService>();
  final storageService = locator<StorageService>();

  UserData? userData;
  String get uid => storageService.instance.getString(StorageService.uidKey).toString();

  Future<bool?> loginUser(String phone, String password) async {
    try {
      userData = await apiService.login(phone, password);
      await storageService.instance.setString(StorageService.userDataKey, jsonEncode(userData!.toJson()));

      //Subscribe User
      await FirebaseMessaging.instance.subscribeToTopic(storageService.instance.getString(StorageService.uidKey)!);
      await FirebaseMessaging.instance.subscribeToTopic("topics-${userData!.email!.split("@").join('')}");
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> registerUser(String name, String email, String phone, String password) async {
    try {
      await apiService.register(name, email, phone, password);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> forgotPassword(String phone, String password, String otp) async {
    try {
      userData = await apiService.forgotPassword(phone, password, otp);
      await storageService.instance.setString(StorageService.userDataKey, jsonEncode(userData!.toJson()));

      //Subscribe User
      await FirebaseMessaging.instance.subscribeToTopic(storageService.instance.getString(StorageService.uidKey)!);
      await FirebaseMessaging.instance.subscribeToTopic("topics-${userData!.email!.split("@").join('')}");
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> sendOtp(String phone) async {
    try {
      await apiService.sendOtp(phone);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> verifyOtp(String phone, String code) async {
    try {
      userData = await apiService.verifyOtp(phone, code);
      await storageService.instance.setString(StorageService.userDataKey, jsonEncode(userData!.toJson()));

      //Subscribe User
      await FirebaseMessaging.instance.subscribeToTopic(storageService.instance.getString(StorageService.uidKey)!);
      await FirebaseMessaging.instance.subscribeToTopic("topics-${userData!.email!.split("@").join('')}");
      return true;
    } catch (e) {
      rethrow;
    }
  }

  logoutUser() {
    FirebaseMessaging.instance.unsubscribeFromTopic(storageService.instance.getString(StorageService.uidKey)!);
    FirebaseMessaging.instance.unsubscribeFromTopic("topics-${userData!.email!.split("@").join('')}");
    userData = null;
    storageService.instance.remove(StorageService.userDataKey);
    storageService.instance.remove(StorageService.savedAddressKey);

    cartService.loadCartItem();
  }

  generateUid() async {
    // print(storageService.instance.getString(StorageService.uidKey));
    if (storageService.instance.getString(StorageService.uidKey) == null) {
      final uid = const Uuid().v4();
      await storageService.instance.setString(StorageService.uidKey, uid);
      // print(storageService.instance.getString(StorageService.uidKey));
    }
  }
}

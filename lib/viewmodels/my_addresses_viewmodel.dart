import 'dart:convert';

import 'package:apricart/app/app.router.dart';
import 'package:apricart/models/user_data_model.dart';
import 'package:apricart/services/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';
import '../models/address_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class MyAddressesViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final apiService = locator<ApiService>();
  final storageService = locator<StorageService>();
  final navigator = locator<NavigationService>();

  UserData? get userData => authService.userData;

  Address? get selectedAddress {
    String? rawAddress = storageService.instance.getString(StorageService.savedAddressKey);
    int? savedAddressId;
    if (rawAddress == null) {
      savedAddressId = -1;
    } else {
      savedAddressId = Address.fromJson(jsonDecode(rawAddress)).id ?? -1;
    }
    for (Address address in addresses) {
      if (address.id == savedAddressId) {
        return address;
      }
    }
    //AddressChange
    // if (addresses.isNotEmpty) {
    //   return addresses[0];
    // }
    return null;
  }

  List<Address> addresses = <Address>[];

  loadAddresses() async {
    setBusy(true);
    try {
      addresses = <Address>[];
      addresses = await apiService.getAddresses();
    } catch (e) {
      null;
    }
    setBusy(false);
  }

  saveAddress(Address value) async {
    String? rawAddress = storageService.instance.getString(StorageService.savedAddressKey);
    if (rawAddress == null) {
      null;
    } else {
      Address savedAddress = Address.fromJson(jsonDecode(rawAddress));
      FirebaseMessaging.instance.unsubscribeFromTopic('topics-${savedAddress.city?.toLowerCase()}');
      if (kDebugMode) {
        FirebaseMessaging.instance.unsubscribeFromTopic('topics-alldev${savedAddress.city?.toLowerCase()}');
      }
    }
    await storageService.instance.setString(StorageService.savedAddressKey, jsonEncode(value.toJson()));
    FirebaseMessaging.instance.subscribeToTopic('topics-${value.city?.toLowerCase()}');
    if (kDebugMode) {
      FirebaseMessaging.instance.subscribeToTopic('topics-alldev${value.city?.toLowerCase()}');
    }
    notifyListeners();
    navigator.back();
  }

  deleteAddress(int? id) async {
    setBusy(true);
    try {
      await apiService.deleteAddress(id);
    } catch (e) {
      null;
    }
    setBusy(false);
    await loadAddresses();
  }

  moveToAddAddressView() async {
    final res = await navigator.navigateTo(Routes.addAddressView);
    if (res == true) {
      loadAddresses();
    }
  }

  moveToAddAddressViewForEditting(Address address) async {
    final res =
        await navigator.navigateTo(Routes.addAddressView, arguments: AddAddressViewArguments(initialAddress: address));
    if (res == true) {
      loadAddresses();
    }
  }

  initializeViewModel() async {
    setBusy(true);
    await Future.delayed(const Duration(microseconds: 1));
    setBusy(false);
    if (userData != null) {
      loadAddresses();
    } else {
      navigator.navigateTo(Routes.loginView)?.then((value) {
        if (userData == null) {
          navigator.back();
        } else {
          initializeViewModel();
        }
      });
    }
  }
}

import 'dart:io';
import 'dart:math';
import 'package:apricart/app/locator.dart';
import 'package:apricart/models/address_city_model.dart';
import 'package:apricart/models/address_model.dart';
import 'package:apricart/models/app_option_model.dart';
import 'package:apricart/services/api_service.dart';
import 'package:apricart/services/storage_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@lazySingleton
class DataService {
  final apiService = locator<ApiService>();
  final storageService = locator<StorageService>();

  List<AppOption> _options = <AppOption>[];
  List<AppOption> get options => _options;

  List<AddressCity> _addressCities = <AddressCity>[];
  List<AddressCity> get addressCities => _addressCities;

  Future<void> loadOptions() async {
    try {
      _options = await apiService.getOptions();
    } catch (e) {
      rethrow;
    }
  }

  loadAddressCities() async {
    try {
      _addressCities = await apiService.getAddressCities();
    } catch (e) {
      rethrow;
    }
  }

  String platform = 'android';
  String deviceName = 'unknown';

  initializeDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      platform = 'android';
      deviceName = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      platform = 'ios';
      deviceName = iosInfo.utsname.machine ?? 'unknown';
    }
  }

  //App Main Context
  late GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  initializeScaffoldMessegerKey(GlobalKey<ScaffoldMessengerState> key) {
    scaffoldMessengerKey = key;
  }

  //Home Data Type
  String get homeDataType {
    String? orderType =
        storageService.instance.getString(StorageService.orderTypeKey);
    if (orderType == null) {
      setHomeDataType('delivery');
      return 'delivery';
    } else {
      return orderType;
    }
  }

  setHomeDataType(String value) {
    storageService.instance.setString(StorageService.orderTypeKey, value);
  }

  // Verison calculation
  String get updateMessage {
    if (options.isNotEmpty) {
      AppOption sort = options.singleWhere(
          (element) => element.key == 'force_update',
          orElse: () => AppOption());
      return sort.value ?? '';
    }
    return '';
  }

  Future<bool> isUpdateAvailable() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String? currentVersion;
    String? apiVersion;

    currentVersion = packageInfo.version;
    print(currentVersion);

    if (options.isNotEmpty) {
      if (Platform.isAndroid) {
        apiVersion = options
            .firstWhere((element) => element.key == 'android',
                orElse: () => AppOption())
            .value;
      } else if (Platform.isIOS) {
        apiVersion = options
            .firstWhere((element) => element.key == 'ios',
                orElse: () => AppOption())
            .value;
      }
    }

    if (apiVersion != null) {
      return isApiVersionGreater(currentVersion, apiVersion);
    }
    return false;
  }

  bool isApiVersionGreater(String currentVersion, String apiVersion) {
    List<int> cv = currentVersion.split('.').map((e) => int.parse(e)).toList();
    List<int> av = apiVersion.split('.').map((e) => int.parse(e)).toList();

    List<int> code = [1000000000, 1000000, 1000, 1];

    int newCv = 0;
    int newAv = 0;

    int cvIndex = -1;
    for (int i in cv) {
      cvIndex++;
      newCv += code[cvIndex] * i;
    }

    int avIndex = -1;
    for (int i in av) {
      avIndex++;
      newAv += code[avIndex] * i;
    }
    // print(newAv);
    // print(newCv);
    if (newAv > newCv) {
      return true;
    }
    return false;
  }
}

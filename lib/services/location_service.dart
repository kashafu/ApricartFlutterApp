import 'dart:convert';
import 'dart:developer';

import 'package:apricart/app/locator.dart';
import 'package:apricart/models/address_model.dart';
import 'package:apricart/services/auth_service.dart';
import 'package:apricart/services/data_service.dart';
import 'package:apricart/services/storage_service.dart';
import 'package:apricart/widgets/dialogs/select_city_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:quickalert/quickalert.dart';
import 'package:stacked_services/stacked_services.dart';

import '../models/address_city_model.dart';

@lazySingleton
class LocationService {
  DataService get dataService => locator<DataService>();
  AuthService get authService => locator<AuthService>();
  StorageService get storageService => locator<StorageService>();

  LocationData? locationData;
  String? get currentCity {
    if (authService.userData != null) {
      String? rawAddress = storageService.instance.getString(StorageService.savedAddressKey);
      if (rawAddress == null) {
        return _city ?? 'karachi';
      } else {
        Address savedAddress = Address.fromJson(jsonDecode(rawAddress));
        return savedAddress.city ?? 'karachi';
      }
    } else {
      return _city ?? 'karachi';
    }
  } // ?? 'karachi'

  String? _city;
  double? get latitude => locationData?.latitude ?? -1; // ?? 24.881308
  double? get longitude => locationData?.longitude ?? -1; // ?? 67.06022

  Future<void> getLocation() async {
    // bool serviceEnabled;
    // LocationPermission permission;

    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return false;
    // }
    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     return false;
    //   }
    // }
    // if (permission == LocationPermission.deniedForever) {
    //   return false;
    // }
    // return true;

    Location location = Location();
    PermissionStatus permission;
    if (!(await location.serviceEnabled())) {
      await location.requestService();
    }
    if (await location.serviceEnabled()) {
      permission = await location.hasPermission();

      if (permission != PermissionStatus.denied) {
        try {
          locationData = await location.getLocation();

          List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
            latitude ?? 0,
            longitude ?? 0,
          );
          geo.Placemark place = placemarks[0];
          _city = place.locality;
        } catch (e) {
          null;
        }
      } else {
        permission = await location.requestPermission();
        if (permission != PermissionStatus.denied) {
          try {
            locationData = await location.getLocation();

            List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
              latitude ?? 0,
              longitude ?? 0,
            );
            geo.Placemark place = placemarks[0];
            _city = place.locality;
          } catch (e) {
            null;
          }
        } else {
          final res = await showDialog(
            context: StackedService.navigatorKey!.currentContext!,
            builder: (_) => SelectCityDialog(
              items: dataService.addressCities.map((e) => e.city.toString()).toList(),
            ),
          );
          _city = res;
        }
      }
    } else {
      final res = await showDialog(
        context: StackedService.navigatorKey!.currentContext!,
        builder: (_) => SelectCityDialog(
          items: dataService.addressCities.map((e) => e.city.toString()).toList(),
        ),
      );
      _city = res;
    }

    if (_city == null) {
      final res = await showDialog(
        context: StackedService.navigatorKey!.currentContext!,
        builder: (_) => SelectCityDialog(
          items: dataService.addressCities.map((e) => e.city.toString()).toList(),
        ),
      );
      _city = res;
    }
  }

  // _getCityFromLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   latitude = position.latitude;
  //   longitude = position.longitude;
  // List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  // Placemark place = placemarks[0];
  // currentCity = place.subAdministrativeArea;
  // }

  // initializeLocation() async {
  //   if (await _checkLocationPermission()) {
  //     await _getCityFromLocation();
  //   }
  // }
}

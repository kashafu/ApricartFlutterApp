import 'dart:convert';

import 'package:apricart/app/locator.dart';
import 'package:apricart/models/address_model.dart';
import 'package:apricart/models/pickup_data_model.dart';
import 'package:apricart/models/user_data_model.dart';
import 'package:apricart/services/api_service.dart';
import 'package:apricart/services/auth_service.dart';
import 'package:apricart/services/data_service.dart';
import 'package:apricart/services/storage_service.dart';
import 'package:apricart/shared/app_colors.dart';
import 'package:apricart/shared/app_text_styles.dart';
import 'package:apricart/shared/helpers.dart';
import 'package:apricart/widgets/snackbars/app_default_snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.router.dart';

class DeliveryDetailsViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final apiService = locator<ApiService>();
  final storageService = locator<StorageService>();
  final dataService = locator<DataService>();
  final navigator = locator<NavigationService>();

  DeliveryDetailsViewModel(this.mainContext);
  BuildContext mainContext;

  UserData? get userData => authService.userData;
  String get orderType => dataService.homeDataType;

  String get name => authService.userData?.name ?? '';
  String get phone => authService.userData?.phoneNumber ?? '';
  TextEditingController deliveryInstructionsController = TextEditingController();
  FocusNode deliveryInstructionsFocus = FocusNode();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  moveToMyAddressesView() {
    navigator.navigateTo(Routes.myAddressesView)?.then((value) {
      initializeViewModel();
    });
  }

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
    // AddressChange
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

  moveToPaymentMethodSelectionView() {
    if (orderType == 'pickup') {
      if (pickupAddress == null) {
        AppDefaultSnackbars.showErrorSnackbar('Address is required');
      } else if (selectedPickupDay == null) {
        AppDefaultSnackbars.showErrorSnackbar('Pickup Day is required');
      } else if (selectedPickupTime == null) {
        AppDefaultSnackbars.showErrorSnackbar('Pickup time is required');
      } else {
        navigator.navigateTo(Routes.paymentInfoView,
            arguments: PaymentInfoViewArguments(
                address: Address(id: pickupAddress?.id),
                notes: deliveryInstructionsController.text,
                day: selectedPickupDay?.dateForServer ?? '',
                startTime: selectedPickupTime?.startTime ?? '',
                endTime: selectedPickupTime?.endTime ?? ''));
      }
    } else {
      if (selectedAddress == null) {
        //Error
        AppDefaultSnackbars.showErrorSnackbar('Address is required');
      } else {
        navigator.navigateTo(Routes.paymentInfoView,
            arguments: PaymentInfoViewArguments(
              address: selectedAddress!,
              notes: deliveryInstructionsController.text,
            ));
      }
    }
  }

  //Pickup
  bool processing = false;

  PickupData? pickupData;

  PickLocationDtoList? selectedPickupAddress;

  PickLocationDtoList? get pickupAddress {
    if (selectedPickupAddress != null) {
      return selectedPickupAddress;
    } else if (pickupData?.pickLocationDtoList != null) {
      return pickupData?.pickLocationDtoList?[0];
    } else {
      return null;
    }
  }

  loadPickupLocations() async {
    setBusy(true);
    try {
      pickupData = await apiService.getPickupData();
    } catch (e) {
      null;
    }
    setBusy(false);
  }

  selectPickupAddress() async {
    if (processing == false) {
      processing = true;
      notifyListeners();
      if (pickupData == null) {
        try {
          pickupData = await apiService.getPickupData();
        } catch (e) {
          null;
        }
      }
      if (pickupData != null) {
        dynamic res;
        await SelectDialog.showModal<PickLocationDtoList>(
          mainContext,
          items: pickupData?.pickLocationDtoList,
          label: "Select Location",
          useRootNavigator: true,
          showSearchBox: false,
          constraints: BoxConstraints(maxHeight: screenHeight(mainContext, multiplier: 0.5)),
          itemBuilder: (context, item, isSelected) => Container(
            width: 180,
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              item.name ?? 'unknown',
              style: AppTextStyles.regular16.copyWith(color: AppColors.black),
            ),
          ),
          emptyBuilder: (context) => Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          onChange: (item) {
            res = item;
          },
        );
        if (res is PickLocationDtoList) {
          selectedPickupAddress = res;
          selectedPickupTime = null;
        }
      }
      processing = false;
      notifyListeners();
    }
  }

  AvailableDates? selectedPickupDay;

  selectPickupDay() async {
    if (processing == false) {
      processing = true;
      notifyListeners();
      if (pickupData == null) {
        try {
          pickupData = await apiService.getPickupData();
        } catch (e) {
          null;
        }
      }
      if (pickupData != null) {
        dynamic res;
        await SelectDialog.showModal<AvailableDates>(
          mainContext,
          items: pickupData?.availableDates,
          label: "Select Day",
          useRootNavigator: true,
          showSearchBox: false,
          constraints: BoxConstraints(maxHeight: screenHeight(mainContext, multiplier: 0.5)),
          itemBuilder: (context, item, isSelected) => Container(
            width: 180,
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              item.displayDate ?? 'unknown',
              style: AppTextStyles.regular16.copyWith(color: AppColors.black),
            ),
          ),
          emptyBuilder: (context) => Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          onChange: (item) {
            res = item;
          },
        );
        if (res is AvailableDates) {
          selectedPickupDay = res;
          selectedPickupTime = null;
        }
      }
      processing = false;
      notifyListeners();
    }
  }

  DayTimings? selectedPickupTime;

  selectPickupTime() async {
    PickLocationDtoList? loc =
        pickupData?.pickLocationDtoList?.where((element) => element.id == pickupAddress?.id).toList()[0];

    if (processing == false) {
      processing = true;
      notifyListeners();
      if (pickupData != null) {
        dynamic res;
        await SelectDialog.showModal<DayTimings>(
          mainContext,
          items: selectedPickupDay?.identifier == "timingsFirstDay" ? loc?.timingsFirstDay : loc?.timingsSecondDay,
          label: "Select Time",
          useRootNavigator: true,
          showSearchBox: false,
          constraints: BoxConstraints(maxHeight: screenHeight(mainContext, multiplier: 0.5)),
          itemBuilder: (context, item, isSelected) => Container(
            width: 180,
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              item.displayTime ?? 'unknown',
              style: AppTextStyles.regular16.copyWith(color: AppColors.black),
            ),
          ),
          emptyBuilder: (context) => Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          onChange: (item) {
            res = item;
          },
        );
        if (res is DayTimings) {
          selectedPickupTime = res;
        }
      }
      processing = false;
      notifyListeners();
    }
  }

  initializeViewModel() async {
    setBusy(true);
    await Future.delayed(const Duration(microseconds: 1));
    setBusy(false);
    if (userData != null) {
      if (orderType == 'delivery') {
        loadAddresses();
      } else {
        loadPickupLocations();
      }
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

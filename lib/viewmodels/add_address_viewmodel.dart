import 'package:apricart/app/locator.dart';
import 'package:apricart/models/address_area_model.dart';
import 'package:apricart/models/address_city_model.dart';
import 'package:apricart/models/address_model.dart';
import 'package:apricart/services/api_service.dart';
import 'package:apricart/shared/app_colors.dart';
import 'package:apricart/shared/app_text_styles.dart';
import 'package:apricart/widgets/snackbars/app_default_snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/auth_service.dart';

class AddAddressViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final authService = locator<AuthService>();
  final navigator = locator<NavigationService>();

  final BuildContext mainContext;
  final Address? initialAddress;
  AddAddressViewModel(this.mainContext, this.initialAddress);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController additionalDetailsController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode additionalDetailsFocus = FocusNode();

  AddressCity? selectedCity;
  AddressArea? selectedArea;

  List<AddressCity> cities = <AddressCity>[];
  List<AddressArea> areas = <AddressArea>[];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  loadAddressCities() async {
    setBusy(true);
    try {
      cities = await apiService.getAddressCities();
    } catch (e) {
      null;
    }
    setBusy(false);
  }

  loadAddressAreas(int? id) async {
    try {
      areas = <AddressArea>[];
      areas = await apiService.getAddressAreas(id);
    } catch (e) {
      null;
    }
  }

  bool processing = false;
  openCitySelectionDialog() async {
    if (processing == false) {
      processing = true;
      notifyListeners();
      if (cities.isEmpty) {
        await loadAddressCities();
      }
      if (cities.isNotEmpty) {
        dynamic res;
        await SelectDialog.showModal<AddressCity>(
          mainContext,
          items: cities,
          label: "Select City",
          useRootNavigator: true,
          itemBuilder: (context, item, isSelected) => Container(
            width: 180,
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              item.city ?? 'unknown',
              style: AppTextStyles.regular16.copyWith(color: AppColors.black),
            ),
          ),
          emptyBuilder: (context) => Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          onFind: (text) async {
            return cities
                .where((element) => (element.city?.toLowerCase().contains(text.toLowerCase()) ?? false))
                .toList();
          },
          onChange: (item) {
            res = item;
          },
        );
        if (res is AddressCity) {
          if (res.id != (selectedCity?.id ?? -1)) {
            selectedArea = null;
          }
          selectedCity = res;
          notifyListeners();
          await loadAddressAreas(selectedCity?.id);
        }
      }
    }
    processing = false;
    notifyListeners();
  }

  openAreaSelectionDialog() async {
    if (processing == false) {
      processing = true;
      notifyListeners();
      if (selectedCity != null) {
        if (areas.isEmpty) {
          await loadAddressAreas(selectedCity?.id);
        }
        if (areas.isNotEmpty) {
          dynamic res;
          await SelectDialog.showModal<AddressArea>(
            mainContext,
            items: areas,
            label: "Select Area",
            useRootNavigator: true,
            itemBuilder: (context, item, isSelected) => Container(
              width: 180,
              height: 40,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                item.town ?? 'unknown',
                style: AppTextStyles.regular16.copyWith(color: AppColors.black),
              ),
            ),
            emptyBuilder: (context) => Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
            onFind: (text) async {
              return areas
                  .where((element) => element.town?.toLowerCase().contains(text.toLowerCase()) ?? false)
                  .toList();
            },
            onChange: (item) {
              res = item;
            },
          );
          if (res is AddressArea) {
            selectedArea = res;
          }
        }
      }
    }
    processing = false;
    notifyListeners();
  }

  String? selectedLocation;

  selectLocation(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              "AIzaSyB-VSGrsQGK26wBb3kYEoiYVA0j5ZX9O1w",
            )));

    // Handle the result in your way
    if (result is LocationResult) {
      selectedLocation = result.formattedAddress.toString();
    }
    notifyListeners();
  }

  bool validateFields() {
    if (nameController.text.isEmpty) {
      AppDefaultSnackbars.showErrorSnackbar("Name field cannot be empty");
      return false;
    } else if (phoneController.text.isEmpty) {
      AppDefaultSnackbars.showErrorSnackbar("Phone number field cannot be empty");
      return false;
    } else if (selectedCity == null) {
      AppDefaultSnackbars.showErrorSnackbar("Please select a city");
      return false;
    } else if (selectedArea == null) {
      AppDefaultSnackbars.showErrorSnackbar("Please select area");
      return false;
    } else if (selectedLocation == null) {
      AppDefaultSnackbars.showErrorSnackbar("Please enter your location");
      return false;
    } else {
      return true;
    }
  }

  submitAddress() async {
    if (validateFields()) {
      isLoading = true;
      try {
        if (initialAddress == null) {
          await apiService.addDeliveryAddress(
            nameController.text,
            "92${phoneController.text}",
            additionalDetailsController.text,
            selectedLocation ?? '',
            selectedArea?.id ?? 0,
          );
        } else {
          await apiService.updateDeliveryAddress(
            initialAddress?.id ?? -1,
            nameController.text,
            "92${phoneController.text}",
            additionalDetailsController.text,
            selectedLocation ?? '',
            selectedArea?.id ?? 0,
          );
        }
        navigator.back(result: true);
      } catch (e) {
        null;
      }
      isLoading = false;
    }
  }

  initializeViewModel() async {
    nameController.text = authService.userData?.name ?? '';
    phoneController.text = authService.userData?.phoneNumber?.substring(2) ?? '';
    try {
      await loadAddressCities();
      if (initialAddress != null) {
        if (cities.isNotEmpty) {
          selectedCity = cities.where((element) => element.id == initialAddress?.cityId).toList()[0];
        }
        setBusy(true);
        if (selectedCity != null) {
          await loadAddressAreas(selectedCity?.id);
        }
        if (areas.isNotEmpty) {
          selectedArea = areas.where((element) => element.id == initialAddress?.areaId).toList()[0];
        }
        selectedLocation = initialAddress?.googleAddress;
        additionalDetailsController.text = initialAddress?.address ?? '';
        setBusy(false);
      }
    } catch (e) {
      setBusy(false);
      null;
    }
  }

  disposeViewModel() {
    nameController.dispose();
    phoneController.dispose();
    additionalDetailsController.dispose();
    nameFocus.dispose();
    phoneFocus.dispose();
    additionalDetailsFocus.dispose();
  }
}

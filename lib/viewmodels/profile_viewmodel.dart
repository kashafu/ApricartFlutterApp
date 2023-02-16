import 'package:apricart/app/app.router.dart';
import 'package:apricart/models/user_data_model.dart';
import 'package:apricart/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';
import '../services/auth_service.dart';

class ProfileViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final navigator = locator<NavigationService>();
  final apiService = locator<ApiService>();

  UserData? get userData => authService.userData;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  disposeViewModel() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
  }

  initializeViewModel() async {
    setBusy(true);
    await Future.delayed(const Duration(microseconds: 1));
    setBusy(false);
    if (userData != null) {
      nameController.text = userData!.name ?? '';
      emailController.text = userData!.email ?? '';
      phoneController.text = userData!.phoneNumber?.substring(2) ?? '';
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

  save() async {
    if (_isLoading == false) {
      isLoading = true;
      try {
        await apiService.updateProfile(nameController.text, emailController.text);
        authService.userData?.name = nameController.text;
        authService.userData?.email = emailController.text;
        navigator.back();
      } catch (e) {
        null;
      }
      isLoading = false;
    }
  }
}

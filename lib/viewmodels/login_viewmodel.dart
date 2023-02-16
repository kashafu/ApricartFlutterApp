import 'package:apricart/app/app.router.dart';
import 'package:apricart/app/locator.dart';
import 'package:apricart/services/auth_service.dart';
import 'package:apricart/views/nav_wrapper/nav_wrapper_view.dart';
import 'package:apricart/widgets/snackbars/app_default_snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final navigator = locator<NavigationService>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  validateAndLogin() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_isLoading == false) {
      isLoading = true;
      try {
        if (phoneController.text.isEmpty) {
          AppDefaultSnackbars.showErrorSnackbar("Phone number field cannot be empty");
        } else if (passwordController.text.isEmpty) {
          AppDefaultSnackbars.showErrorSnackbar("Password field cannot be empty");
        } else if (phoneController.text.length != 10) {
          AppDefaultSnackbars.showErrorSnackbar("Please enter a valid phone number");
        } else if (passwordController.text.length < 6) {
          AppDefaultSnackbars.showErrorSnackbar("Invalid Password");
        } else {
          await authService.loginUser("92${phoneController.text}", passwordController.text);
          navigator.back();
        }
      } catch (e) {
        null;
      }
      isLoading = false;
    }
  }

  moveToCreateAccountView() {
    navigator.navigateTo(Routes.createAccountView)?.then((value) {
      if (authService.userData != null) {
        navigator.back();
      }
    });
  }

  moveToForgotPasswordView() {
    navigator.navigateTo(Routes.forgotPasswordView)?.then((value) {
      if (authService.userData != null) {
        navigator.back();
      }
    });
  }

  disposeViewModel() {
    phoneController.dispose();
    passwordController.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
  }
}

import 'package:apricart/app/app.router.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';
import '../services/auth_service.dart';

class CreateAccountViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final navigator = locator<NavigationService>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  validateAndSignUp() async {
    if (_isLoading == false) {
      isLoading = true;
      try {
        final res = await authService.registerUser(
            nameController.text, emailController.text, "92${phoneController.text}", passwordController.text);
        if (res == true) {
          navigator.navigateTo(Routes.otpView, arguments: OtpViewArguments(phoneNumber: "92${phoneController.text}"));
        }
      } catch (e) {}
      isLoading = false;
    }
  }

  disposeViewModel() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    phoneFocus.dispose();
  }
}

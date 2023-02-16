import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';
import '../services/auth_service.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final navigator = locator<NavigationService>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  List<TextEditingController> codeControllers = List.generate(4, (index) => TextEditingController());
  List<FocusNode> codeFocusNodes = List.generate(4, (index) => FocusNode());
  List<String> previousValues = List.generate(4, (index) => '');

  String get code => List.generate(4, (index) => codeControllers[index].text).join();

  updatePreviousValue() {
    for (var index = 0; index < 4; index++) {
      previousValues[index] = codeControllers[index].text;
    }
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool otpSent = false;

  sendOtp() async {
    if (_isLoading == false) {
      isLoading = true;
      try {
        await authService.sendOtp("92${phoneController.text}");
        otpSent = true;
      } catch (e) {
        null;
      }
      isLoading = false;
    }
  }

  changePassword() async {
    if (_isLoading == false) {
      isLoading = true;
      try {
        await authService.forgotPassword("92${phoneController.text}", passwordController.text, code);
        navigator.back();
      } catch (e) {
        null;
      }
      isLoading = false;
    }
  }

  disposeViewModel() {
    codeControllers.forEach((element) {
      element.dispose();
    });
    codeFocusNodes.forEach((element) {
      element.dispose();
    });
    passwordController.dispose();
    phoneController.dispose();
    passwordFocus.dispose();
    phoneFocus.dispose();
  }
}

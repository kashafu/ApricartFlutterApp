import 'package:apricart/app/app.router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';
import '../services/auth_service.dart';

class OtpViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final navigator = locator<NavigationService>();

  OtpViewModel(this.phoneNumber);

  final String phoneNumber;

  List<TextEditingController> codeControllers = List.generate(4, (index) => TextEditingController());
  List<FocusNode> codeFocusNodes = List.generate(4, (index) => FocusNode());
  List<String> previousValues = List.generate(4, (index) => '');

  String get code => List.generate(4, (index) => codeControllers[index].text).join();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  updatePreviousValue() {
    for (var index = 0; index < 4; index++) {
      previousValues[index] = codeControllers[index].text;
    }
  }

  disposeViewModel() {
    codeControllers.forEach((element) {
      element.dispose();
    });
    codeFocusNodes.forEach((element) {
      element.dispose();
    });
  }

  resendOtp() async {
    setBusy(true);
    try {
      await authService.sendOtp(phoneNumber);
    } catch (e) {
      null;
    }
    setBusy(false);
  }

  validateOtp() async {
    if (_isLoading == false) {
      isLoading = true;
      try {
        final res = await authService.verifyOtp(phoneNumber, code);
        if (res == true) {
          navigator.popUntil(ModalRoute.withName(Routes.loginView));
        }
      } catch (e) {
        null;
      }
      isLoading = false;
    }
  }

  initializeViewModel() {
    // resendOtp();
  }
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class ContactUsViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final apiService = locator<ApiService>();
  final navigator = locator<NavigationService>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode commentFocus = FocusNode();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  sendContactUsInfo() async {
    if (_isLoading == false) {
      isLoading = true;
      try {
        await apiService.sendContactUsRequest(
          nameController.text,
          emailController.text,
          "92${phoneController.text}",
          commentController.text,
        );
        commentController.text = '';
        // Show success toast
        print("SUccess");
      } catch (e) {
        null;
      }
      isLoading = false;
    }
  }

  initializeViewModel() {
    if (authService.userData != null) {
      nameController.text = authService.userData?.name ?? '';
      emailController.text = authService.userData?.email ?? '';
      phoneController.text = authService.userData?.phoneNumber ?? '';
    }
  }

  disposeViewModel() {
    emailController.dispose();
    nameController.dispose();
    commentController.dispose();
    phoneController.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    commentFocus.dispose();
    phoneFocus.dispose();
  }
}

import 'package:apricart/app/app.router.dart';
import 'package:apricart/app/locator.dart';
import 'package:apricart/models/user_data_model.dart';
import 'package:apricart/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final navigator = locator<NavigationService>();

  UserData? get userData => authService.userData;

  loginLogoutUser() {
    if (userData == null) {
      navigator.navigateTo(Routes.loginView)?.then((value) {
        notifyListeners();
      });
    } else {
      authService.logoutUser();
    }
    notifyListeners();
  }

  openProfileView() {
    navigator.navigateTo(Routes.profileView)?.then((value) {
      notifyListeners();
    });
  }

  openMyAddressesView() {
    navigator.navigateTo(Routes.myAddressesView)?.then((value) {
      notifyListeners();
    });
  }

  openContactUsView() {
    navigator.navigateTo(Routes.contactUsview);
  }

  openOrderHistoryView() {
    navigator.navigateTo(Routes.orderHistoryView)?.then((value) {
      notifyListeners();
    });
  }

  launch(String url) async {
    launchUrl(Uri.parse(url));
  }
}

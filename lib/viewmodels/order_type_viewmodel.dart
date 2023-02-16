import 'package:apricart/app/app.router.dart';
import 'package:apricart/app/locator.dart';
import 'package:apricart/constants/assets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OrderTypeViewModel extends BaseViewModel {
  final navigator = locator<NavigationService>();

  List<String> carousalItems = [
    "https://cbe.apricart.pk/options/stream/chatkhraydar1mainapp_2022-10-31T13_07_06.581210.png",
    "https://cbe.apricart.pk/options/stream/chatkhraydar1mainapp_2022-10-31T13_07_06.581210.png",
    "https://cbe.apricart.pk/options/stream/chatkhraydar1mainapp_2022-10-31T13_07_06.581210.png",
  ];

  navigateToHome() {
    navigator.navigateTo(Routes.navWrapperView);
  }
}

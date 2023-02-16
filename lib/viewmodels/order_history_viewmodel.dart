import 'package:apricart/app/locator.dart';
import 'package:apricart/models/order_history_model.dart';
import 'package:apricart/models/user_data_model.dart';
import 'package:apricart/services/api_service.dart';
import 'package:apricart/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.router.dart';

class OrderHistoryViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final authService = locator<AuthService>();
  final navigator = locator<NavigationService>();

  UserData? get userData => authService.userData;
  OrderHistory? orderHistory;

  openOrderDetail(String id, String? lat, String? long) {
    navigator.navigateTo(Routes.orderDetailView, arguments: OrderDetailViewArguments(id: id, lat: lat, long: long));
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  cancelOrder(OrderHistoryItem item) async {
    // if (item.)
    if (DateTime.parse(item.createdAt ?? '').add(const Duration(minutes: 10)).isAfter(DateTime.now())) {
      isLoading = true;
      try {
        print(item.orderId.toString());
        await apiService.cancelOrder(item.orderId.toString());
        orderHistory = await apiService.getOrderHistory();
      } catch (e) {
        null;
      }
      isLoading = false;
    }
  }

  initializeViewModel() async {
    setBusy(true);
    await Future.delayed(const Duration(microseconds: 1));
    setBusy(false);
    if (userData != null) {
      setBusy(true);
      try {
        orderHistory = await apiService.getOrderHistory();
      } catch (e) {
        null;
      }
      setBusy(false);
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

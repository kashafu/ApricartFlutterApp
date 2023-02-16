import 'package:apricart/app/app.router.dart';
import 'package:apricart/app/locator.dart';
import 'package:apricart/models/checkout_modal.dart';
import 'package:apricart/models/payment_method_model.dart';
import 'package:apricart/services/api_service.dart';
import 'package:apricart/views/order_placed/order_placed_view.dart';
import 'package:apricart/widgets/snackbars/app_default_snackbars.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PaymentInfoViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final navigator = locator<NavigationService>();

  PaymentMethod? selectedMethod;

  List<PaymentMethod> paymentMethods = <PaymentMethod>[];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  getPaymentMethods() async {
    setBusy(true);
    try {
      paymentMethods = await apiService.getPaymentMethods();
    } catch (e) {
      null;
    }
    setBusy(false);
  }

  processOrder(int addressId, String notes, String day, String startTime, String endTime) async {
    isLoading = true;
    try {
      if (selectedMethod != null) {
        CheckoutModal res =
            await apiService.checkout(addressId, notes, selectedMethod?.key ?? '', day, startTime, endTime);
        if ((res.paymentUrl ?? '').isNotEmpty) {
          //WebView
          navigator.navigateTo(Routes.onlinePaymentView,
              arguments: OnlinePaymentViewArguments(webViewUrl: res.paymentUrl!));
        } else {
          navigator.navigateTo(Routes.orderPlacedView,
              arguments:
                  OrderPlacedViewArguments(message: res.message ?? '', lat: res.pickupMapLat, long: res.pickupMapLong));
        }
      } else {
        AppDefaultSnackbars.showErrorSnackbar('Select payment method');
      }
    } catch (e) {
      null;
    }
    isLoading = false;
  }

  initializeViewModel() {
    getPaymentMethods();
  }
}

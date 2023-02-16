import 'package:apricart/views/add_address/add_address_view.dart';
import 'package:apricart/views/contact_us/contact_us_view.dart';
import 'package:apricart/views/create_account/create_account_view.dart';
import 'package:apricart/views/delivery_details/delivery_details_view.dart';
import 'package:apricart/views/forgot_password/forgot_password_view.dart';
import 'package:apricart/views/login/login_view.dart';
import 'package:apricart/views/my_addresses/my_addresses_view.dart';
import 'package:apricart/views/nav_wrapper/nav_wrapper_view.dart';
import 'package:apricart/views/online_payment/online_payment_view.dart';
import 'package:apricart/views/order_detail/order_detail_view.dart';
import 'package:apricart/views/order_history/order_history_view.dart';
import 'package:apricart/views/order_placed/order_placed_view.dart';
import 'package:apricart/views/order_type/order_type_view.dart';
import 'package:apricart/views/otp/otp_view.dart';
import 'package:apricart/views/payment_info/payment_info_view.dart';
import 'package:apricart/views/product_detail/product_detail_view.dart';
import 'package:apricart/views/profile/profile_view.dart';
import 'package:apricart/views/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: OrderTypeView),
    MaterialRoute(page: NavWrapperView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: OtpView),
    MaterialRoute(page: CreateAccountView),
    MaterialRoute(page: ContactUsview),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: ForgotPasswordView),
    MaterialRoute(page: DeliveryDetailsView),
    MaterialRoute(page: MyAddressesView),
    MaterialRoute(page: AddAddressView),
    MaterialRoute(page: PaymentInfoView),
    MaterialRoute(page: OrderPlacedView),
    MaterialRoute(page: OrderHistoryView),
    MaterialRoute(page: OrderDetailView),
    MaterialRoute(page: ProductDetailView),
    MaterialRoute(page: OnlinePaymentView),
  ],
)
class AppSetup {}

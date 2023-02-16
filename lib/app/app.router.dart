// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:apricart/models/address_model.dart' as _i21;
import 'package:apricart/views/add_address/add_address_view.dart' as _i13;
import 'package:apricart/views/contact_us/contact_us_view.dart' as _i8;
import 'package:apricart/views/create_account/create_account_view.dart' as _i7;
import 'package:apricart/views/delivery_details/delivery_details_view.dart'
    as _i11;
import 'package:apricart/views/forgot_password/forgot_password_view.dart'
    as _i10;
import 'package:apricart/views/login/login_view.dart' as _i5;
import 'package:apricart/views/my_addresses/my_addresses_view.dart' as _i12;
import 'package:apricart/views/nav_wrapper/nav_wrapper_view.dart' as _i4;
import 'package:apricart/views/online_payment/online_payment_view.dart' as _i19;
import 'package:apricart/views/order_detail/order_detail_view.dart' as _i17;
import 'package:apricart/views/order_history/order_history_view.dart' as _i16;
import 'package:apricart/views/order_placed/order_placed_view.dart' as _i15;
import 'package:apricart/views/order_type/order_type_view.dart' as _i3;
import 'package:apricart/views/otp/otp_view.dart' as _i6;
import 'package:apricart/views/payment_info/payment_info_view.dart' as _i14;
import 'package:apricart/views/product_detail/product_detail_view.dart' as _i18;
import 'package:apricart/views/profile/profile_view.dart' as _i9;
import 'package:apricart/views/splash/splash_view.dart' as _i2;
import 'package:flutter/material.dart' as _i20;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i22;

class Routes {
  static const splashView = '/';

  static const orderTypeView = '/order-type-view';

  static const navWrapperView = '/nav-wrapper-view';

  static const loginView = '/login-view';

  static const otpView = '/otp-view';

  static const createAccountView = '/create-account-view';

  static const contactUsview = '/contact-usview';

  static const profileView = '/profile-view';

  static const forgotPasswordView = '/forgot-password-view';

  static const deliveryDetailsView = '/delivery-details-view';

  static const myAddressesView = '/my-addresses-view';

  static const addAddressView = '/add-address-view';

  static const paymentInfoView = '/payment-info-view';

  static const orderPlacedView = '/order-placed-view';

  static const orderHistoryView = '/order-history-view';

  static const orderDetailView = '/order-detail-view';

  static const productDetailView = '/product-detail-view';

  static const onlinePaymentView = '/online-payment-view';

  static const all = <String>{
    splashView,
    orderTypeView,
    navWrapperView,
    loginView,
    otpView,
    createAccountView,
    contactUsview,
    profileView,
    forgotPasswordView,
    deliveryDetailsView,
    myAddressesView,
    addAddressView,
    paymentInfoView,
    orderPlacedView,
    orderHistoryView,
    orderDetailView,
    productDetailView,
    onlinePaymentView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.orderTypeView,
      page: _i3.OrderTypeView,
    ),
    _i1.RouteDef(
      Routes.navWrapperView,
      page: _i4.NavWrapperView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i5.LoginView,
    ),
    _i1.RouteDef(
      Routes.otpView,
      page: _i6.OtpView,
    ),
    _i1.RouteDef(
      Routes.createAccountView,
      page: _i7.CreateAccountView,
    ),
    _i1.RouteDef(
      Routes.contactUsview,
      page: _i8.ContactUsview,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i9.ProfileView,
    ),
    _i1.RouteDef(
      Routes.forgotPasswordView,
      page: _i10.ForgotPasswordView,
    ),
    _i1.RouteDef(
      Routes.deliveryDetailsView,
      page: _i11.DeliveryDetailsView,
    ),
    _i1.RouteDef(
      Routes.myAddressesView,
      page: _i12.MyAddressesView,
    ),
    _i1.RouteDef(
      Routes.addAddressView,
      page: _i13.AddAddressView,
    ),
    _i1.RouteDef(
      Routes.paymentInfoView,
      page: _i14.PaymentInfoView,
    ),
    _i1.RouteDef(
      Routes.orderPlacedView,
      page: _i15.OrderPlacedView,
    ),
    _i1.RouteDef(
      Routes.orderHistoryView,
      page: _i16.OrderHistoryView,
    ),
    _i1.RouteDef(
      Routes.orderDetailView,
      page: _i17.OrderDetailView,
    ),
    _i1.RouteDef(
      Routes.productDetailView,
      page: _i18.ProductDetailView,
    ),
    _i1.RouteDef(
      Routes.onlinePaymentView,
      page: _i19.OnlinePaymentView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashView(),
        settings: data,
      );
    },
    _i3.OrderTypeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.OrderTypeView(),
        settings: data,
      );
    },
    _i4.NavWrapperView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.NavWrapperView(),
        settings: data,
      );
    },
    _i5.LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.LoginView(),
        settings: data,
      );
    },
    _i6.OtpView: (data) {
      final args = data.getArgs<OtpViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i6.OtpView(key: args.key, phoneNumber: args.phoneNumber),
        settings: data,
      );
    },
    _i7.CreateAccountView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.CreateAccountView(),
        settings: data,
      );
    },
    _i8.ContactUsview: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.ContactUsview(),
        settings: data,
      );
    },
    _i9.ProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.ProfileView(),
        settings: data,
      );
    },
    _i10.ForgotPasswordView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.ForgotPasswordView(),
        settings: data,
      );
    },
    _i11.DeliveryDetailsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.DeliveryDetailsView(),
        settings: data,
      );
    },
    _i12.MyAddressesView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.MyAddressesView(),
        settings: data,
      );
    },
    _i13.AddAddressView: (data) {
      final args = data.getArgs<AddAddressViewArguments>(
        orElse: () => const AddAddressViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i13.AddAddressView(
            key: args.key, initialAddress: args.initialAddress),
        settings: data,
      );
    },
    _i14.PaymentInfoView: (data) {
      final args = data.getArgs<PaymentInfoViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i14.PaymentInfoView(
            key: args.key,
            address: args.address,
            notes: args.notes,
            day: args.day,
            startTime: args.startTime,
            endTime: args.endTime),
        settings: data,
      );
    },
    _i15.OrderPlacedView: (data) {
      final args = data.getArgs<OrderPlacedViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i15.OrderPlacedView(
            key: args.key,
            message: args.message,
            lat: args.lat,
            long: args.long),
        settings: data,
      );
    },
    _i16.OrderHistoryView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.OrderHistoryView(),
        settings: data,
      );
    },
    _i17.OrderDetailView: (data) {
      final args = data.getArgs<OrderDetailViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i17.OrderDetailView(
            key: args.key, id: args.id, lat: args.lat, long: args.long),
        settings: data,
      );
    },
    _i18.ProductDetailView: (data) {
      final args = data.getArgs<ProductDetailViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i18.ProductDetailView(key: args.key, sku: args.sku),
        settings: data,
      );
    },
    _i19.OnlinePaymentView: (data) {
      final args = data.getArgs<OnlinePaymentViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i19.OnlinePaymentView(key: args.key, webViewUrl: args.webViewUrl),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class OtpViewArguments {
  const OtpViewArguments({
    this.key,
    required this.phoneNumber,
  });

  final _i20.Key? key;

  final String phoneNumber;
}

class AddAddressViewArguments {
  const AddAddressViewArguments({
    this.key,
    this.initialAddress,
  });

  final _i20.Key? key;

  final _i21.Address? initialAddress;
}

class PaymentInfoViewArguments {
  const PaymentInfoViewArguments({
    this.key,
    required this.address,
    required this.notes,
    this.day = '',
    this.startTime = '',
    this.endTime = '',
  });

  final _i20.Key? key;

  final _i21.Address address;

  final String notes;

  final String day;

  final String startTime;

  final String endTime;
}

class OrderPlacedViewArguments {
  const OrderPlacedViewArguments({
    this.key,
    required this.message,
    this.lat,
    this.long,
  });

  final _i20.Key? key;

  final String message;

  final String? lat;

  final String? long;
}

class OrderDetailViewArguments {
  const OrderDetailViewArguments({
    this.key,
    required this.id,
    required this.lat,
    required this.long,
  });

  final _i20.Key? key;

  final String id;

  final String? lat;

  final String? long;
}

class ProductDetailViewArguments {
  const ProductDetailViewArguments({
    this.key,
    required this.sku,
  });

  final _i20.Key? key;

  final String sku;
}

class OnlinePaymentViewArguments {
  const OnlinePaymentViewArguments({
    this.key,
    required this.webViewUrl,
  });

  final _i20.Key? key;

  final String webViewUrl;
}

extension NavigatorStateExtension on _i22.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrderTypeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.orderTypeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNavWrapperView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.navWrapperView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOtpView({
    _i20.Key? key,
    required String phoneNumber,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.otpView,
        arguments: OtpViewArguments(key: key, phoneNumber: phoneNumber),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateAccountView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createAccountView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToContactUsview([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.contactUsview,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForgotPasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.forgotPasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDeliveryDetailsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.deliveryDetailsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMyAddressesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.myAddressesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddAddressView({
    _i20.Key? key,
    _i21.Address? initialAddress,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addAddressView,
        arguments:
            AddAddressViewArguments(key: key, initialAddress: initialAddress),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPaymentInfoView({
    _i20.Key? key,
    required _i21.Address address,
    required String notes,
    String day = '',
    String startTime = '',
    String endTime = '',
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.paymentInfoView,
        arguments: PaymentInfoViewArguments(
            key: key,
            address: address,
            notes: notes,
            day: day,
            startTime: startTime,
            endTime: endTime),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrderPlacedView({
    _i20.Key? key,
    required String message,
    String? lat,
    String? long,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.orderPlacedView,
        arguments: OrderPlacedViewArguments(
            key: key, message: message, lat: lat, long: long),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrderHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.orderHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrderDetailView({
    _i20.Key? key,
    required String id,
    required String? lat,
    required String? long,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.orderDetailView,
        arguments:
            OrderDetailViewArguments(key: key, id: id, lat: lat, long: long),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProductDetailView({
    _i20.Key? key,
    required String sku,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.productDetailView,
        arguments: ProductDetailViewArguments(key: key, sku: sku),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnlinePaymentView({
    _i20.Key? key,
    required String webViewUrl,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.onlinePaymentView,
        arguments: OnlinePaymentViewArguments(key: key, webViewUrl: webViewUrl),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}

import 'package:apricart/app/app.router.dart';
import 'package:apricart/app/exceptions.dart';
import 'package:apricart/app/locator.dart';
import 'package:apricart/models/home_data_model.dart';
import 'package:apricart/models/user_data_model.dart';
import 'package:apricart/services/auth_service.dart';
import 'package:apricart/services/cart_service.dart';
import 'package:apricart/widgets/dialogs/cart_out_of_stock_dialog.dart';
import 'package:apricart/widgets/dialogs/min_order_dialog.dart';
import 'package:apricart/widgets/snackbars/app_default_snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../widgets/dialogs/cart_continue_dialog.dart';

class CartViewModel extends BaseViewModel {
  final cartService = locator<CartService>();
  final authService = locator<AuthService>();
  final navigator = locator<NavigationService>();

  List<Products> get cart => cartService.cart;
  UserData? get userData => authService.userData;

  TextEditingController promoController = TextEditingController();

  applyPromoCode() async {
    if (promoController.text.isNotEmpty) {
      if (userData != null) {
        //Apply Code
        cartService.promoCode = promoController.text;
        setBusy(true);
        try {
          await cartService.loadCartItem();
        } catch (e) {
          null;
        }
        setBusy(false);
        promoController.clear();
        if ((cartService.checkoutData?.coupon ?? false) == false) {
          AppDefaultSnackbars.showErrorSnackbar(cartService.checkoutData?.couponMessage ?? 'Failed to apply code');
        }
      } else {
        navigator.navigateTo(Routes.loginView)?.then((value) {
          if (userData == null) {
            null;
          } else {
            applyPromoCode();
          }
        });
      }
    }
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  addToCart(Products product) async {
    if (_isLoading == false) {
      isLoading = true;
      try {
        await cartService.addToCart(product);
      } catch (e) {
        null;
      }
      isLoading = false;
    }
  }

  subtractFromCart(Products product) async {
    if (_isLoading == false) {
      isLoading = true;
      try {
        await cartService.subtractFromCart(product);
      } catch (e) {
        null;
      }
      isLoading = false;
    }
  }

  deleteFromCart(Products product) async {
    if (_isLoading == false) {
      isLoading = true;
      try {
        await cartService.deleteFromCart(product);
      } catch (e) {
        null;
      }
      isLoading = false;
    }
  }

  void moveToOrderDetailView() async {
    for (Products item in cart) {
      if (item.inStock == false) {
        showDialog(context: StackedService.navigatorKey!.currentContext!, builder: (_) => CartOutOfStockDialog());
        return;
      }
    }
    if (cart.isEmpty) {
      return;
    } else if (cartService.checkoutData?.isMinOrder == true) {
      showDialog(
          context: StackedService.navigatorKey!.currentContext!,
          builder: (_) => MinOrderDialog(message: cartService.checkoutData?.isMinOrderMessage ?? ''));
      return;
    } else if (cartService.checkoutData?.isContinue == false) {
      final res = await showDialog(
          context: StackedService.navigatorKey!.currentContext!,
          builder: (_) => ContinueCartDialog(message: cartService.checkoutData?.isContinueMessage ?? ''));
      if (res == true) {
        await navigator.navigateTo(Routes.deliveryDetailsView);
        setBusy(true);
        try {
          await cartService.loadCartItem();
        } catch (e) {
          e.toString();
        }
        setBusy(false);
      }
      return;
    } else {
      await navigator.navigateTo(Routes.deliveryDetailsView);
      setBusy(true);
      try {
        await cartService.loadCartItem();
      } catch (e) {
        e.toString();
      }
      setBusy(false);
    }
  }

  initializeViewModel() async {
    cartService.promoCode = null;
    setBusy(true);
    try {
      await cartService.loadCartItem();
    } catch (e) {
      e.toString();
    }
    setBusy(false);
  }

  disposeViewModel() {
    promoController.dispose();
  }
}

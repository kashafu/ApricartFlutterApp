import 'package:apricart/app/exceptions.dart';
import 'package:apricart/app/locator.dart';
import 'package:apricart/models/checkout_modal.dart';
import 'package:apricart/models/home_data_model.dart';
import 'package:apricart/services/api_service.dart';
import 'package:apricart/services/auth_service.dart';
import 'package:apricart/services/misc_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CartService {
  AuthService get authService => locator<AuthService>();
  final apiService = locator<ApiService>();
  final miscService = locator<MiscService>();

  CheckoutModal? checkoutData;
  List<Products> get cart => checkoutData?.products ?? <Products>[];

  String? promoCode;

  int getProductQuantityFromCart(Products product) {
    List<Products> matches = cart.where((element) => element.sku == product.sku).toList();
    if (matches.isEmpty) {
      return 0;
    } else {
      return matches[0].qty ?? 0;
    }
  }

  addQtyToCart(Products product, int qty) async {
    try {
      if (authService.userData == null) {
        await apiService.addCartGuest(product.sku ?? '', qty);
      } else {
        await apiService.addCart(product.sku ?? '', qty);
      }
      await loadCartItem();
    } catch (e) {
      rethrow;
    }
  }

  addToCart(Products product) async {
    try {
      if (authService.userData == null) {
        await apiService.addCartGuest(
          product.sku ?? '',
          getProductQuantityFromCart(product) == 0 ? (product.minQty ?? 1) : (getProductQuantityFromCart(product) + 1),
        );
      } else {
        await apiService.addCart(
          product.sku ?? '',
          getProductQuantityFromCart(product) == 0 ? (product.minQty ?? 1) : (getProductQuantityFromCart(product) + 1),
        );
      }
      await loadCartItem();
    } catch (e) {
      rethrow;
    }
  }

  subtractFromCart(Products product) async {
    try {
      if (getProductQuantityFromCart(product) > (product.minQty ?? 1)) {
        if (authService.userData == null) {
          await apiService.addCartGuest(product.sku ?? '', getProductQuantityFromCart(product) - 1);
        } else {
          await apiService.addCart(product.sku ?? '', getProductQuantityFromCart(product) - 1);
        }
      } else {
        if (authService.userData == null) {
          await apiService.deleteCartGuest(product.sku ?? '');
        } else {
          await apiService.deleteCart(product.sku ?? '');
        }
      }
      await loadCartItem();
    } catch (e) {
      rethrow;
    }
  }

  deleteFromCart(Products product) async {
    try {
      if (authService.userData == null) {
        await apiService.deleteCartGuest(product.sku ?? '');
      } else {
        await apiService.deleteCart(product.sku ?? '');
      }
      await loadCartItem();
    } catch (e) {
      rethrow;
    }
  }

  loadCartItem() async {
    try {
      checkoutData = null;
      checkoutData = await apiService.getCheckoutData(promoCode);
      if (checkoutData != null) {
        int count = 0;
        checkoutData?.products?.forEach((product) {
          count += getProductQuantityFromCart(product);
        });
        miscService.setItemsInCart(count);
      }
    } catch (e) {
      rethrow;
    }
  }
}

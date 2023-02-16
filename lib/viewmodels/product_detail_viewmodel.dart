import 'package:apricart/app/locator.dart';
import 'package:apricart/models/home_data_model.dart';
import 'package:apricart/services/api_service.dart';
import 'package:apricart/services/cart_service.dart';
import 'package:apricart/services/shopping_list_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.router.dart';

class ProductDetailViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final cartService = locator<CartService>();
  final shoppingListService = locator<ShoppingListService>();
  final navigator = locator<NavigationService>();

  Products? prodData;
  List<Products> recommendedProducts = <Products>[];

  int qty = 1;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  incrementQuantity() {
    if (qty < (prodData?.maxQty ?? 1000)) {
      qty++;
      notifyListeners();
    }
  }

  decrementQuantity() {
    if (qty > (prodData?.minQty ?? 1)) {
      qty--;
      notifyListeners();
    }
  }

  addQtyToCart() async {
    if (_isLoading == false) {
      isLoading = true;
      try {
        await cartService.addQtyToCart(prodData!, qty);
      } catch (e) {
        null;
      }
      isLoading = false;
    }
  }

  loadProductData(String sku) async {
    setBusy(true);
    try {
      prodData = await apiService.getProductDetail(sku);

      if (prodData != null) {
        if (cartService.getProductQuantityFromCart(prodData!) == 0) {
          qty = prodData?.minQty ?? 1;
        } else {
          qty = cartService.getProductQuantityFromCart(prodData!);
        }
      }
      await getRecommendedProducts();
    } catch (e) {
      null;
    }
    setBusy(false);
  }

  //Recommended list controls
  getRecommendedProducts() async {
    try {
      recommendedProducts = await apiService.getRecommendedProducts();
    } catch (e) {
      null;
    }
  }

  addToCart(Products product) async {
    if (_isLoading == false) {
      isLoading = true;
      try {
        await cartService.addToCart(product);
        if (prodData != null) {
          if (cartService.getProductQuantityFromCart(prodData!) == 0) {
            null;
          } else {
            qty = cartService.getProductQuantityFromCart(prodData!);
          }
        }
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
        if (prodData != null) {
          if (cartService.getProductQuantityFromCart(prodData!) == 0) {
            null;
          } else {
            qty = cartService.getProductQuantityFromCart(prodData!);
          }
        }
      } catch (e) {
        null;
      }
      isLoading = false;
    }
  }

  openProduct(Products product) {
    navigator
        .navigateTo(Routes.productDetailView, arguments: ProductDetailViewArguments(sku: product.sku ?? ''))
        ?.then((value) {
      notifyListeners();
    });
  }

  //Shopping List Controls
  bool isFavorite(Products product) => shoppingListService.hasProduct(product);

  markFavorite(Products product) async {
    if (_isLoading == false) {
      isLoading = true;
      try {
        if (shoppingListService.hasProduct(product)) {
          await shoppingListService.deleteFromShoppingList(product);
        } else {
          await shoppingListService.addToShoppingList(product);
        }
      } catch (e) {
        null;
      }
      isLoading = false;
    }
  }
}

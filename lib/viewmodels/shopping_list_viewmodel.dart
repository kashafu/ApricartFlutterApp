import 'package:apricart/app/locator.dart';
import 'package:apricart/models/home_data_model.dart';
import 'package:apricart/services/cart_service.dart';
import 'package:apricart/services/shopping_list_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.router.dart';

class ShoppingListViewModel extends BaseViewModel {
  final shoppingListService = locator<ShoppingListService>();
  final cartService = locator<CartService>();
  final navigator = locator<NavigationService>();

  List<Products> get shoppingList => shoppingListService.shoppingList;

  bool isFavorite(Products product) => shoppingListService.hasProduct(product);

  //Cart Controls
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

  openProduct(Products product) {
    navigator
        .navigateTo(Routes.productDetailView, arguments: ProductDetailViewArguments(sku: product.sku ?? ''))
        ?.then((value) {
      notifyListeners();
    });
  }

  //ShoppingList COntrols

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

  loadShoppingList() async {
    setBusy(true);
    try {
      await shoppingListService.loadShoppingList();
    } catch (e) {
      null;
    }
    setBusy(false);
  }

  initiallizeViewModel() {
    loadShoppingList();
  }
}

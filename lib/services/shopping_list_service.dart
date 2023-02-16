import 'package:apricart/models/home_data_model.dart';
import 'package:injectable/injectable.dart';

import '../app/locator.dart';
import 'api_service.dart';

@lazySingleton
class ShoppingListService {
  final apiService = locator<ApiService>();

  List<Products> shoppingList = <Products>[];

  bool hasProduct(Products product) {
    for (Products prod in shoppingList) {
      if (prod.sku == product.sku) {
        return true;
      }
    }
    return false;
  }

  addToShoppingList(Products product) async {
    try {
      await apiService.addToShoppingList(product.sku ?? '');
      await loadShoppingList();
    } catch (e) {
      rethrow;
    }
  }

  deleteFromShoppingList(Products product) async {
    try {
      await apiService.deleteFromShoppingList(product.sku ?? '');
      await loadShoppingList();
    } catch (e) {
      rethrow;
    }
  }

  loadShoppingList() async {
    try {
      shoppingList = await apiService.getShoppingListData();
    } catch (e) {
      rethrow;
    }
  }
}

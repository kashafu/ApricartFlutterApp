import 'package:apricart/app/app.router.dart';
import 'package:apricart/models/home_data_model.dart';
import 'package:apricart/services/cart_service.dart';
import 'package:apricart/services/shopping_list_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/locator.dart';
import '../services/api_service.dart';
import '../widgets/bottom_sheets/sort_bottom_sheet.dart';

class CategoryViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final cartService = locator<CartService>();
  final shoppingListService = locator<ShoppingListService>();
  final navigator = locator<NavigationService>();

  List<String> carousalItems = <String>[
    "https://cbe.apricart.pk/options/stream/chatkhraydar1mainapp_2022-10-31T13_07_06.581210.png",
    "https://cbe.apricart.pk/options/stream/chatkhraydar1mainapp_2022-10-31T13_07_06.581210.png",
    "https://cbe.apricart.pk/options/stream/chatkhraydar1mainapp_2022-10-31T13_07_06.581210.png",
  ];

  List<Categories> categories = <Categories>[];

  CategoryViewType currentViewType = CategoryViewType.main;

  loadData() async {
    setBusy(true);
    try {
      categories = await apiService.getCategories();
    } catch (e) {
      null;
    }
    setBusy(false);
  }

  bool showlist = false;
  toggleProductView() {
    showlist = !showlist;
    notifyListeners();
  }

  bool filterOpen = false;
  toggleFilter(bool value) {
    filterOpen = value;
    notifyListeners();
  }

  bool? sortHightToLow;
  setSortHighToLow(bool value) {
    sortHightToLow = value;
    if (value == true) {
      productList.sort((a, b) => (b.currentPrice ?? 0).compareTo(a.currentPrice ?? 0));
    } else if (value == false) {
      productList.sort((a, b) => (a.currentPrice ?? 0).compareTo(b.currentPrice ?? 0));
    }
    notifyListeners();
  }

  showSortBottomSheet(BuildContext context) async {
    final res = await showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(maxHeight: 170),
      builder: (_) => SortBottomSheet(highToLowSelected: sortHightToLow),
    );
    print(res);
    if (res is bool) {
      setSortHighToLow(res as bool);
    }
  }

  int? selectedCategoryDetailId;
  int page = 1;
  bool finalPageReached = false;
  List<Products> productList = <Products>[];
  loadCategoryDetailProducts(Categories selectedCategoryDetail) async {
    currentViewType = CategoryViewType.products;
    page = 1;
    finalPageReached = false;
    selectedCategoryDetailId = selectedCategoryDetail.id;
    productList = <Products>[];
    setBusy(true);
    try {
      productList = await apiService.getCategoryProducts(selectedCategoryDetailId.toString(), page);
    } catch (e) {
      null;
    }
    setBusy(false);
  }

  incrementProductPage() async {
    if (finalPageReached == false && currentViewType == CategoryViewType.products) {
      page++;
      List<Products> newProducts = await apiService.getCategoryProducts(selectedCategoryDetailId.toString(), page);
      if (newProducts.isNotEmpty) {
        productList += newProducts;
      } else {
        finalPageReached = true;
      }
      notifyListeners();
    }
  }

  //Cart Controls
  List<Products> get cart => cartService.cart;

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

  //Search Controls

  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();

  bool searchEnabled = false;
  bool searchLoading = false;
  CancelToken? cancelToken;
  List<Products> searchProducts = <Products>[];

  enableSearch() {
    if (searchController.text.isEmpty) {
      searchEnabled = true;
      searchProducts = <Products>[];
      notifyListeners();
    }
  }

  disableSearch() {
    searchController.text = '';
    searchEnabled = false;
    isLoading = false;
    counter = 1;
    searchProducts = <Products>[];
    notifyListeners();
  }

  int counter = 1;

  search() async {
    counter++;
    int currentValue = counter;
    searchLoading = true;
    notifyListeners();
    try {
      cancelToken?.cancel();
      searchProducts = <Products>[];
      cancelToken = CancelToken();
      if (searchController.text.isNotEmpty) {
        searchProducts = await apiService.getSearchProducts(searchController.text, cancelToken!);
      }
    } catch (e) {
      null;
    }
    if (currentValue == counter) {
      searchLoading = false;
      notifyListeners();
    }
  }

  initializeViewModel() {
    loadData();
  }

  disposeViewModel() {
    searchController.dispose();
    searchFocus.dispose();
  }
}

enum CategoryViewType {
  main,
  products,
}

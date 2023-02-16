import 'dart:convert';
import 'dart:ffi';

import 'package:apricart/app/app.router.dart';
import 'package:apricart/app/locator.dart';
import 'package:apricart/models/category_products_model.dart';
import 'package:apricart/models/home_data_model.dart';
import 'package:apricart/services/api_service.dart';
import 'package:apricart/services/auth_service.dart';
import 'package:apricart/services/data_service.dart';
import 'package:apricart/services/misc_service.dart';
import 'package:apricart/services/shopping_list_service.dart';
import 'package:apricart/services/storage_service.dart';
import 'package:apricart/views/home/home_view.dart';
import 'package:apricart/views/login/login_view.dart';
import 'package:apricart/views/my_addresses/my_addresses_view.dart';
import 'package:apricart/widgets/bottom_sheets/sort_bottom_sheet.dart';
import 'package:apricart/widgets/dialogs/order_type_change_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../constants/assets.dart';
import '../models/pickup_data_model.dart';
import '../services/cart_service.dart';
import '../services/location_service.dart';
import '../shared/app_colors.dart';
import '../shared/app_text_styles.dart';
import '../shared/helpers.dart';

class HomeViewModel extends ReactiveViewModel {
  final apiService = locator<ApiService>();
  final cartService = locator<CartService>();
  final dataService = locator<DataService>();
  final storageService = locator<StorageService>();
  final locationService = locator<LocationService>();
  final shoppingListService = locator<ShoppingListService>();
  final miscService = locator<MiscService>();
  final authService = locator<AuthService>();
  final navigator = locator<NavigationService>();

  HomeViewModel(this.mainContext);
  BuildContext mainContext;

  List<String> carousalItems = <String>[];
  List<String> carousalItemIds = <String>[];

  List<String> topDeals = [
    Assets.deal1,
    Assets.deal2,
    Assets.deal1,
    Assets.deal2,
  ];

  HomeViewType currentViewType = HomeViewType.main;

  String? get currentCity => locationService.currentCity;

  String get homeDataType => dataService.homeDataType;
  HomeData? data;

  bool _dataLoading = false;
  bool get dataLoading => _dataLoading;
  set dataLoading(bool value) {
    _dataLoading = value;
    notifyListeners();
  }

  String get selectedDropdownValue {
    if (homeDataType == 'delivery') {
      return 'Online Delivery';
    } else {
      return 'Click & Collect Mart';
    }
  }

  selectOnlineDelivery() async {
    final res = await showDialog(
        context: StackedService.navigatorKey!.currentContext!, builder: (_) => const OrderTypeChangeDialog());
    if (res == true) {
      dataService.setHomeDataType('delivery');
      currentViewType = HomeViewType.main;
      await loadHomeData();
    }
  }

  selectClickAndCollect() async {
    final res = await showDialog(
        context: StackedService.navigatorKey!.currentContext!, builder: (_) => const OrderTypeChangeDialog());
    if (res == true) {
      dataService.setHomeDataType('pickup');
      currentViewType = HomeViewType.main;
      if (pickupData == null) {
        await loadPickupLocations();
      }
      await loadHomeData();
    }
  }

  loadHomeData() async {
    dataLoading = true;
    if (locationService.currentCity != null) {
      try {
        data = await apiService.getHomeData(homeDataType);

        if (data?.dialog == true && (await dataService.isUpdateAvailable() == false)) {
          // miscService.showHomeDialog('product', 'APRA-PCS47-03',
          //     'https://cbe.apricart.pk/options/stream/popupscreen_2022-11-08T15_44_35.382213.png');
          miscService.showHomeDialog(data?.dialogType ?? '', data?.dialogValue ?? '', data?.dialogImageUrl ?? '');
        }

        // Load Banenrs
        carousalItems = [];
        carousalItemIds = [];
        data?.banners?.forEach((banner) {
          if (banner.bannerUrlApp != null) {
            if (banner.bannerUrlApp?.isNotEmpty ?? false) {
              carousalItems.add(banner.bannerUrlApp![0]);
              carousalItemIds.add(banner.offerId.toString());
            }
          }
        });

        if (selectedPickupAddress == null && homeDataType == 'pickup') {
          await selectPickupAddress();
        }
      } catch (e) {
        print(e.toString());
      }
    }
    dataLoading = false;
  }

  //Pickup Address
  bool processing = false;

  PickupData? pickupData;

  PickLocationDtoList? get selectedPickupAddress {
    String? rawSavedPickup = storageService.instance.getString(StorageService.savedPickupAddressKey);
    if (rawSavedPickup != null) {
      return PickLocationDtoList.fromJson(jsonDecode(rawSavedPickup));
    }
    return null;
  }

  loadPickupLocations() async {
    try {
      pickupData = await apiService.getPickupData();
    } catch (e) {
      null;
    }
  }

  selectPickupAddress() async {
    if (processing == false) {
      processing = true;
      notifyListeners();
      if (pickupData == null) {
        try {
          pickupData = await apiService.getPickupData();
        } catch (e) {
          null;
        }
      }
      if (pickupData != null) {
        dynamic res;
        await SelectDialog.showModal<PickLocationDtoList>(
          mainContext,
          items: pickupData?.pickLocationDtoList,
          label: "Select Location",
          useRootNavigator: true,
          showSearchBox: false,
          constraints: BoxConstraints(
              maxHeight: (50 + ((pickupData?.pickLocationDtoList?.length ?? 0) * 40)) > 200
                  ? 200
                  : (50 + ((pickupData?.pickLocationDtoList?.length ?? 0) * 40))),
          itemBuilder: (context, item, isSelected) => Container(
            width: 180,
            height: 40,
            color: AppColors.grey1.withOpacity(0.15),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              item.name ?? 'unknown',
              style: AppTextStyles.regular16.copyWith(color: AppColors.black),
            ),
          ),
          emptyBuilder: (context) => Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          onChange: (item) {
            res = item;
          },
        );
        if (res is PickLocationDtoList) {
          await storageService.instance
              .setString(StorageService.savedPickupAddressKey, jsonEncode((res as PickLocationDtoList).toJson()));
        }

        if (selectedPickupAddress == null) {
          processing = false;
          notifyListeners();
          selectPickupAddress();
        }
      }
      processing = false;
      notifyListeners();
    }
  }

  selectDeliveryLocation() async {
    if (authService.userData == null) {
      await navigator.navigateTo(Routes.loginView);
      if (authService.userData == null) {
        null;
      } else {
        await Future.delayed(const Duration(milliseconds: 1));
        await navigator.navigateTo(Routes.myAddressesView);
        initializeViewModel();
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 1));
      await navigator.navigateTo(Routes.myAddressesView);
      initializeViewModel();
    }
  }

  showClickCartLocationDialog() async {}

  //Category Detail Controls
  int? selectedCategoryId;
  String? selectedCategoryName;
  String? selectedCategoryBanner;
  List<Categories> categoryDetailList = <Categories>[];

  loadCategoryDetail(Categories selectedCategory) async {
    if (!((selectedCategory.childrenCount ?? 0) > 0 && apiService.prodType == 'cus')) {
      loadMergeMainCategoryProducts(selectedCategory);
      return;
    }
    currentViewType = HomeViewType.category;
    selectedCategoryId = selectedCategory.id;
    // selectedCategoryName = selectedCategory.name;
    selectedCategoryName = '';
    dataLoading = true;
    try {
      final cats = await apiService.getCategories();
      List<Categories> newSelectedCategories = cats.where((element) => element.id == selectedCategory.id).toList();

      if (newSelectedCategories.isNotEmpty) {
        selectedCategoryName = newSelectedCategories[0].name;
        categoryDetailList = newSelectedCategories[0].childrenData ?? <Categories>[];
        selectedCategoryBanner = newSelectedCategories[0].bannerUrlApp ?? '';
      }
    } catch (e) {
      print(e.toString());
    }
    miscService.resetIds();
    dataLoading = false;
  }

  //Category Product Controls
  int? selectedCategoryDetailId;
  int page = 1;
  bool finalPageReached = false;
  List<Products> productList = <Products>[];
  List<Categories> mergeCategories = <Categories>[];
  Categories? selectedMergeCategory;
  Categories? selectedMainCategory;

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

  loadOfferProducts(String offerId) async {
    currentViewType = HomeViewType.categoryProducts;

    page = 1;
    finalPageReached = false;
    showlist = false;
    filterOpen = false;
    sortHightToLow = null;
    selectedCategoryDetailId = null;
    dataLoading = true;
    try {
      productList = await apiService.getOfferProducts(offerId);
    } catch (e) {
      null;
    }
    miscService.resetIds();
    dataLoading = false;
  }

  loadCategoryDetailProducts(Categories selectedCategoryDetail) async {
    currentViewType = HomeViewType.categoryProducts;

    page = 1;
    finalPageReached = false;
    showlist = false;
    filterOpen = false;
    sortHightToLow = null;
    selectedCategoryDetailId = selectedCategoryDetail.id;
    dataLoading = true;
    try {
      productList = await apiService.getCategoryProducts(selectedCategoryDetailId.toString(), page);
    } catch (e) {
      null;
    }
    miscService.resetIds();
    dataLoading = false;
  }

  incrementProductPage() async {
    if (finalPageReached == false && currentViewType == HomeViewType.categoryProducts) {
      page++;
      List<Products> newProducts = <Products>[];
      newProducts = await apiService.getCategoryProducts(selectedCategoryDetailId.toString(), page);
      if (newProducts.isNotEmpty) {
        productList += newProducts;
      } else {
        finalPageReached = true;
      }
      notifyListeners();
    }
  }

  loadMergeMainCategoryProducts(Categories mainCategory) async {
    currentViewType = HomeViewType.categoryProductsMerged;
    selectedMergeCategory = null;
    page = 1;
    finalPageReached = false;
    showlist = false;
    filterOpen = false;
    sortHightToLow = null;
    selectedMainCategory = mainCategory;
    dataLoading = true;
    try {
      MergeCategoryProducts mergeData =
          await apiService.getMergedCategoryProducts(selectedMainCategory?.id?.toString() ?? '', page);
      mergeCategories = mergeData.categories;
      productList = mergeData.products;
    } catch (e) {
      null;
    }
    miscService.resetIds();
    dataLoading = false;
  }

  loadMergeCategoryProducts(Categories mgCategory) async {
    currentViewType = HomeViewType.categoryProductsMerged;
    selectedMergeCategory = mgCategory;
    page = 1;
    finalPageReached = false;
    showlist = false;
    filterOpen = false;
    sortHightToLow = null;
    dataLoading = true;
    try {
      productList = await apiService.getCategoryProducts(selectedMergeCategory?.id?.toString() ?? '', page);
    } catch (e) {
      null;
    }
    miscService.resetIds();
    dataLoading = false;
  }

  incrementMergeProductPage() async {
    if (finalPageReached == false && currentViewType == HomeViewType.categoryProductsMerged) {
      page++;
      List<Products> newProducts = <Products>[];
      newProducts = await apiService.getCategoryProducts(
          selectedMergeCategory?.id?.toString() ?? selectedMainCategory?.id?.toString() ?? '', page);
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

  String get catId => miscService.catId;
  String get subCatId => miscService.subCatId;

  initializeViewModel() async {
    currentViewType = HomeViewType.main;
    await loadHomeData();
    if (catId.isNotEmpty) {
      loadCategoryDetail(Categories(id: int.parse(catId)));
    } else if (subCatId.isNotEmpty) {
      loadCategoryDetailProducts(Categories(id: int.parse(subCatId)));
    }
  }

  disposeViewModel() {
    searchController.dispose();
    searchFocus.dispose();
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [miscService];
}

enum HomeViewType {
  main,
  category,
  categoryProducts,
  categoryProductsMerged,
}

import 'dart:convert';

import 'package:apricart/app/api_client.dart';
import 'package:apricart/app/exceptions.dart';
import 'package:apricart/app/locator.dart';
import 'package:apricart/models/address_area_model.dart';
import 'package:apricart/models/address_city_model.dart';
import 'package:apricart/models/address_model.dart';
import 'package:apricart/models/app_option_model.dart';
import 'package:apricart/models/category_products_model.dart';
import 'package:apricart/models/checkout_modal.dart';
import 'package:apricart/models/home_data_model.dart';
import 'package:apricart/models/order_history_model.dart';
import 'package:apricart/models/payment_method_model.dart';
import 'package:apricart/models/pickup_data_model.dart';
import 'package:apricart/models/user_data_model.dart';
import 'package:apricart/services/auth_service.dart';
import 'package:apricart/services/cart_service.dart';
import 'package:apricart/services/data_service.dart';
import 'package:apricart/services/location_service.dart';
import 'package:apricart/services/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiService {
  CartService get cartService => locator<CartService>();
  String get token => locator<AuthService>().userData?.token ?? "";
  String get uid => locator<AuthService>().uid;
  LocationService get locationService => locator<LocationService>();
  String? get city => locationService.currentCity;
  double? get lat => locationService.latitude;
  double? get long => locationService.longitude;
  DataService get dataService => locator<DataService>();
  StorageService get storageService => locator<StorageService>();
  String get prodType {
    if (dataService.homeDataType == 'delivery') {
      return 'b2b';
    } else {
      return 'cus';
    }
  }

  PickLocationDtoList? get selectedPickupAddress {
    String? rawSavedPickup = storageService.instance.getString(StorageService.savedPickupAddressKey);
    if (rawSavedPickup != null) {
      return PickLocationDtoList.fromJson(jsonDecode(rawSavedPickup));
    }
    return null;
  }

  int get savedAddressId {
    String? rawAddress = storageService.instance.getString(StorageService.savedAddressKey);

    if (rawAddress == null) {
      return 0;
    } else {
      return Address.fromJson(jsonDecode(rawAddress)).id ?? 0;
    }
  }

  //Authentication
  Future<UserData> login(String phone, String password) async {
    try {
      final response = await ApiClient.post(
        '/auth/open/login?city=$city&lang=en',
        data: {
          "guestuserid": uid,
          "username": phone,
          "password": password,
        },
      );
      return UserData.fromJson(response["data"]);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(String name, String email, String phone, String password) async {
    try {
      await ApiClient.post(
        '/auth/open/register?city=$city&lang=en',
        data: {"name": name, "email": email, "phoneNumber": phone, "password": password, "guestuserid": uid},
      );
    } catch (e) {
      if (e is NetworkException) {}
      rethrow;
    }
  }

  Future<void> sendOtp(String phone) async {
    try {
      await ApiClient.post(
        '/auth/open/otp',
        data: {
          "phoneNumber": phone,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserData> verifyOtp(String phone, String otp) async {
    try {
      final response = await ApiClient.post(
        '/auth/open/otp/verify',
        data: {
          "phoneNumber": phone,
          "otp": otp,
        },
      );
      return UserData.fromJson(response["data"]);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserData> forgotPassword(String phone, String password, String otp) async {
    try {
      final response = await ApiClient.post(
        '/auth/open/password/forgot',
        data: {
          "phoneNumber": phone,
          "password": password,
          "otp": otp,
        },
      );
      return UserData.fromJson(response["data"]);
    } catch (e) {
      rethrow;
    }
  }

  //Data

  Future<List<AppOption>> getOptions() async {
    try {
      final response = await ApiClient.get(
        '/options/all',
      );
      return (response["data"] as List).map((e) => AppOption.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AddressCity>> getAddressCities() async {
    try {
      final response = await ApiClient.get(
        '/home/address/cities?lang=en',
      );
      return (response["data"] as List).map((e) => AddressCity.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AddressArea>> getAddressAreas(int? cityId) async {
    try {
      final response = await ApiClient.get(
        '/home/address/areas?cityid=$cityId&lang=en',
      );
      return (response["data"] as List).map((e) => AddressArea.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<HomeData> getHomeData(String orderType) async {
    try {
      final response = await ApiClient.get(
        '/home/all?client_lat=${locationService.latitude}&client_long=${locationService.longitude}&city=$city&lang=en&userid=$uid&web=false&hide=false&maker=${dataService.platform}&model=${dataService.deviceName}&prod_type=$prodType&order_type=$orderType&client_type=apricart',
        headers: token.isNotEmpty
            ? {
                "Authorization": "Bearer $token",
              }
            : null,
      );
      return HomeData.fromJson(response["data"]);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Categories>> getCategoriesDetail(String id) async {
    try {
      final response = await ApiClient.get(
        '/catalog/categories/detail?id=$id&userid=$uid',
        headers: token.isNotEmpty
            ? {
                "Authorization": "Bearer $token",
              }
            : null,
      );
      return (response["data"] as List).map((e) => Categories.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Products>> getCategoryProducts(String id, int page) async {
    try {
      final response = await ApiClient.get(
        '/catalog/categories/products?category=$id&page=$page&size=40&sortType=&sortDirection=desc&instant=3&city=$city&lang=en&userid=$uid&client_type=apricart',
        headers: token.isNotEmpty
            ? {
                "Authorization": "Bearer $token",
              }
            : null,
      );
      return (response["data"]["products"] as List).map((e) => Products.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Products>> getOfferProducts(String id) async {
    try {
      final response = await ApiClient.get(
        '/offers/detail?id=$id&city=$city&userid=$uid&client_type=apricart&prod_type=$prodType&order_type=${dataService.homeDataType}&lang=en',
        headers: token.isNotEmpty
            ? {
                "Authorization": "Bearer $token",
              }
            : null,
      );
      return (response["data"]["products"] as List).map((e) => Products.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<MergeCategoryProducts> getMergedCategoryProducts(String id, int page) async {
    try {
      final response = await ApiClient.get(
        '/catalog/categories/products?category=$id&page=$page&size=40&sortType=&sortDirection=desc&instant=3&city=$city&lang=en&userid=$uid&client_type=apricart',
        headers: token.isNotEmpty
            ? {
                "Authorization": "Bearer $token",
              }
            : null,
      );
      return MergeCategoryProducts.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Products>> getSearchProducts(String term, CancelToken cancelToken) async {
    try {
      final response = await ApiClient.get(
        '/catalog/products/search?page=1&size=100&term=$term&category=&city=$city&lang=en&userid=$uid&client_type=apricart',
        headers: token.isNotEmpty
            ? {
                "Authorization": "Bearer $token",
              }
            : null,
        cancelToken: cancelToken,
      );
      return (response["data"]["products"] as List).map((e) => Products.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Categories>> getCategories() async {
    try {
      final response = await ApiClient.get(
        '/catalog/categories?level=all&userid=$uid',
        headers: token.isNotEmpty
            ? {
                "Authorization": "Bearer $token",
              }
            : null,
      );
      return (response["data"] as List).map((e) => Categories.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProfile(String name, String email) async {
    try {
      await ApiClient.post(
        '/home/profile/save',
        data: {
          "name": name,
          "email": email,
          "image": "http://image.jpg",
          "address": "karachi",
        },
        headers: {
          "Authorization": "Bearer $token",
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendContactUsRequest(String name, String email, String phone, String text) async {
    try {
      await ApiClient.post(
        '/home/contactus/save',
        data: {
          "name": name,
          "phoneNumber": phone,
          "email": email,
          "file": "http://file.pdf",
          "text": text,
        },
        headers: token.isNotEmpty
            ? {
                "Authorization": "Bearer $token",
              }
            : null,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Cart
  Future<CheckoutModal> getCheckoutData(String? promo) async {
    try {
      final response = await ApiClient.post(
        '/order/cart/checkout?city=$city&lang=en&userid=$uid&client_lat=${locationService.latitude}&client_long=${locationService.longitude}',
        data: {
          "coupon": promo ?? '',
          "address": dataService.homeDataType == 'pickup' ? (selectedPickupAddress?.id ?? 3) : (savedAddressId),
          "clientType": "apricart",
          "orderType": dataService.homeDataType,
          "prodType": prodType,
          "day": "2022-04-10",
          "startTime": "11:00",
          "endTime": "11:30",
          "notes": "test order",
          "showProducts": true,
          "verify": true,
          "paymentMethod": "cash"
        },
        headers: token.isNotEmpty
            ? {
                "Authorization": "Bearer $token",
              }
            : null,
      );
      return CheckoutModal.fromJson(response["data"]);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addCartGuest(String sku, int qty) async {
    try {
      await ApiClient.post(
        '/guest/cart/save?city=$city&lang=en&client_type=apricart',
        data: {
          "userId": uid,
          "cart": [
            {
              "sku": sku,
              "qty": qty,
            },
          ],
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCartGuest(String sku) async {
    try {
      await ApiClient.delete(
        '/guest/cart/delete?city=$city&lang=en&client_type=apricart',
        data: {
          "userId": uid,
          "cart": [
            {
              "sku": sku,
            },
          ],
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addCart(String sku, int qty) async {
    try {
      await ApiClient.post(
        '/order/cart/save?city=$city&lang=en&client_type=apricart',
        data: {
          "cart": [
            {
              "sku": sku,
              "qty": qty,
            },
          ],
        },
        headers: {
          "Authorization": "Bearer $token",
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCart(String sku) async {
    try {
      await ApiClient.delete(
        '/order/cart/delete?city=$city&lang=en&client_type=apricart',
        data: {
          "cart": [
            {
              "sku": sku,
            },
          ],
        },
        headers: {
          "Authorization": "Bearer $token",
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  // Checkout
  Future<List<Address>> getAddresses() async {
    try {
      final response = await ApiClient.get(
        '/home/address/delivery?city=$city&lang=en',
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      return (response["data"] as List).map((e) => Address.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addDeliveryAddress(String name, String phone, String address, String googleAddress, int areaId) async {
    try {
      await ApiClient.post(
        '/home/address/delivery/save',
        data: {
          "name": name,
          "phoneNumber": phone,
          "email": "customerservice@apricart.pk",
          "mapLat": "24.881308",
          "mapLong": "67.06022",
          "address": address,
          "googleAddress": googleAddress,
          "areaId": areaId
        },
        headers: {
          "Authorization": "Bearer $token",
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDeliveryAddress(
      int id, String name, String phone, String address, String googleAddress, int areaId) async {
    try {
      await ApiClient.post(
        '/home/address/delivery/update',
        data: {
          "id": id,
          "name": name,
          "phoneNumber": phone,
          "email": "customerservice@apricart.pk",
          "mapLat": "24.881308",
          "mapLong": "67.06022",
          "address": address,
          "googleAddress": googleAddress,
          "areaId": areaId
        },
        headers: {
          "Authorization": "Bearer $token",
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAddress(int? id) async {
    try {
      await ApiClient.delete(
        '/home/address/delivery/delete',
        data: {
          "id": id,
        },
        headers: {
          "Authorization": "Bearer $token",
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PaymentMethod>> getPaymentMethods() async {
    try {
      final response = await ApiClient.get(
        '/order/payment/info?city=$city&lang=en',
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      return (response["data"] as List).map((e) => PaymentMethod.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<CheckoutModal> checkout(
      int addressId, String notes, String paymentMethod, String? day, String? startTime, String? endTime) async {
    try {
      print(cartService.promoCode);
      final response = await ApiClient.post(
        '/order/cart/checkout?city=$city&lang=en&userid=$uid&client_lat=${locationService.latitude}&client_long=${locationService.longitude}',
        data: {
          "coupon": cartService.promoCode ?? '',
          "address": addressId,
          "clientType": "apricart",
          "orderType": dataService.homeDataType,
          "prodType": prodType,
          "day": day,
          "startTime": startTime,
          "endTime": endTime,
          "notes": notes,
          "showProducts": true,
          "verify": false,
          "paymentMethod": paymentMethod,
        },
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      cartService.promoCode = null;
      CheckoutModal model = CheckoutModal.fromJson(response['data']);
      model.message = response['message'];
      return model;
    } catch (e) {
      rethrow;
    }
  }

  Future<OrderHistory> getOrderHistory() async {
    try {
      final response = await ApiClient.get(
        '/order/history?city=$city&lang=en',
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      return OrderHistory.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<OrderHistoryItem> getOrderHistoryDetailItem(String id) async {
    try {
      final response = await ApiClient.get(
        '/order/history/detail?id=$id&city=$city&lang=en',
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      return OrderHistoryItem.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<PickupData> getPickupData() async {
    try {
      final response = await ApiClient.get(
        '/order/address/pickup?city=$city&lang=en',
        // headers: {
        //   "Authorization": "Bearer $token",
        // },
      );
      return PickupData.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<Products> getProductDetail(String sku) async {
    try {
      final response = await ApiClient.get(
        '/catalog/products/detail?id=$sku&city=$city&lang=en&userid=$uid&prod_type=$prodType&order_type=${dataService.homeDataType}&client_type=apricart',
        headers: token.isNotEmpty
            ? {
                "Authorization": "Bearer $token",
              }
            : null,
      );
      return Products.fromJson(response['data'][0]);
    } catch (e) {
      rethrow;
    }
  }

  // Shopping List

  Future<void> addToShoppingList(String sku) async {
    try {
      await ApiClient.post(
        token.isNotEmpty ? '/watchlist/save?city=$city&lang=en' : '/guest/watchlist/save?city=$city&lang=en',
        data: token.isNotEmpty
            ? {
                "sku": [sku]
              }
            : {
                "userid": uid,
                "sku": [sku]
              },
        headers: token.isNotEmpty
            ? {
                "Authorization": "Bearer $token",
              }
            : null,
      );
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFromShoppingList(String sku) async {
    try {
      await ApiClient.delete(
        token.isNotEmpty ? '/watchlist/delete?city=$city&lang=en' : '/guest/watchlist/delete?city=$city&lang=en',
        data: token.isNotEmpty
            ? {
                "sku": [sku]
              }
            : {
                "userid": uid,
                "sku": [sku]
              },
        headers: token.isNotEmpty
            ? {
                "Authorization": "Bearer $token",
              }
            : null,
      );
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Products>> getShoppingListData() async {
    try {
      final response = await ApiClient.get(
        token.isNotEmpty
            ? '/watchlist/all?guestuserid=$uid&city=$city&lang=en'
            : '/guest/watchlist/all?userid=$uid&city=$city&lang=en',
        headers: token.isNotEmpty
            ? {
                "Authorization": "Bearer $token",
              }
            : null,
      );
      return (response["data"] as List).map((e) => Products.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Products>> getRecommendedProducts() async {
    try {
      final response = await ApiClient.get(
        '/catalog/recommended?page=1&size=10&city=$city&lang=en',
        headers: token.isNotEmpty
            ? {
                "Authorization": "Bearer $token",
              }
            : null,
      );
      return (response["data"]["products"] as List).map((e) => Products.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cancelOrder(String id) async {
    try {
      await ApiClient.get(
        '/order/checkout/cancel?id=$id',
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      return;
    } catch (e) {
      rethrow;
    }
  }
}

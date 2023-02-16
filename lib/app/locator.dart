import 'package:apricart/services/api_service.dart';
import 'package:apricart/services/auth_service.dart';
import 'package:apricart/services/cart_service.dart';
import 'package:apricart/services/data_service.dart';
import 'package:apricart/services/location_service.dart';
import 'package:apricart/services/misc_service.dart';
import 'package:apricart/services/shopping_list_service.dart';
import 'package:apricart/services/storage_service.dart';
import 'package:apricart/viewmodels/splash_viewmodel.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = StackedLocator.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => DataService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => CartService());
  locator.registerLazySingleton(() => ShoppingListService());
  locator.registerLazySingleton(() => MiscService());

  //ViewModels
  locator.registerLazySingleton(() => SplashViewModel());
}

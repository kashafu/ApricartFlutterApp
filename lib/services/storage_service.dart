import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class StorageService {
  late SharedPreferences instance;

  initializeStorageInstance() async {
    instance = await SharedPreferences.getInstance();
  }

  //Keys
  static const String uidKey = 'UID_KEY';
  static const String savedAddressKey = 'ADDRESS_KEY';
  static const String savedPickupAddressKey = 'PICKUP_ADDRESS_KEY';
  static const String userDataKey = 'USER_DATA_KEY';
  static const String orderTypeKey = 'ORDER_TYPE_KEY';
}

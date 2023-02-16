import 'package:apricart/app/app.router.dart';
import 'package:apricart/app/locator.dart';
import 'package:apricart/models/notification_payload_model.dart';
import 'package:apricart/shared/app_colors.dart';
import 'package:apricart/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class MiscService with ReactiveServiceMixin {
  final navigator = locator<NavigationService>();

  showHomeDialog(String type, String value, String imageUrl) async {
    Image _image = Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
    _image.image.resolve(ImageConfiguration()).addListener(ImageStreamListener((ImageInfo info, bool syncCall) {
      try {
        showDialog(
          context: StackedService.navigatorKey!.currentContext!,
          builder: (context) => Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                GestureDetector(
                  onTap: () {
                    navigator.back();
                    handleNotificationPayload(NotificationPayload(type: type, data: value));
                  },
                  child: Container(
                    width: screenWidth(context, multiplier: 0.75),
                    height: screenHeight(context, multiplier: 0.75),
                    margin: const EdgeInsets.all(10),
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(image: info.image, fit: BoxFit.cover),
                    // ),
                    child: _image,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 28,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } catch (e) {
        null;
      }
    }));
  }

  int _itemsInCart = 0;
  int get itemsInCart => _itemsInCart;
  setItemsInCart(int count) {
    _itemsInCart = count;
    notifyListeners();
  }

  int _navIndex = 0;
  int get navIndex => _navIndex;

  List<Key> navViewKeys = [Key('home'), Key('cat'), Key('cart'), Key('sl'), Key('more')];

  setNavIndex({required int index}) {
    if (navIndex == index) {
      navViewKeys[index] = Key(DateTime.now().microsecondsSinceEpoch.toString());
    }
    _navIndex = index;

    notifyListeners();
  }

  String _catId = '';
  String get catId => _catId;

  String _subCatId = '';
  String get subCatId => _subCatId;

  bool _disengageHomeView = false;
  bool get disengageHomeView => _disengageHomeView;

  resetIds() {
    _catId = '';
    _subCatId = '';
  }

  NotificationPayload? initialPayload;

  handleNotificationPayload(NotificationPayload payload) async {
    // Category, SubCategory
    if (payload.type == 'category') {
      if (navigator.currentRoute != Routes.navWrapperView) {
        navigator.popUntil(ModalRoute.withName(Routes.navWrapperView));
      }
      setNavIndex(index: 0);
      _disengageHomeView = true;
      _catId = payload.data;
      notifyListeners();
      await Future.delayed(const Duration(microseconds: 10000));
      _disengageHomeView = false;
      notifyListeners();
    } else if (payload.type == 'subcategory') {
      if (navigator.currentRoute != Routes.navWrapperView) {
        navigator.popUntil(ModalRoute.withName(Routes.navWrapperView));
      }
      setNavIndex(index: 0);
      _disengageHomeView = true;
      _subCatId = payload.data;
      notifyListeners();
      await Future.delayed(const Duration(microseconds: 10000));
      _disengageHomeView = false;
      notifyListeners();
    } else if (payload.type == 'product') {
      await Future.delayed(const Duration(milliseconds: 1));
      navigator.navigateTo(Routes.productDetailView, arguments: ProductDetailViewArguments(sku: payload.data));
    }
  }

  //Splash view notification control

  bool viewActive = true;
  setViewActive(bool value) {
    viewActive = value;
    notifyListeners();
  }
}

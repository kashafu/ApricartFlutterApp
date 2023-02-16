import 'dart:io';

import 'package:apricart/app/locator.dart';
import 'package:apricart/services/data_service.dart';
import 'package:apricart/services/misc_service.dart';
import 'package:apricart/widgets/dialogs/version_update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class NavWrapperViewModel extends ReactiveViewModel {
  final miscService = locator<MiscService>();
  final dataService = locator<DataService>();

  List<Key> get navViewKeys => miscService.navViewKeys;
  int get navIndex => miscService.navIndex;
  int get itemsInCart => miscService.itemsInCart;

  String get catId => miscService.catId;
  String get subCatId => miscService.subCatId;
  bool get disengageHomeView => miscService.disengageHomeView;

  setNavIndex(int index) {
    miscService.setNavIndex(index: index);
  }

  initializeViewModel() async {
    if (miscService.initialPayload != null) {
      miscService.handleNotificationPayload(miscService.initialPayload!);
    }
    miscService.initialPayload = null;

    await Future.delayed(const Duration(seconds: 1));
    if (await dataService.isUpdateAvailable()) {
      try {
        showDialog(
          context: StackedService.navigatorKey!.currentContext!,
          builder: (_) => VersionUpdateDialog(
            message: dataService.updateMessage,
            onUpdatePress: () {
              if (Platform.isAndroid) {
                launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.assorttech.airoso_app'),
                    mode: LaunchMode.externalApplication);
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                launchUrl(Uri.parse('https://apps.apple.com/pk/app/apricart/id1562353936'),
                    mode: LaunchMode.externalApplication);
              }
            },
          ),
        );
      } catch (e) {
        null;
      }
    }
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [miscService];
}

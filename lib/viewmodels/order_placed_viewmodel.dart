import 'package:apricart/app/locator.dart';
import 'package:apricart/models/app_option_model.dart';
import 'package:apricart/services/cart_service.dart';
import 'package:apricart/services/data_service.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:stacked/stacked.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class OrderPlacedViewModel extends BaseViewModel {
  final cartService = locator<CartService>();
  final dataService = locator<DataService>();

  openLocation(String? lat, String? long) async {
    if (lat != null && long != null) {
      try {
        final availableMaps = await MapLauncher.installedMaps;

        await availableMaps.first.showMarker(
          coords: Coords(double.parse(lat), double.parse(long)),
          title: "Pickup Location",
        );
      } catch (e) {}
      // await MapLauncher.showMarker(
      //     mapType: MapType.google, coords: Coords(double.parse(lat), double.parse(long)), title: 'Pickup Location');
    }
  }

  String? get videoId => dataService.options
      .firstWhere(
        (element) => element.key == "welcome_video",
        orElse: () => AppOption(),
      )
      .value;
  YoutubePlayerController? videoController;

  initializeViewModel(FlutterGifController? controller) async {
    controller?.repeat(min: 0, max: 80, period: const Duration(seconds: 4));
    cartService.promoCode = null;
    if (videoId == null) {
      try {
        await dataService.loadOptions();
        notifyListeners();
      } catch (e) {
        null;
      }
    }

    if (videoId != null) {
      videoController = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
          disableDragSeek: true,
        ),
      );
    }
  }
}

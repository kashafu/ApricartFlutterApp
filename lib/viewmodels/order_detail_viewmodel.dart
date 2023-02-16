import 'package:apricart/app/locator.dart';
import 'package:apricart/models/order_history_model.dart';
import 'package:apricart/services/api_service.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OrderDetailViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final navigator = locator<NavigationService>();

  OrderHistoryItem? item;

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

  initializeViewModel(String id) async {
    setBusy(true);
    try {
      item = await apiService.getOrderHistoryDetailItem(id);
    } catch (e) {
      null;
    }
    setBusy(false);
  }
}

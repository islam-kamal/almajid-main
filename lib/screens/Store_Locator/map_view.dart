import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

class MapViewModel {
  MapViewModel._();

  static Future<void> openMap({double? latitude, double? longitude}) async {
    String googleMapUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude%2C$longitude';
    try {
      await launch(googleMapUrl);
    } catch (e) {
      log("ErrorMap:$e");
    }
  }
}

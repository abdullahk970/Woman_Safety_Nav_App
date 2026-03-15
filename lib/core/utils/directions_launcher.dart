import 'package:url_launcher/url_launcher.dart';

class DirectionsLauncher {
  static Future<void> openDirections({
    required double destinationLat,
    required double destinationLng,
  }) async {
    final uri = Uri.parse(
      "https://www.google.com/maps/dir/?api=1"
          "&destination=$destinationLat,$destinationLng"
          "&travelmode=walking",
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch Google Maps";
    }
  }
}

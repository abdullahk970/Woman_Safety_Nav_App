import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationProvider extends ChangeNotifier {
  double? _latitude;
  double? _longitude;
  bool _isLoading = false;
  bool _permissionGranted = false;

  double? get latitude => _latitude;
  double? get longitude => _longitude;
  bool get isLoading => _isLoading;
  bool get permissionGranted => _permissionGranted;

  /// Initialize location and request permission
  Future<void> initializeLocation() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Request location permission
      final status = await Permission.location.status;

      if (status.isGranted) {
        _permissionGranted = true;
      } else if (status.isDenied) {
        _permissionGranted = await Permission.location.request().isGranted;
      } else if (status.isPermanentlyDenied) {
        _permissionGranted = false;
        // Optionally open app settings
        // await openAppSettings();
      }

      // Fetch current location if permission granted
      if (_permissionGranted) {
        final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        _latitude = position.latitude;
        _longitude = position.longitude;
      }
    } catch (e) {
      _permissionGranted = false;
      _latitude = null;
      _longitude = null;
      debugPrint("LocationProvider error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

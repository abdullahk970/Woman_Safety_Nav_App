import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../core/utils/json_loader.dart';
import '../models/safe_place_model.dart';
import 'location_provider.dart';

// ✅ NEW IMPORT
import '../core/utils/directions_launcher.dart';

class SafePlacesProvider extends ChangeNotifier {
  List<SafePlaceModel> _places = [];
  bool _isLoading = false;

  // ✅ NEW: selected filter
  String _selectedType = "All";

  // GETTERS
  bool get isLoading => _isLoading;
  String get selectedType => _selectedType;

  /// FILTERED LIST (used by UI & Map)
  List<SafePlaceModel> get filteredPlaces {
    if (_selectedType == "All") return _places;
    return _places.where((place) => place.type == _selectedType).toList();
  }

  // SET FILTER
  void setFilter(String type) {
    _selectedType = type;
    notifyListeners();
  }

  // LOAD SAFE PLACES
  Future<void> loadSafePlaces(LocationProvider locationProvider) async {
    _isLoading = true;
    notifyListeners();

    final data = await JsonLoader.loadList('assets/json/safe_places.json');
    _places = data.map((e) => SafePlaceModel.fromJson(e)).toList();

    _calculateDistances(locationProvider);

    _isLoading = false;
    notifyListeners();
  }

  // CALCULATE LIVE DISTANCES
  void _calculateDistances(LocationProvider locationProvider) {
    if (locationProvider.latitude == null ||
        locationProvider.longitude == null) return;

    for (var place in _places) {
      final distanceInMeters = Geolocator.distanceBetween(
        locationProvider.latitude!,
        locationProvider.longitude!,
        place.latitude,
        place.longitude,
      );

      // Distance in km
      place.liveDistance =
          double.parse((distanceInMeters / 1000).toStringAsFixed(2));
    }

    // Sort nearest first
    _places.sort((a, b) =>
        (a.liveDistance ?? 0).compareTo(b.liveDistance ?? 0));
  }

  /// Refresh distances when location changes
  void refreshDistances(LocationProvider locationProvider) {
    _calculateDistances(locationProvider);
    notifyListeners();
  }

  // ✅ NEW METHOD (as requested)
  Future<void> navigateToNearestSafePlace() async {
    if (filteredPlaces.isEmpty) return;

    final nearest = filteredPlaces.first;

    await DirectionsLauncher.openDirections(
      destinationLat: nearest.latitude,
      destinationLng: nearest.longitude,
    );
  }
}

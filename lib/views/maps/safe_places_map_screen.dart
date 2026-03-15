import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../providers/safe_places_provider.dart';
import '../../providers/location_provider.dart';

// ✅ NEW IMPORT
import '../../core/utils/directions_launcher.dart';

class SafePlacesMapScreen extends StatefulWidget {
  const SafePlacesMapScreen({super.key});

  @override
  State<SafePlacesMapScreen> createState() => _SafePlacesMapScreenState();
}

class _SafePlacesMapScreenState extends State<SafePlacesMapScreen> {
  final Set<Marker> _markers = {};
  bool _markersLoaded = false;

  void _loadMarkers(SafePlacesProvider safeProvider) {
    _markers.clear();

    // ✅ Use filteredPlaces so the filter is applied
    for (var place in safeProvider.filteredPlaces) {
      _markers.add(
        Marker(
          markerId: MarkerId(place.id.toString()),
          position: LatLng(place.latitude, place.longitude),
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.liveDistance != null
                ? "Distance: ${place.liveDistance} km"
                : place.address,
            onTap: () {
              DirectionsLauncher.openDirections(
                destinationLat: place.latitude,
                destinationLng: place.longitude,
              );
            },
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            place.type == "Police"
                ? BitmapDescriptor.hueBlue
                : place.type == "Hospital"
                ? BitmapDescriptor.hueRed
                : BitmapDescriptor.hueViolet,
          ),
        ),
      );
    }

    setState(() {
      _markersLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final safeProvider = context.watch<SafePlacesProvider>();
    final locationProvider = context.watch<LocationProvider>();

    final hasLocation =
        locationProvider.permissionGranted &&
        locationProvider.latitude != null &&
        locationProvider.longitude != null;

    return Scaffold(
      appBar: AppBar(title: const Text("Nearby Safe Places Map")),
      body: !hasLocation
          ? const Center(
              child: Text(
                "Location permission not granted. Enable location to view map.",
              ),
            )
          : safeProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  locationProvider.latitude!,
                  locationProvider.longitude!,
                ),
                zoom: 14,
              ),
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) {
                if (!_markersLoaded) {
                  _loadMarkers(safeProvider);
                }
              },
            ),
    );
  }
}

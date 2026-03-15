import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/safe_places_provider.dart';
import '../../providers/location_provider.dart';
import '../maps/safe_places_map_screen.dart';

class SafePlacesScreen extends StatefulWidget {
  const SafePlacesScreen({super.key});

  @override
  State<SafePlacesScreen> createState() => _SafePlacesScreenState();
}

class _SafePlacesScreenState extends State<SafePlacesScreen> {
  @override
  void initState() {
    super.initState();

    // Load safe places only after location is ready
    Future.microtask(() {
      final locationProvider = context.read<LocationProvider>();

      if (locationProvider.permissionGranted &&
          locationProvider.latitude != null &&
          locationProvider.longitude != null) {
        context.read<SafePlacesProvider>().loadSafePlaces(locationProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SafePlacesProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Nearby Safe Places"),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // ✅ Map button
          Padding(
            padding: const EdgeInsets.all(18),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.map, color: Colors.white),
              label: const Text(
                "View on Map",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SafePlacesMapScreen(),
                  ),
                );
              },
            ),
          ),

          // ✅ Filter chips row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _filterChip(provider, "All"),
                _filterChip(provider, "Police"),
                _filterChip(provider, "Hospital"),
                _filterChip(provider, "Help Center"),
              ],
            ),
          ),

          // ✅ NEW: Emergency Directions button (as requested)
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.directions),
            label: const Text("Emergency Directions",style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () async {
              await context
                  .read<SafePlacesProvider>()
                  .navigateToNearestSafePlace();
            },
          ),
          const SizedBox(height: 16),

          // ✅ List of filtered places
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: provider.filteredPlaces.length,
              itemBuilder: (context, index) {
                final place = provider.filteredPlaces[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: place.color.withOpacity(0.15),
                        child: Icon(
                          place.icon,
                          color: place.color,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              place.address,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textLight,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              place.liveDistance != null
                                  ? "Distance: ${place.liveDistance!.toStringAsFixed(2)} km"
                                  : "Calculating distance...",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Helper method for filter chips
  Widget _filterChip(SafePlacesProvider provider, String type) {
    final isSelected = provider.selectedType == type;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(type),
        selected: isSelected,
        onSelected: (_) => provider.setFilter(type),
        selectedColor: Theme.of(context).primaryColor,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

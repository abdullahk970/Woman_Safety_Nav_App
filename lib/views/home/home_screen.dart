import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../providers/home_provider.dart';
import '../../providers/location_provider.dart';
import '../../widgets/safety_card.dart';
import '../emergency/emergency_screen.dart';
import '../navigation/navigation_screen.dart';
import '../profile/profile_screen.dart';
import '../safe_places/safe_places_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Load dashboard features after widget build
    Future.microtask(
          () => context.read<HomeProvider>().loadFeatures(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final location = context.watch<LocationProvider>(); // 👈 UX indicator provider

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Safety Dashboard"),
        centerTitle: true,
      ),
      body: homeProvider.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔴🟢 Location Status Indicator
            Row(
              children: [
                Icon(
                  location.permissionGranted
                      ? Icons.location_on
                      : Icons.location_off,
                  size: 16,
                  color: location.permissionGranted
                      ? Colors.green
                      : Colors.red,
                ),
                const SizedBox(width: 6),
                location.permissionGranted
                    ? const Text(
                  "Location Active",
                  style: TextStyle(color: Colors.green),
                )
                    : const Text(
                  "Location not enabled",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Dashboard Grid
            Expanded(
              child: GridView.builder(
                itemCount: homeProvider.features.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {
                  final feature = homeProvider.features[index];

                  return SafetyCard(
                    icon: feature.icon,
                    title: feature.title,
                    subtitle: feature.subtitle,
                    color: feature.color,
                    onTap: () {
                      if (feature.title == "Safe Navigation") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const NavigationScreen(),
                          ),
                        );
                      }
                      if (feature.title == "Emergency SOS") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const EmergencyScreen(),
                          ),
                        );
                      }
                      if (feature.title == "Profile") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const ProfileScreen(),
                          ),
                        );
                      }
                      if (feature.title == "Nearby Safe Places") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const SafePlacesScreen(),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

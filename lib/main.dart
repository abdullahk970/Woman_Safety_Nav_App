import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woman_safety_navigation/providers/app_provider.dart';
import 'package:woman_safety_navigation/providers/emergency_provider.dart';
import 'package:woman_safety_navigation/providers/home_provider.dart';
import 'package:woman_safety_navigation/providers/location_provider.dart';
import 'package:woman_safety_navigation/providers/navigation_provider.dart';
import 'package:woman_safety_navigation/providers/profile_provider.dart';
import 'package:woman_safety_navigation/providers/safe_places_provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'views/splash/splash_screen.dart';

void main() {
  runApp(const WomenSafetyApp());
}

class WomenSafetyApp extends StatelessWidget {
  const WomenSafetyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => EmergencyProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => SafePlacesProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),





      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Women Safety Navigation',
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}

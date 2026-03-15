import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../home/home_screen.dart';
import '../navigation/navigation_screen.dart';
import '../emergency/emergency_screen.dart';
import '../profile/profile_screen.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  static final List<Widget> _screens = [
    const HomeScreen(),
    const NavigationScreen(),
    const EmergencyScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();

    return Scaffold(
      body: _screens[appProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: appProvider.currentIndex,
        onTap: appProvider.changeTab,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigation),
            label: "Navigate",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: "SOS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

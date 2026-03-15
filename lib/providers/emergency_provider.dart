import 'package:flutter/material.dart';
import '../core/utils/json_loader.dart';
import '../models/emergency_contact_model.dart';

class EmergencyProvider extends ChangeNotifier {
  List<EmergencyContactModel> _contacts = [];
  bool _isLoading = false;

  List<EmergencyContactModel> get contacts => _contacts;
  bool get isLoading => _isLoading;

  Future<void> loadContacts() async {
    _isLoading = true;
    notifyListeners();

    final data =
    await JsonLoader.loadList('assets/json/emergency_contacts.json');

    _contacts = data
        .map((e) => EmergencyContactModel.fromJson(e))
        .toList();

    _isLoading = false;
    notifyListeners();
  }

  void triggerSOS(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "🚨 SOS Activated! Help is on the way.",
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../core/utils/json_loader.dart';
import '../models/profile_model.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? _profile;
  bool _isLoading = false;

  ProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;

  Future<void> loadProfile() async {
    _isLoading = true;
    notifyListeners();

    final data =
    await JsonLoader.loadObject('assets/json/profile.json');

    _profile = ProfileModel.fromJson(data);

    _isLoading = false;
    notifyListeners();
  }
}

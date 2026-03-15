import 'package:flutter/material.dart';
import '../core/utils/json_loader.dart';
import '../models/home_feature_model.dart';

class HomeProvider extends ChangeNotifier {
  List<HomeFeatureModel> _features = [];
  bool _isLoading = false;

  List<HomeFeatureModel> get features => _features;
  bool get isLoading => _isLoading;

  Future<void> loadFeatures() async {
    _isLoading = true;
    notifyListeners();

    final data =
    await JsonLoader.loadList('assets/json/home_features.json');

    _features =
        data.map((e) => HomeFeatureModel.fromJson(e)).toList();

    _isLoading = false;
    notifyListeners();
  }
}

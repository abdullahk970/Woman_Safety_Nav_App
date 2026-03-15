import 'package:flutter/material.dart';
import '../core/utils/json_loader.dart';
import '../models/navigation_route_model.dart';

class NavigationProvider extends ChangeNotifier {
  List<NavigationRouteModel> _routes = [];
  bool _isLoading = false;

  List<NavigationRouteModel> get routes => _routes;
  bool get isLoading => _isLoading;

  Future<void> loadRoutes() async {
    _isLoading = true;
    notifyListeners();

    final data = await JsonLoader.loadList('assets/json/routes.json');
    _routes =
        data.map((e) => NavigationRouteModel.fromJson(e)).toList();

    _isLoading = false;
    notifyListeners();
  }
}

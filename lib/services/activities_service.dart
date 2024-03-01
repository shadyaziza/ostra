import 'dart:developer';

import 'package:stacked/stacked.dart';

class ActivitiesService with ListenableServiceMixin {
  ActivitiesService() {
    listenToReactiveValues([_activities]);
  }

  final List<String> _activities = [];

  List<String> get activities => _activities;

  void add(String str) {
    activities.add(str);
    notifyListeners();
  }
}

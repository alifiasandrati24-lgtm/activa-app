
import 'package:flutter/material.dart';
import 'package:activa_app/models/activity_model.dart';
import 'package:activa_app/repositories/activity_repository.dart';

class ActivityViewModel extends ChangeNotifier {
  final ActivityRepository _repository = ActivityRepository();

  List<ActivityModel> get activities {
    return _repository.getAllActivities();
  }

  void addActivity(String name) {
    _repository.addActivity(name);
    notifyListeners();
  }

  void updateActivity(int id, String newName) {
    _repository.updateActivity(id, newName);
    notifyListeners();
  }

  void deleteActivity(int id) {
    _repository.deleteActivity(id);
    notifyListeners();
  }

  void incrementCounter(int id) {
    _repository.incrementCounter(id);
    notifyListeners();
  }

  void decrementCounter(int id) {
    _repository.decrementCounter(id);
    notifyListeners();
  }

  void resetCounter(int id) {
    _repository.resetCounter(id);
    notifyListeners();
  }
}

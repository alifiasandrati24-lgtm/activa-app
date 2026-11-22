
import '../data/activity_data.dart';
import '../models/activity_model.dart';

class ActivityRepository {
  List<ActivityModel> getAllActivities() {
    return ActivityData.activities;
  }

  void addActivity(String name) {
    ActivityData.activities.add(
      ActivityModel(
        id: ActivityData.nextId++,
        name: name,
      ),
    );
  }

  void updateActivity(int id, String newName) {
    final activity = ActivityData.activities.firstWhere(
      (item) => item.id == id,
    );
    activity.name = newName;
  }

  void deleteActivity(int id) {
    ActivityData.activities.removeWhere(
      (item) => item.id == id,
    );
  }

  void incrementCounter(int id) {
    final activity = ActivityData.activities.firstWhere(
      (item) => item.id == id,
    );
    activity.counter++;
  }

  void decrementCounter(int id) {
    final activity = ActivityData.activities.firstWhere(
      (item) => item.id == id,
    );
    if (activity.counter > 0) {
      activity.counter--;
    }
  }

  void resetCounter(int id) {
    final activity = ActivityData.activities.firstWhere(
      (item) => item.id == id,
    );
    activity.counter = 0;
  }
}

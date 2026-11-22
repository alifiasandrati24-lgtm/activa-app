
import '../models/activity_model.dart';

class ActivityData {
  static final List<ActivityModel> activities = [
    ActivityModel(id: 1, name: 'Olahraga'),
    ActivityModel(id: 2, name: 'Membaca Buku'),
    ActivityModel(id: 3, name: 'Belajar'),
  ];

  static int nextId = 4;
}

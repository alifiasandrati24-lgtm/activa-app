
class ActivityModel {
  final int id;
  String name;
  int counter;

  ActivityModel({
    required this.id,
    required this.name,
    this.counter = 0,
  });
}

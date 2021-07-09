class DoModel {
  final int id;
  String title;
  DateTime startDate;
  DateTime endDate;
  bool completed = false;

  DoModel({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
  });

  String get getTitle => title;
  DateTime get getStartDate => startDate;
  DateTime get getEndDate => endDate;
  bool get getCompleted => completed;

  set setTitle(String title) {
    this.title = title;
  }

  set setStartDate(DateTime startDate) {
    this.startDate = startDate;
  }

  set setEndDate(DateTime endDate) {
    this.endDate = endDate;
  }

  set setCompleted(bool completed) {
    this.completed = completed;
  }
}

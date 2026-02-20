class NoticeModel {
  final String title;
  final String description;
  final DateTime date;
  bool isNew; // calculated locally

  NoticeModel({
    required this.title,
    required this.description,
    required this.date,
    this.isNew = false,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']), // if API returns string
      isNew: false, // default, we will calculate in controller
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'isNew': isNew,
    };
  }

  void operator [](String other) {}
}

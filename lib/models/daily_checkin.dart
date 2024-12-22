class DailyCheckInModel {
  final String date;
  final List<String> answers;

  DailyCheckInModel({required this.date, required this.answers});

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      ...{for (int i = 1; i <= answers.length; i++) '$i': answers[i - 1]},
    };
  }

  factory DailyCheckInModel.fromMap(Map<String, dynamic> map) {
    final answers = <String>[];
    for (var key in map.keys) {
      if (key != 'date') {
        answers.add(map[key]);
      }
    }
    return DailyCheckInModel(date: map['date'], answers: answers);
  }
}

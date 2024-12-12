class Abgabe {
  final String tasksheetName;
  final DateTime? abgabe;

  Abgabe({required this.tasksheetName, required this.abgabe});

  factory Abgabe.fromMap(Map<String, dynamic> map) {
    final String tasksheet = map["tasksheet"];

    DateTime? abgabe;

    if (map["date"] != null) {
      abgabe = DateTime.parse(map["date"]);
    }

    return Abgabe(tasksheetName: tasksheet, abgabe: abgabe);
  }
}


// Abgabe abgabe = Abgabe()
// Abgabe abage = Abgabe.fromMap(map);
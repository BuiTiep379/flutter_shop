class NoteModel {
  final String id;
  final String title;
  final String body;
  final String date;

  NoteModel({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'date': date,
    };
  }

  NoteModel.fromMap(Map<String, dynamic> note)
      : id = note["id"],
        title = note["title"],
        body = note["body"],
        date = note["date"];
}

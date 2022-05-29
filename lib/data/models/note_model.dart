class NoteModel {
  final String id;
  final String title;
  final String note;
  final int colorindex;
  NoteModel({
    required this.id,
    required this.title,
    required this.note,
    required this.colorindex,
  });

  factory NoteModel.fromjson(Map<String, dynamic> json, String id) {
    return NoteModel(
      id: id,
      title: json['title'],
      note: json['note'],
      colorindex: json['colorindex'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'title': title,
      'note': note,
      'colorindex': colorindex,
    };
  }
}

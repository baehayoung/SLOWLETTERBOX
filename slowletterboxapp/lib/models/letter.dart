class Letter {
  int id;
  int date;
  String title;
  String contents;

  Letter(
      {required this.id,
      required this.date,
      required this.title,
      required this.contents});

  factory Letter.fromJson(Map<String, dynamic> json) {
    return Letter(
        id: json['id'],
        date: json['date'],
        title: json['title'],
        contents: json['contents']);
  }
}

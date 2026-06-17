class Notelymodel {
  int? id;
  String title;
  String preview;
  String date;
  String color;

  Notelymodel({this.id , required this.title, required this.preview, required this.date , required this.color});

  Map<String, dynamic> toJson() => {
    'title': title,
    'preview': preview,
    'date': date,
    'color': color
  };

  factory Notelymodel.fromJson(Map<String, dynamic> json) => Notelymodel(
    id: json['id'],
    title: json['title'],
    preview: json['preview'],
    date: json['date'], color: json['color'],
  );
}

class Notelymodel {
  String? id;
  String uid;
  String title;
  String preview;
  String date;
  String color;

  Notelymodel({
    this.id,
    required this.uid,
    required this.title,
    required this.preview,
    required this.date,
    required this.color,
  });

  Map<String, dynamic> toJson() => {
    "uid" : uid,
    'title': title,
    'preview': preview,
    'date': date,
    'color': color,
  };

  factory Notelymodel.fromJson(Map<String, dynamic> json) => Notelymodel(
    id: json['id'],
    uid : json['uid'],
    title: json['title'],
    preview: json['preview'],
    date: json['date'],
    color: json['color'], 
  );
}

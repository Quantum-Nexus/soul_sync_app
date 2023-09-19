class Confession {
  final int confessionid;
  final String confessiontxt;
  final String date;
  int upvotes;

  Confession({
    required this.confessionid,
    required this.confessiontxt,
    required this.date,
    this.upvotes =0,
  });
  factory Confession.fromJson(Map<String, dynamic> json) {
    return Confession(
      confessionid: json['confessionid'],
      confessiontxt: json['confessiontxt'],
      date: json['date'],
      upvotes: 0,
      // upvotes: json['upvotes'] , // Use 0 if 'upvotes' is missing or null in JSON,
    );
  }
}

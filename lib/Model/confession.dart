class Confession {
  final String confessiontxt;
  final String date;

  Confession({required this.confessiontxt, required this.date});

  factory Confession.fromJson(Map<String, dynamic> json) {

    
    return Confession(
      confessiontxt: json['message'],
      date: json['date'],
    );
  }
}




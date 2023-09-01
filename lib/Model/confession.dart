class Confession {
  final int confessionid;
  final String confessiontxt; 
  final String date;
  int upvotes;

  Confession(
    {
    required this.confessionid,
    required this.confessiontxt, 
    required this.date,
    this.upvotes = 0,
    }
  );

}




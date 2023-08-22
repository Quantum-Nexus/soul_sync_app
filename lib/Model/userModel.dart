class Candidate {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl; // Assuming "image" from the API response is the URL

  Candidate({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      imageUrl: json['image'],
    );
  }
}

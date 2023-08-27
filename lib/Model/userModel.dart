class Candidate {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? about;
  final String? gender;
  final int? gradYear;
  final String imageUrl;

  Candidate({
    required this.gradYear,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
    required this.about,
    required this.gender
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      gender: json['gender'],
      imageUrl: json['image'],
      gradYear: json['graduationYear'],
      about: json['about'],
    );
  }
}
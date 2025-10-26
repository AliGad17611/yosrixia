class DoctorModel {
  final String name;
  final String email;
  final String number;
  final String imageUrl;
  final String? birthDate;
  final String? organization;
  final String? experience;
  final String? specialization;
  final String? bio;

  DoctorModel({
    required this.name,
    required this.email,
    required this.number,
    required this.imageUrl,
    this.birthDate,
    this.organization,
    this.experience,
    this.specialization,
    this.bio,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      number: json['number'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      birthDate: json['birthDate'],
      organization: json['organization'],
      experience: json['experience'],
      specialization: json['specialization'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'number': number,
      'imageUrl': imageUrl,
      'birthDate': birthDate,
      'organization': organization,
      'experience': experience,
      'specialization': specialization,
      'bio': bio,
    };
  }
}

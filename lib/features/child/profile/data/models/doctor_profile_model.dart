class DoctorProfileModel {
  final String name;
  final String email;
  final String number;
  final String imageUrl;
  final String birthDate;
  final String organization;
  final String experience;
  DoctorProfileModel(
      {required this.name,
      required this.email,
      required this.number,
      required this.imageUrl,
      required this.birthDate,
      required this.organization,
      required this.experience});
  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    return DoctorProfileModel(
      name: json['name'],
      email: json['email'],
      number: json['number'],
      imageUrl: json['imageUrl'],
      birthDate: json['birthDate'],
      organization: json['organization'],
      experience: json['experience'],
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
    };
  }
}

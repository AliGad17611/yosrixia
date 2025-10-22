class ChildProfileModel {
  final String name;
  final String country;
  final String birthDate;
  final String gender;
  final String number;
  final String email;
  final String imageUrl;

  ChildProfileModel(
      {required this.imageUrl,
      required this.name,
      required this.country,
      required this.birthDate,
      required this.gender,
      required this.number,
      required this.email});
  factory ChildProfileModel.fromJson(Map<String, dynamic> json) {
    return ChildProfileModel(
      name: json['name'],
      imageUrl: json['imageUrl'],
      country: json['country'],
      birthDate: json['birthDate'],
      gender: json['gender'],
      number: json['number'],
      email: json['email'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'country': country,
      'birthDate': birthDate,
      'gender': gender,
      'number': number,
      'email': email,
    };
  }
}

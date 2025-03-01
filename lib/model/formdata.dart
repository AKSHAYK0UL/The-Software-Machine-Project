class FormData {
  final String race;
  final String gender;
  final String birthdate;
  final List<String> dietaryChoices;
  final String? allergies;

  FormData({
    required this.race,
    required this.gender,
    required this.birthdate,
    required this.dietaryChoices,
    required this.allergies,
  });

  factory FormData.fromJson(Map<String, dynamic> json) {
    return FormData(
      race: json["race"],
      gender: json["gender"],
      birthdate: json["birthdate"],
      dietaryChoices: List<String>.from(json["dietaryChoices"] ?? []),
      allergies: json["allergies"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "race": race,
      "gender": gender,
      "birthdate": birthdate,
      "dietaryChoices": dietaryChoices,
      "allergies": allergies,
    };
  }
}

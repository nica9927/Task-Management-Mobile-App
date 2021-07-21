
// To parse this JSON data, do


class LinkGender {
  LinkGender({
    this.genderId,
    this.genderNameTh,
    this.genderNameEn,
  });

  final int? genderId;
  final String? genderNameTh;
  final String? genderNameEn;

  factory LinkGender.fromJson(Map<String, dynamic> json) => LinkGender(
    genderId: json["gender_id"],
    genderNameTh: json["gender_name_th"],
    genderNameEn: json["gender_name_en"],
  );

  Map<String, dynamic> toJson() => {
    "gender_id": genderId,
    "gender_name_th": genderNameTh,
    "gender_name_en": genderNameEn,
  };
}

class DefaultValue {
  static final List<ImageHash> imageHashLogin = ImageHash.loginScreen();
}

class ImageHash {
  final String? imagePath;

  final String? blurHash;

  ImageHash({this.imagePath, this.blurHash});

  static List<ImageHash> loginScreen() {
    return [
      ImageHash(imagePath: "assets/image/background/bg_hospital.jpg", blurHash: "LdHpVB?^D*ITT0bvt7oJs.t7X9ay"),
      ImageHash(imagePath: "assets/image/background/bg_hospital_2.jpg", blurHash: "LGIr~T%z00~Xs*?bD*IA8{IB?]tP"),
      ImageHash(imagePath: "assets/image/background/bg_hospital_3.jpg", blurHash: "LQNnK[Mx.S.8~Vxt-pof9axaM|Rj"),
    ];
  }
}
class DefaultError {
  static final String isRequireMessage = "This field is require";
}

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year - 10, kNow.month, kNow.day);
final kLastDay = DateTime(kNow.year + 10, kNow.month, kNow.day);

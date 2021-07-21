import 'package:package_info/package_info.dart';

import 'base_local.dart';

class PhoneInfoRepository extends BaseLocalRepository {
  PhoneInfoRepository();

  Future<String> getVersion() async {
    try {
      var res = await PackageInfo.fromPlatform();
      return res.version;
    } catch (e) {
      return "-";
    }
  }
}

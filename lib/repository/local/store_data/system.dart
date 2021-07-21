import 'package:hive/hive.dart';

part 'system.g.dart';

@HiveType(typeId: 1)
class StoreSystemData extends HiveObject {
  @HiveField(0)
  String? apiToken;

  @HiveField(1)
  String? refreshToken;

  @HiveField(2)
  String? companyID;

  Future<void> reset() async {
    apiToken = null;
    refreshToken = null;
    companyID = null;
    await this.save();
  }

  @override
  String toString() {
    return 'StoreSystemData{apiToken: $apiToken, refreshToken: $refreshToken, companyID: $companyID}';
  }
}


import 'package:hive/hive.dart';
import 'package:task_management_app/repository/local/store_data/store.box.dart';
import 'package:task_management_app/repository/local/store_data/system.dart';

Future<bool> clearCompanyLocal() async {
  var user = Hive.box<StoreSystemData>(systemBox).getAt(0)!;
  user.companyID = null;
  await user.save();
  return true;
}
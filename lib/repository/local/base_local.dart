import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info/package_info.dart';

import 'store_data/store.box.dart';
import 'store_data/system.dart';

class BaseLocalRepository {
  late StoreSystemData systemData;

  BaseLocalRepository() {
    /// System
    var _systemBox = Hive.box<StoreSystemData>(systemBox);
    this.systemData = _systemBox.getAt(0) ?? StoreSystemData();
  }

  Future<String> getUniqueID() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    }
    throw ("Can't get 'UniqueID' for this device");
  }

  Future<LocationData?> getCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData? _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return _locationData;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return _locationData;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  Future<String> getVersion() async {
    try {
      var res = await PackageInfo.fromPlatform();
      return res.version;
    } catch (e) {
      return "-";
    }
  }

  Future<String> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.device;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.name;
    }
    throw ("Can't get 'UniqueID' for this device");
  }

  // Future<String> getPlayerID() async {
  //   var status = await OneSignal.shared.getPermissionSubscriptionState();
  //   var playerID = status.subscriptionStatus.userId;
  //   return playerID;
  // }
}

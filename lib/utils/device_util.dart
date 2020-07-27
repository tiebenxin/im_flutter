import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceUtil {
  static IosDeviceInfo iosInfo;
  static AndroidDeviceInfo androidInfo;

  void getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if (Platform.isIOS) {
      print('IOS设备：');
      iosInfo = await deviceInfo.iosInfo;
    } else if (Platform.isAndroid) {
      print('Android设备');
      androidInfo = await deviceInfo.androidInfo;
    }
  }

  static Future<String> getDeviceId() async {
    if (iosInfo == null || androidInfo == null) {
      DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
      if (Platform.isIOS) {
        print('IOS设备：');
        iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor;
      } else if (Platform.isAndroid) {
        print('Android设备');
        androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id;
      }
    } else {
      if (Platform.isIOS) {
        print('IOS设备：');
        return iosInfo.identifierForVendor;
      } else if (Platform.isAndroid) {
        print('Android设备');
        return androidInfo.id;
      }
    }
    return "";
  }

  static Future<String> getPhoneModel() async {
    if (iosInfo == null || androidInfo == null) {
      DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
      if (Platform.isIOS) {
        print('IOS设备：');
        iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor;
      } else if (Platform.isAndroid) {
        print('Android设备');
        androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id;
      }
    } else {
      if (Platform.isIOS) {
        print('IOS设备：');
        return iosInfo.identifierForVendor +
            " " +
            iosInfo.model +
            " " +
            iosInfo.systemVersion;
      } else if (Platform.isAndroid) {
        String result = androidInfo.brand +
            " " +
            androidInfo.model +
            " " +
            androidInfo.version.baseOS;
        print('Android设备' + result);
        return result;
      }
    }
    return "";
  }

  static Future<String> getDeviceName() async {
    if (iosInfo == null || androidInfo == null) {
      DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
      if (Platform.isIOS) {
        print('IOS设备：');
        iosInfo = await deviceInfo.iosInfo;
        return iosInfo.name;
      } else if (Platform.isAndroid) {
        print('Android设备');
        androidInfo = await deviceInfo.androidInfo;
        return androidInfo.product;
      }
    } else {
      if (Platform.isIOS) {
        print('IOS设备：');
        return iosInfo.name;
      } else if (Platform.isAndroid) {
        print('Android设备');
        return androidInfo.product;
      }
    }
    return "";
  }
}

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../config/constant/value.constant.dart';

@immutable
abstract final class DeviceInfo {
  static Future<Map<String, String>> get packageInfo async {
    final packageInfo = await PackageInfo.fromPlatform();
    return {
      'APP_ID': packageInfo.packageName,
      'APP_VERSION': packageInfo.version,
      'APP_BUILD_NUMBER': packageInfo.buildNumber,
      'OS': Platform.isIOS ? ValueConstant.ios : ValueConstant.android,
      'OS_VERSION': Platform.operatingSystemVersion,
    };
  }

  static Future<AndroidDeviceInfo> get androidInfo async {
    final deviceInfo = DeviceInfoPlugin();
    return await deviceInfo.androidInfo;
  }

  static Future<IosDeviceInfo> get iosInfo async {
    final deviceInfo = DeviceInfoPlugin();
    return await deviceInfo.iosInfo;
  }

  static Future<Map<String, dynamic>> get deviceInfo async {
    final packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isIOS) {
      final info = await iosInfo;
      return <String, dynamic>{
        'App Version': '${packageInfo.version} (${packageInfo.buildNumber})',
        'identifierForVendor': info.identifierForVendor,
        'isPhysicalDevice': info.isPhysicalDevice,
        'localizedModel': info.localizedModel,
        'model': info.model,
        'name': info.name,
        'systemName': info.systemName,
        'systemVersion': info.systemVersion,
        'utsname.machine:': info.utsname.machine,
        'utsname.nodename:': info.utsname.nodename,
        'utsname.release:': info.utsname.release,
        'utsname.sysname:': info.utsname.sysname,
        'utsname.version:': info.utsname.version,
      };
    }

    final info = await androidInfo;
    return <String, dynamic>{
      'App Version': '${packageInfo.version} (${packageInfo.buildNumber})',
      'board': info.board,
      'bootloader': info.bootloader,
      'brand': info.brand,
      'device': info.device,
      'display': info.display,
      'fingerprint': info.fingerprint,
      'hardware': info.hardware,
      'host': info.host,
      'id': info.id,
      'isPhysicalDevice': info.isPhysicalDevice,
      'manufacturer': info.manufacturer,
      'model': info.model,
      'product': info.product,
      'tags': info.tags,
      'type': info.type,
      'supported32BitAbis': info.supported32BitAbis,
      'supported64BitAbis': info.supported64BitAbis,
      'supportedAbis': info.supportedAbis,
      'version.baseOS': info.version.baseOS,
      'version.codename': info.version.codename,
      'version.incremental': info.version.incremental,
      'version.previewSdkInt': info.version.previewSdkInt,
      'version.release': info.version.release,
      'version.securityPatch': info.version.securityPatch,
      'version.sdkInt': info.version.sdkInt,
    };
  }
}

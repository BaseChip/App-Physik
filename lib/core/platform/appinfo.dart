import 'package:package_info/package_info.dart';

abstract class AppInfo {
  String get appVersion;
  String get appName;
}

class AppInfoImpl implements AppInfo {
  final PackageInfo packageInfo;

  AppInfoImpl({this.packageInfo});
  @override
  String get appName {
    if (packageInfo != null) {
      return packageInfo.appName;
    } else {
      return "Web App";
    }
  }

  @override
  String get appVersion {
    if (packageInfo != null) {
      return packageInfo.version;
    } else {
      return "v.1.1.3";
    }
  }
}

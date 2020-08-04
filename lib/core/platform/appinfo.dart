import 'package:package_info/package_info.dart';

abstract class AppInfo{
  String get appVersion;
  String get appName;
}

class AppInfoImpl implements AppInfo{
  final PackageInfo _packageInfo;

  AppInfoImpl(this._packageInfo);
  @override
  String get appName => _packageInfo.appName;

  @override
  String get appVersion => _packageInfo.version;

}
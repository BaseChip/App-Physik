import 'package:meta/meta.dart';

import '../../domain/entities/auth_key_entitie.dart';

class AuthKeyModell extends AuthKey {
  AuthKeyModell({
    @required String key,
  }) : super(auth_key: key);

  factory AuthKeyModell.fromJson(Map<String, dynamic> json) {
    return AuthKeyModell(key: json['Auth_Key']);
  }
}

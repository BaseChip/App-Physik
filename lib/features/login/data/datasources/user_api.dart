import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/success/succes.dart';

import '../../domain/entities/auth_key_entitie.dart';

import '../models/auth_key_modell.dart';

abstract class UserApi {
  /// Ruft die http://srv2.thebotdev.de/ api auf um einen neuen User zu erstellen / löschen oder den Auth Key zu bekpmmen
  ///
  /// Wirft eine [WrongCredentialsException] Error, wenn die anmelde Daten nicht stimmen
  /// Eine [UserExistsException] wenn der user nicht neu angelegt werden kann, da er bereits existiert
  /// Eine [UserDosntExistException] wenn der User nicht existiert
  /// Eine [WrongCredentialsException] wenn die Anmeldedaten des Nutzers nicht stimmen
  /// Bei jedem anderen Fehler wird eine [ServerException] geworfen
  Future<AuthKey> login(String email, String pw);
  Future<AuthKey> create_user(String email, String pw);
  Future<Success> delete_user(String authkey);
}

class UserApiImpl implements UserApi {
  final http.Client client;
  final String baseurl = "http://srv2.thebotdev.de";
  UserApiImpl({@required this.client});

  @override
  Future<AuthKey> create_user(String email, pw) async {
    final response =
        await client.get("$baseurl/createuser?email=$email&pw=$pw");
    if (response.statusCode == 200) {
      return AuthKeyModell.fromJson(json.decode(response.body));
    } else if (response.statusCode == 406) {
      throw UserExistsException();
    } else if (response.statusCode == 401) {
      throw CredentialsNotFitException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Success> delete_user(String authkey) async {
    final response = await client
        .delete("$baseurl/delete", headers: {"x-access-token": authkey});
    if (response.statusCode == 200) {
      return Success();
    } else if (response.statusCode == 409) {
      throw UserDosntExistException();
    } else if (response.statusCode == 401) {
      throw WrongCredentialsException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthKey> login(String email, pw) async {
    final response = await client.get("$baseurl/login?email=$email&pw=$pw");
    if (response.statusCode == 200) {
      return AuthKeyModell.fromJson(json.decode(response.body));
    } else if (response.statusCode == 409) {
      throw UserDosntExistException();
    } else if (response.statusCode == 401) {
      throw WrongCredentialsException();
    } else {
      throw ServerException();
    }
  }
}

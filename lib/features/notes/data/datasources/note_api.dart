import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/success/succes.dart';
import '../../../../core/util/shared_prefrences/shared_prefs_auth.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/note_entitie.dart';
import '../../domain/entities/notes_list_entitie.dart';
import '../models/note_model.dart';
import '../models/notes_list_model.dart';

abstract class NoteApi {
  Future<Note> getNote(int id);
  Future<NotesList> getNotes();
  Future<Success> deleteNote(int id);
  Future<Success> changeNote(String note, int id);
  Future<Success> addNote(String title, String note);
}

class NoteApiImpl implements NoteApi {
  final http.Client client;
  final String baseurl = "http://srv2.thebotdev.de";
  final String app = "physik";
  NoteApiImpl({@required this.client});

  String get _checkforAuthKey {
    if (sl<SharedPrefsAuth>().logedin) {
      return sl<SharedPrefsAuth>().authKey;
    } else {
      throw NoAuthKeyGivenException();
    }
  }

  @override
  Future<Success> addNote(String title, String note) async {
    try {
      final response = await client.post("$baseurl/note",
          headers: {"x-access-token": _checkforAuthKey},
          body: {"note": note, "title": title, "app": app});
      if (response.statusCode == 200) {
        return Success();
      } else if (response.statusCode == 500) {
        throw ArgsMissingException();
      } else if (response.statusCode == 401) {
        throw WrongCredentialsException();
      } else {
        throw ServerException();
      }
    } on NoAuthKeyGivenException {
      throw NoAuthKeyGivenException();
    }
  }

  @override
  Future<Success> changeNote(String note, int id) async {
    try {
      final response = await client.post("$baseurl/changenote",
          headers: {"x-access-token": _checkforAuthKey},
          body: {"note": note, "id": id.toString(), "app": app});
      if (response.statusCode == 200) {
        return Success();
      } else if (response.statusCode == 500) {
        throw ArgsMissingException();
      } else if (response.statusCode == 401) {
        throw WrongCredentialsException();
      } else {
        throw ServerException();
      }
    } on NoAuthKeyGivenException {
      throw NoAuthKeyGivenException();
    }
  }

  @override
  Future<Success> deleteNote(int id) async {
    try {
      final response = await client.delete("$baseurl/note?id=$id",
          headers: {"x-access-token": _checkforAuthKey});
      if (response.statusCode == 200) {
        return Success();
      } else if (response.statusCode == 500) {
        throw ArgsMissingException();
      } else if (response.statusCode == 401) {
        throw WrongCredentialsException();
      } else {
        throw ServerException();
      }
    } on NoAuthKeyGivenException {
      throw NoAuthKeyGivenException();
    }
  }

  @override
  Future<Note> getNote(int id) async {
    try {
      final response = await client.get("$baseurl/note?id=$id",
          headers: {"x-access-token": _checkforAuthKey});
      if (response.statusCode == 200) {
        return NoteModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 406) {
        throw ArgsMissingException();
      } else if (response.statusCode == 401) {
        throw WrongCredentialsException();
      } else {
        throw ServerException();
      }
    } on NoAuthKeyGivenException {
      throw NoAuthKeyGivenException();
    }
  }

  @override
  Future<NotesList> getNotes() async {
    try {
      final response = await client.get("$baseurl/notes?app=$app",
          headers: {"x-access-token": _checkforAuthKey});
      if (response.statusCode == 200) {
        return NotesListModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 406) {
        throw ArgsMissingException();
      } else if (response.statusCode == 401) {
        throw WrongCredentialsException();
      } else {
        throw ServerException();
      }
    } on NoAuthKeyGivenException {
      throw NoAuthKeyGivenException();
    }
  }
}

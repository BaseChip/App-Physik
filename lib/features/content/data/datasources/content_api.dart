import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/articel_entitie.dart';
import '../../domain/entities/articels_list_entitie.dart';
import '../../domain/entities/topics_entitie.dart';
import '../models/articel_model.dart';
import '../models/articels_list_model.dart';
import '../models/topics_list_model.dart';

abstract class ContentApi {
  /// Ruft die http://srv2.thebotdev.de/physik api auf um von dort alle Themen / alle Artikel oder einen bestimmten Artikel aufzurufen
  ///
  /// Wirft eine [ServerException] bei jedem Fehlercode
  Future<Topics> getAllTopics();
  Future<ArticelsList> getAllArticels(int id);
  Future<Articel> getArticel(int id);
}

class ContentApiImpl implements ContentApi {
  final http.Client client;
  final String baseurl = "http://srv2.thebotdev.de";
  final String app = "physik";
  ContentApiImpl({@required this.client});

  @override
  Future<Topics> getAllTopics() async {
    return _getAllTopics();
  }

  Future<Topics> _getAllTopics() async {
    final response = await client.get("$baseurl/topics?app=$app");
    if (response.statusCode == 200) {
      return TopicsListModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ArticelsList> getAllArticels(int id) => _getAllArticels(id);

  Future<ArticelsList> _getAllArticels(int id) async {
    final response = await client.get("$baseurl/articels?id=$id&app=$app");
    if (response.statusCode == 200) {
      return ArticelsListModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Articel> getArticel(int id) => _getArticel(id);

  Future<Articel> _getArticel(int id) async {
    final response = await client.get("$baseurl/articel?id=$id&app=$app");
    if (response.statusCode == 200) {
      return ArticelModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}

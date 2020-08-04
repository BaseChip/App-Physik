import 'package:meta/meta.dart';

import '../../domain/entities/articel_entitie.dart';

class ArticelModel extends Articel{
  ArticelModel({
    @required int id,
    @required int thema_id,
    @required String autor,
    @required String titel,
    @required String typ,
    @required String content
  }) : super(id: id, thema_id: thema_id, autor: autor, titel: titel, typ: typ, content: content);

  factory ArticelModel.fromJson(Map<String, dynamic> json){
    return ArticelModel(
      id: json['id'],
      thema_id: json['thema_id'],
      autor: json['autor'],
      content: json['content'],
      typ: json['typ'],
      titel: json['titel']);
  }

  Map<String, dynamic> toJson(){
    return{
      "id": id,
      "thema_id": thema_id,
      "autor": autor,
      "titel": titel,
      "typ": typ,
      "content": content
    };
  }
}
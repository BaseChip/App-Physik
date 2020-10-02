import 'package:meta/meta.dart';

import '../../domain/entities/articel_entitie.dart';

class ArticelModel extends Articel {
  ArticelModel(
      {@required int id,
      @required int themaId,
      @required String autor,
      @required String titel,
      @required String typ,
      @required String content})
      : super(
            id: id,
            themaId: themaId,
            autor: autor,
            titel: titel,
            typ: typ,
            content: content);

  factory ArticelModel.fromJson(Map<String, dynamic> json) {
    return ArticelModel(
        id: json['id'],
        themaId: json['thema_id'],
        autor: json['autor'],
        content: json['content'],
        typ: json['typ'],
        titel: json['titel']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "thema_id": themaId,
      "autor": autor,
      "titel": titel,
      "typ": typ,
      "content": content
    };
  }
}

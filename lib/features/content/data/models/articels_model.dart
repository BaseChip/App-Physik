import 'package:meta/meta.dart';

import '../../domain/entities/articels_entitie.dart';

class ArticelsModel extends Articels{
  ArticelsModel({
    @required int id,
    @required String titel
  }) : super(id: id, titel: titel);

  factory ArticelsModel.fromJson(Map<String, dynamic> json){
    return ArticelsModel(id: json['id'], titel: json['titel']);
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "titel": titel
    };
  }
}
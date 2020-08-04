import 'package:flutter/cupertino.dart';

import '../../domain/entities/articels_entitie.dart';
import '../../domain/entities/articels_list_entitie.dart';
import 'articels_model.dart';

class ArticelsListModel extends ArticelsList{
  ArticelsListModel({
    @required List<Articels> articels
  }) : super(articels: articels);

  factory ArticelsListModel.fromJson(List<dynamic> json){
    List<Articels> list = [];
    json.forEach((value) { list.add(ArticelsModel.fromJson(value));});
    return ArticelsListModel(articels: list);
  }
}
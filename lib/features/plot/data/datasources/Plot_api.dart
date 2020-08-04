import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/plot_filename_model.dart';

import '../../domain/entities/plot_filename.dart';

abstract class PlotApi{
  /// Ruft die http://srv2.thebotdev.de/plot/beugungsmuster api auf und erzeugt einen neuen Plot mit den übergebenen Argumenten
  /// 
  /// Wirft eine [ServerException] bei jedem Fehlercode
  Future<PlotFileName> getBeugungsmusterPlot(int spaltanzahl, double spaltabstand, double wellenlaenge, double amplitude);
}

class PlotApiImpl implements PlotApi{
  final http.Client client;
  final String baseurl = "http://srv2.thebotdev.de/";
  PlotApiImpl({@required this.client});


  @override
  Future<PlotFileName> getBeugungsmusterPlot(int spaltanzahl, double spaltabstand, double wellenlaenge, double amplitude)=> _getPlotFromUrl("$baseurl/plot/beugungsmuster?spaltanzahl=$spaltanzahl&spaltabstand=$spaltabstand&wellenlaenge=$wellenlaenge&amplitude=$amplitude");

  Future<PlotFilenameModel> _getPlotFromUrl(String url) async{
    final response = await client.get(url);
    if(response.statusCode == 200){
      return PlotFilenameModel.fromJson(json.decode(response.body));
    }else{
      throw ServerException();
    }
  }
}
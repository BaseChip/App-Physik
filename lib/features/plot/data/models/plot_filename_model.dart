import 'package:meta/meta.dart';

import '../../domain/entities/plot_filename.dart';

class PlotFilenameModel extends PlotFileName{
  PlotFilenameModel({
    @required String filename, 
  }) : super (filename: filename);

  factory PlotFilenameModel.fromJson(Map<String, dynamic> json){
    return PlotFilenameModel(filename: json['filename']);
  }
  Map<String, dynamic> toJson(){
    return{
      'filename': filename
    };
  }
}
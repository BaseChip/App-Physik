import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'articels_entitie.dart';

class ArticelsList extends Equatable{
  final List<Articels> articels;
  
  ArticelsList({
    @required this.articels
  });
  @override
  List<Object> get props => [articels];

}
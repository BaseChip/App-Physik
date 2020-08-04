import 'package:flutter/material.dart';

import '../bloc/content_bloc.dart';
import 'articels_card.dart';

class ArticelsListDisplay extends StatelessWidget{
  final ArticelsLoaded state;
  ArticelsListDisplay({@required this.state});
  @override
  Widget build(BuildContext context) {
    List<Widget> menu = [];
    state.articels.articels.forEach((element) { 
      menu.add(ArticelsCard(articel_name: element.titel, articel_id: element.id));
    });
    return Expanded(child: ListView(children: menu,));
  }
  
}
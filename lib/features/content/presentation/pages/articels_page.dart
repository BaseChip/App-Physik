import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/content_bloc.dart';
import '../widgets/articels_list_display.dart';
import '../widgets/content_error_display.dart';
import '../widgets/content_loading_display.dart';

final String errorInitial = "Scheint als wäre die Api nicht aufgerufen worden, bitte starte die App noch mal neu";
class ArticelsPage extends StatefulWidget {
  final int thema_id;
  ArticelsPage({@required this.thema_id});

  @override
  _ArticelsPageState createState() => _ArticelsPageState(thema_id: thema_id);
}

class _ArticelsPageState extends State<ArticelsPage> {
  final int thema_id;
  _ArticelsPageState({@required this.thema_id});
  bool madearticelsscall = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hauptmenü"),),
      body: buildbody(context),
    );
  }

  _getAllArticels(BuildContext context){
    BlocProvider.of<ContentBloc>(context).add(GetAllArticelsEvent(id: thema_id));
  }

  BlocProvider<ContentBloc> buildbody(BuildContext context){
    return BlocProvider(
      create: (context) => sl<ContentBloc>(),
      child: Column(
        children: <Widget>[
          BlocBuilder<ContentBloc, ContentState>(
            builder: (context, state){
              if(!madearticelsscall){
                madearticelsscall = true;
                _getAllArticels(context);
              }
            if(state is ContentError){
                return ContentErrorDisplay(error: state.error);
              } else if(state is ContentInitial){
                return ContentErrorDisplay(error: errorInitial);
              } else if(state is ContentLoading){
                return ContentLoadingDisplay();
              }else if(state is ArticelsLoaded){
                return ArticelsListDisplay(state: state);
              }else{
                return ContentErrorDisplay(error: "Unknown State: "+state.toString());
              }
          },)
        ]
      )
      );
  }
}
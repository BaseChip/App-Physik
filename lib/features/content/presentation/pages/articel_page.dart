import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/content_bloc.dart';
import '../widgets/articel_display.dart';
import '../widgets/content_error_display.dart';
import '../widgets/content_loading_display.dart';

final String errorInitial =
    "Scheint als wäre die Api nicht aufgerufen worden, bitte starte die App noch mal neu";

class ArticelPage extends StatefulWidget {
  final int articelId;
  ArticelPage({@required this.articelId});

  @override
  _ArticelPageState createState() => _ArticelPageState(articelId: articelId);
}

class _ArticelPageState extends State<ArticelPage> {
  final int articelId;
  String appbarTitel = "Loading";
  _ArticelPageState({@required this.articelId});
  bool madearticelsscall = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitel),
      ),
      body: buildbody(context),
    );
  }

  _getAllArticels(BuildContext context) {
    BlocProvider.of<ContentBloc>(context).add(GetArticelEvent(id: articelId));
  }

  BlocProvider<ContentBloc> buildbody(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<ContentBloc>(),
        child: Column(children: <Widget>[
          BlocBuilder<ContentBloc, ContentState>(
            builder: (context, state) {
              if (!madearticelsscall) {
                madearticelsscall = true;
                _getAllArticels(context);
              }
              if (state is ContentError) {
                return ContentErrorDisplay(error: state.error);
              } else if (state is ContentInitial) {
                return ContentErrorDisplay(error: errorInitial);
              } else if (state is ContentLoading) {
                return ContentLoadingDisplay();
              } else if (state is ArticelLoaded) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    appbarTitel = state.articel.titel;
                  });
                });
                return ArticelDisplay(
                    content: state.articel.content, typ: state.articel.typ);
              } else {
                return ContentErrorDisplay(
                    error: "Unknown State: " + state.toString());
              }
            },
          )
        ]));
  }
}

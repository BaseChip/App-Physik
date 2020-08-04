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
  final int articel_id;
  ArticelPage({@required this.articel_id});

  @override
  _ArticelPageState createState() => _ArticelPageState(articel_id: articel_id);
}

class _ArticelPageState extends State<ArticelPage> {
  final int articel_id;
  String appbar_titel = "Loading";
  _ArticelPageState({@required this.articel_id});
  bool madearticelsscall = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbar_titel),
      ),
      body: buildbody(context),
    );
  }

  _getAllArticels(BuildContext context) {
    BlocProvider.of<ContentBloc>(context).add(GetArticelEvent(id: articel_id));
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
                    appbar_titel = state.articel.titel;
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

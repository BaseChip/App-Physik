import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/content_bloc.dart';
import '../widgets/content_error_display.dart';
import '../widgets/content_loading_display.dart';
import '../widgets/topics_list_display.dart';

final String errorInitial =
    "Scheint als wäre die Api nicht aufgerufen worden, bitte starte die App noch mal neu";

class TopicsPage extends StatefulWidget {
  TopicsPage({Key key}) : super(key: key);

  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  bool madetopicscall = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hauptmenü"),
      ),
      body: buildbody(context),
    );
  }

  _getAllTopics(BuildContext context) {
    BlocProvider.of<ContentBloc>(context).add(GetAllTopicsEvent());
  }

  BlocProvider<ContentBloc> buildbody(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<ContentBloc>(),
        child: Column(children: <Widget>[
          BlocBuilder<ContentBloc, ContentState>(
            builder: (context, state) {
              if (!madetopicscall) {
                madetopicscall = true;
                _getAllTopics(context);
              }
              if (state is ContentError) {
                return TopicsListDisplay(
                  offline: true,
                );
              } else if (state is ContentInitial) {
                return ContentErrorDisplay(error: errorInitial);
              } else if (state is ContentLoading) {
                return ContentLoadingDisplay();
              } else if (state is TopicsLoaded) {
                return TopicsListDisplay(state: state);
              } else {
                return ContentErrorDisplay(
                    error: "Unknown State: " + state.toString());
              }
            },
          )
        ]));
  }
}

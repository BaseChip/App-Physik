import 'package:flutter/material.dart';

import '../../../../core/ui/pages/tools/menu_item_card.dart';
import '../../../../core/ui/pages/tools/toolspage.dart';
import '../bloc/content_bloc.dart';
import 'topic_card.dart';

const String OFFLINE_MESSAGE =
    "Es scheint als wärst du offline, daher konnten die Themen nicht geladen werden";

class TopicsListDisplay extends StatelessWidget {
  final TopicsLoaded state;
  bool offline;
  TopicsListDisplay({this.state, this.offline = false});
  @override
  Widget build(BuildContext context) {
    List<Widget> menu = [];
    if (!offline) {
      state.topics.topics.forEach((element) {
        menu.add(TopicCard(topic_name: element.topic, topic_id: element.id));
      });
    } else {
      menu.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          OFFLINE_MESSAGE,
          style: Theme.of(context).primaryTextTheme.bodyText1,
        ),
      ));
    }
    menu.add(MenuItem(name: "Tools / Settings", page: ToolsMenu()));
    return Expanded(
        child: ListView(
      children: menu,
    ));
  }
}

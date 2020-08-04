import 'package:flutter/material.dart';

import '../pages/articels_page.dart';

class TopicCard extends StatelessWidget {
  final String topic_name;
  final int topic_id;
  TopicCard({
    @required this.topic_name,
    @required this.topic_id});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
              title: Text(topic_name, style: Theme.of(context).primaryTextTheme.bodyText1),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).dividerColor,
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>ArticelsPage(thema_id: topic_id,)),)
              ))
    );
  }
}
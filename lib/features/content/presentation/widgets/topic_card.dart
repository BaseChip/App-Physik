import 'package:flutter/material.dart';

import '../pages/articels_page.dart';

class TopicCard extends StatelessWidget {
  final String topicName;
  final int topicId;
  TopicCard({@required this.topicName, @required this.topicId});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                title: Text(topicName,
                    style: Theme.of(context).primaryTextTheme.bodyText1),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).dividerColor,
                ),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArticelsPage(
                                themaId: topicId,
                                topicName: topicName,
                              )),
                    ))));
  }
}

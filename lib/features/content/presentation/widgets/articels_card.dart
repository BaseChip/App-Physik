import 'package:flutter/material.dart';

import '../pages/articel_page.dart';

class ArticelsCard extends StatelessWidget {
  final String articelName;
  final int articelId;
  ArticelsCard({@required this.articelName, @required this.articelId});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                title: Text(articelName,
                    style: Theme.of(context).primaryTextTheme.bodyText1),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).dividerColor,
                ),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ArticelPage(articelId: articelId)),
                    ))));
  }
}

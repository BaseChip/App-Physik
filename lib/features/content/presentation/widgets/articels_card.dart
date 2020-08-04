import 'package:flutter/material.dart';

import '../pages/articel_page.dart';

class ArticelsCard extends StatelessWidget {
  final String articel_name;
  final int articel_id;
  ArticelsCard({
    @required this.articel_name,
    @required this.articel_id});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
              title: Text(articel_name, style: Theme.of(context).primaryTextTheme.bodyText1),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).dividerColor,
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>ArticelPage(articel_id: articel_id)),)
              ))
    );
  }
}
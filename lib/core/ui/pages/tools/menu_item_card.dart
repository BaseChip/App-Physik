import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String name;
  var page;
  MenuItem({
    @required this.name,
    @required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
              title: Text(name, style: Theme.of(context).primaryTextTheme.bodyText1),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).dividerColor,
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>page)),
              ))
    );
  }
}
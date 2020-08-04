import 'package:flutter/material.dart';

class ContentLoadingDisplay extends StatelessWidget {
  const ContentLoadingDisplay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height/2.5,
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(strokeWidth: 2, valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),),
            Text("Wird geladen", style: Theme.of(context).primaryTextTheme.bodyText1,)
          ],
        )),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final from;
  const LoginButton({@required this.text, @required this.from});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.width / 5,
        child: RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.button.color,
                  fontSize: 40),
            ),
            onPressed: () {
              from.ButtonAction();
            }),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String text;
  final from;
  final bool obsure_text;
  const LoginTextField(
      {@required this.text, @required this.from, this.obsure_text = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            width: MediaQuery.of(context).size.width / 1.2,
            child: TextField(
              obscureText: obsure_text,
              style: Theme.of(context).primaryTextTheme.button,
              onChanged: (value) {
                if (text == "Email:") {
                  from.email = value;
                } else if (text == "Password:") {
                  from.pw = value;
                }
              },
              decoration: InputDecoration(
                labelText: text,
                filled: true,
                fillColor: Theme.of(context).accentColor,
                focusColor: Colors.white,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Theme.of(context).dividerColor),
                  borderRadius: new BorderRadius.circular(25.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.transparent),
                  borderRadius: new BorderRadius.circular(25.7),
                ),
                labelStyle: Theme.of(context).primaryTextTheme.button,
              ),
            )));
  }
}

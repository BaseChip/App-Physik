import 'package:flutter/material.dart';

class AccountDialog extends StatelessWidget {
  const AccountDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Account",
        style: TextStyle(
            color: Theme.of(context).primaryTextTheme.headline3.color,
            fontSize: 30),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: Column(children: <Widget>[
          Divider(),
          Text(
            "Ein Account wird benötigt, damit z. B. deine Notizen gespeichert werden können und somit auch in der Web Version verfügbar sind.\n\nWichtig: Dein Password wird am Server verschlüsselt gespeichert! Dabei wird dein Password gehashed und mit einem zufälligen Salt String verbunden, was es beinah unmöglich macht das Passwort wieder lesbar zu machen. Nicht mal der App Entwickler kann das Passwort auslesen.",
            style: TextStyle(
                color: Theme.of(context).primaryTextTheme.bodyText1.color,
                fontSize: 20),
          ),
        ]),
      ),
      backgroundColor: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );
  }
}

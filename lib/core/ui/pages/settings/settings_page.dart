import 'package:flutter/material.dart';

import '../../../../features/intro_slider/presentation/slider_page.dart';
import '../../../../features/login/presentation/pages/delete_account_page.dart';
import '../../../platform/appinfo.dart';
import 'widgets/cdots_chooser.dart';
import 'widgets/drop_down_rendering_engine.dart';
import 'widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  final AppInfo appInfo;
  SettingsPage({@required this.appInfo});

  @override
  _SettingsPageState createState() => _SettingsPageState(appInfo: appInfo);
}

class _SettingsPageState extends State<SettingsPage> {
  final AppInfo appInfo;
  _SettingsPageState({@required this.appInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Einstellungen"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Theme:",
                    style: Theme.of(context).primaryTextTheme.bodyText1),
              )),
              Expanded(child: dropDownTheme(context))
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Rendering Engine:",
                    style: Theme.of(context).primaryTextTheme.bodyText1),
              )),
              Expanded(child: DropDownRenderingEngine())
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CDotSetting(),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SlidersPage()));
                  },
                  color: Theme.of(context).accentColor,
                  child: Text(
                    "App Intro abspielen",
                    style: Theme.of(context).primaryTextTheme.button,
                  ),
                ),
              )),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeleteAccount()));
                  },
                  color: Theme.of(context).accentColor,
                  child: Text(
                    "Account löschen",
                    style: Theme.of(context).primaryTextTheme.button,
                  ),
                ),
              )),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 5.0),
                child: RaisedButton(
                  onPressed: () {
                    aboutDialog(context, appInfo);
                  },
                  color: Theme.of(context).accentColor,
                  child: Text(
                    "Über die App",
                    style: Theme.of(context).primaryTextTheme.button,
                  ),
                ),
              )),
            ],
          )
        ],
      ),
    );
  }
}

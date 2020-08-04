import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../platform/appinfo.dart';

/// Erzeugt einen About Dialog für die App, welcher alle wichtigen Informationen wie AppVersion / Appname, die Links zu der Datenschutzverordnung
/// und dem Impressum, so wie alle benutzen Libarys aufzählt
aboutDialog(BuildContext context, AppInfo appInfo) {
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(["Images Intro Slider"],
        "The Intro Slider images are created by https://www.freepik.com");
  });
  showAboutDialog(
    context: context,
    applicationVersion: appInfo.appVersion,
    applicationName: appInfo.appName,
    //applicationIcon: Image.network("http://srv2.thebotdev.de/img/playstore.png"),
    children: <Widget>[
      RaisedButton(
        child: Text("Datenschutz"),
        onPressed: _openPrivacyPolicy,
      ),
      RaisedButton(
        child: Text("Impressum"),
        onPressed: _openImprint,
      )
    ],
    applicationLegalese:
        "Diese App ist veröffentlicht unter der GNU General Public License 3",
  );
}

/// Leider können die beiden Funktionen nicht zu einer zusammengefügt werden,
/// da sonst Flutter die seiten direkt beim laden des AboutDialogs öffnen würde
/// Eine Funktion um die Datenschutzerklärung zu öffnen
_openPrivacyPolicy() async {
  const url = 'https://falkmichaelis.eu/datenschutz.html';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Kann $url nicht laden';
  }
}

/// Eine Funktion um das Impressum zu öffnen
_openImprint() async {
  const url = 'https://falkmichaelis.eu/imprint.html';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Kann $url nicht laden';
  }
}

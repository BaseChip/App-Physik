import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

import '../../../core/util/shared_prefrences/shared_prefs_slider.dart';
import '../../../core/util/shared_prefrences/shared_prefs_theme.dart';
import '../../../injection_container.dart';

class SlidersPage extends StatefulWidget {
  SlidersPage({Key key}) : super(key: key);

  @override
  _SlidersPageState createState() => _SlidersPageState();
}

class _SlidersPageState extends State<SlidersPage> {
  List<Slide> slides = new List();

  /// da wir die Farbe im initState verwenden kann noch nicht auf Theme.of()
  /// zugegriffen werden daher lesen wir das Theme aus den sharedPrefs aus um
  /// es bei den slides verwenden zu können
  Color bgColor =
      sl<SharedPrefsTheme>().lastTheme.themeData.scaffoldBackgroundColor;
  String urlReadMore = "https://github.com/BaseChip";

  ///https://www.freepik.com/vectors/book
  @override
  void initState() {
    super.initState();
    slides.add(new Slide(
        title: "Zusammenfassungen",
        description:
            "Lies dir zusammenfassungen für alle Abiturrelevanten Themen durch, falls dir dabei ein Thema fehlt kannst du dies gerne ergänzen",
        pathImage: "assets/articel.png",
        backgroundColor: bgColor));
    slides.add(new Slide(
        title: "Notizen",
        description:
            "Um Ideal auf die Prüfungen vorbereitet zu sein kannst du dir in der App Notizen speichern, welche du auch von deinem Computer aus öffnen kannst und die LaTex unterstützen damit du alle Mathematischen Zeichen und Formeln verwenden kannst",
        pathImage: "assets/notizen.png",
        backgroundColor: bgColor));
    slides.add(new Slide(
        title: "Ergänze",
        description:
            "Dir fehlt ein Theme in der App? Kein Problem ergänz es einfach, für dich und für alle die, die App benutzen! Um zu erfahren, wie du eigene Artikel in die App hinzufügen kannst lies dir einfach $urlReadMore durch, dort findest du alle Informationen wie du ganz einfach etwas für alle zur App hinzufügst",
        pathImage: "assets/articels.png",
        backgroundColor: bgColor));
  }

  void onDonePressed() {
    sl<SharedPrefsSlider>().introGot = true;
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new IntroSlider(
        slides: this.slides,
        onDonePress: onDonePressed,
      ),
    );
  }
}

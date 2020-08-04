import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:physik_lp_app_rewrite/core/util/shared_prefrences/shared_prefs_slider.dart';
import 'package:physik_lp_app_rewrite/features/intro_slider/presentation/slider_page.dart';
import 'package:physik_lp_app_rewrite/features/notes/presentation/pages/markdown_editor/advanced_editor.dart';
import 'package:wakelock/wakelock.dart';

import 'core/ui/theme/bloc/theme_bloc.dart';
import 'features/content/presentation/pages/topics_page.dart';
import 'injection_container.dart' as ic;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ic.init();
  Wakelock.enable();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
              title: 'Physik LK', theme: state.themeData, home: HomePage());
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    /// wenn der Nutzer das erste mal die App startet bekommt er eine kleine
    /// Einweisung in die App
    if (sl<SharedPrefsSlider>().introGot) {
      return TopicsPage();
    } else {
      return SlidersPage();
    }
    //return AdvancedMarkDownEditor();
  }
}

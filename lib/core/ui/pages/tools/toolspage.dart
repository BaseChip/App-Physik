import 'package:flutter/material.dart';

import '../../../../features/login/presentation/pages/login_page.dart';
import '../../../../features/notes/presentation/pages/notes_list_page.dart';
import '../../../../features/plot/presentation/pages/beugungsmusterplot_page.dart';
import '../../../../injection_container.dart';
import '../settings/settings_page.dart';
import 'menu_item_card.dart';

class ToolsMenu extends StatelessWidget {
  const ToolsMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tools")),
      body: Container(
        child: Column(
          children: [
            MenuItem(
                name: "Beugungsmuster Plot", page: BeugungsmusterPlotPage()),
            MenuItem(name: "Notizen", page: NotesPage()),
            MenuItem(name: "Login", page: LoginPage()),
            //MenuItem(name: "AdvancedEditor", page: sl<AdvancedMarkDownEditor>()),

            /// Settingspage muss aus GetIt geladen werden, damit der Settings
            /// Page die Shared Preferences übergeben werden können
            MenuItem(name: "Settings", page: sl<SettingsPage>()),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ui/widgets/error_display.dart';
import '../../../../core/ui/widgets/invisible_widget.dart';
import '../../../../core/util/shared_prefrences/shared_prefs_auth.dart';
import '../../../../injection_container.dart';
import '../../../login/presentation/pages/login_page.dart';
import '../bloc/notes_bloc.dart';
import '../widgets/loading_display.dart';
import '../widgets/notes_list_view.dart';
import 'markdown_editor/advanced_editor.dart';

final String errorInitial =
    "Scheint als wäre die Api nicht aufgerufen worden, bitte starte die App noch mal neu";

class NotesPage extends StatefulWidget {
  NotesPage();

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool made_notes_call = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notizen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (sl<SharedPrefsAuth>().logedin) {
            _titleDialog();
          }
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: buildbody(context),
    );
  }

  _getAllNotes(BuildContext context) {
    BlocProvider.of<NotesBloc>(context).add(GetNotesEvent());
  }

  _titleDialog() async {
    String title = "No title";
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                onChanged: (value) {
                  title = value;
                },
                decoration: new InputDecoration(
                    labelText: 'Titel:', hintText: 'z. B. Bernoulli-Formel'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Abbrechen'),
              onPressed: () {
                /// schließt das geöffnete Fenster (in dem Fall den Dialog)
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('Erstellen'),
              onPressed: () async {
                AdvancedMarkDownEditor editor = AdvancedMarkDownEditor();

                /// Da die Seite erst einmal geladen werden muss, bevor mit den
                /// Elementen iteragiert werden kann, warten wir 10 millisekunden
                /// bevor wir einen Befehl ausführen
                Future.delayed(Duration(milliseconds: 10), () {
                  /// gibt den Variablen new_note und title die richtigen Werte
                  editor.state.new_note = true;
                  editor.state.title = title;

                  /// setzt als neuen Text den Titel als Überschrift
                  editor.state.textFormFieldText = "#$title";
                });
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => editor));
              })
        ],
      ),
    );
  }

  //TODO cleanup -> initialState
  BlocProvider<NotesBloc> buildbody(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<NotesBloc>(),
        child: Column(children: <Widget>[
          BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (sl<SharedPrefsAuth>().logedin) {
                if (!made_notes_call) {
                  made_notes_call = true;
                  _getAllNotes(context);
                }
                if (state is NoteError) {
                  ErrorDisplayFlushbar()
                      .showErrorFlushbar(context, state.error);
                  return InvisibleWidget();
                } else if (state is NotesGot) {
                  return NotesViewer(state: state);
                } else if (state is NoteLoading) {
                  return NotesLoadingDisplay();
                } else {
                  return InvisibleWidget();
                }
              } else {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          "Du musst dich anmelden, um diese Funktion nutzen zu können",
                          style: Theme.of(context).primaryTextTheme.headline3,
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text("Anmelden"),
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          )
        ]));
  }
}

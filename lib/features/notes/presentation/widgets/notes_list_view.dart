import 'package:flutter/material.dart';

import '../bloc/notes_bloc.dart';
import 'notes_card.dart';

class NotesViewer extends StatefulWidget {
  final NotesGot state;
  NotesViewer({@required this.state});

  @override
  _NotesViewerState createState() => _NotesViewerState();
}

class _NotesViewerState extends State<NotesViewer> {
  @override
  Widget build(BuildContext context) {
    List<Widget> menu = [];
    widget.state.notes.notes.forEach((element) {
      menu.add(NoteCard(noteTitle: element.title, noteId: element.id));
    });

    /// Die Reihenfolge der Einträge wird so verändert, dass die zuletzt
    /// ertsellte Notiz ganz oben in der Liste ist und die älteste ganz unten
    List<Widget> menuSorted = [];
    menu.reversed.forEach((element) {
      menuSorted.add(element);
    });

    /// Es wird überprüft, ob überhaupt eine Notiz existiert und falls nicht
    /// wird ein Text ausgegben, der den Nutzer darüber informieren soll
    if (menuSorted.length > 0) {
      return Expanded(
          child: ListView(
        children: menuSorted,
      ));
    } else {
      return Expanded(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          "Noch keine Notizen vorhanden, um eine Notiz zu erstellen klick einfach das Icon unten rechts an",
          style: Theme.of(context).primaryTextTheme.headline3,
        ),
      ));
    }
  }
}

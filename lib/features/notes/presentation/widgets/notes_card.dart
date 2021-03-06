import 'package:flutter/material.dart';

import '../../../../injection_container.dart';
import '../bloc/notes_bloc.dart';
import '../pages/note_viewer.dart';
import '../pages/notes_list_page.dart';

class NoteCard extends StatefulWidget {
  final String noteTitle;
  final int noteId;
  NoteCard({@required this.noteTitle, @required this.noteId});

  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    double _opacity = 1.0;
    String txt = widget.noteTitle;
    return Container(
        child: Opacity(
            opacity: _opacity,
            child: Card(
              child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                  title: Text(txt,
                      style: Theme.of(context).primaryTextTheme.bodyText1),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).dividerColor,
                  ),
                  leading: IconButton(
                      icon: Icon(Icons.delete,
                          color: Theme.of(context).dividerColor),
                      onPressed: () {
                        /// Aus irgendeinem Grund, klappt hier setState nicht, also laden wir
                        /// die Seite einfach neu, aber ohne sie als neue Route
                        /// hinzuzufügen
                        sl<NotesBloc>().add(DeleteNoteEvent(id: widget.noteId));
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => NotesPage()));
                      }),
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NoteViewerPage(noteId: widget.noteId)),
                      )),
            )));
  }
}

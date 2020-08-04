import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:physik_lp_app_rewrite/features/notes/presentation/pages/markdown_editor/advanced_editor.dart';

import '../../../../core/ui/widgets/error_display.dart';
import '../../../../core/ui/widgets/invisible_widget.dart';
import '../../../../injection_container.dart';
import '../bloc/notes_bloc.dart';
import '../widgets/teXdocument.dart';

final String errorInitial =
    "Scheint als wäre die Api nicht aufgerufen worden, bitte starte die App noch mal neu";

class NoteViewerPage extends StatefulWidget {
  final int note_id;
  NoteViewerPage({@required this.note_id});

  @override
  _NoteViewerPageState createState() => _NoteViewerPageState(note_id: note_id);
}

class _NoteViewerPageState extends State<NoteViewerPage> {
  final int note_id;
  String appbar_titel = "Loading";
  String last_error = "";
  String note_text = "";
  _NoteViewerPageState({@required this.note_id});
  bool made_note_call = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbar_titel),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          AdvancedMarkDownEditor editor = AdvancedMarkDownEditor();
          Future.delayed(Duration(milliseconds: 10), () {
            editor.state.noteID = note_id;
            editor.state.textFormFieldText = note_text;
          });
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => editor));
        },
        child: Icon(
          Icons.edit,
          size: 30,
        ),
      ),
      body: buildbody(context),
    );
  }

  _getNote(BuildContext context) {
    BlocProvider.of<NotesBloc>(context).add(GetNoteEvent(id: note_id));
  }

  BlocProvider<NotesBloc> buildbody(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<NotesBloc>(),
        child: Column(children: <Widget>[
          BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (!made_note_call) {
                made_note_call = true;
                _getNote(context);
              }
              if (state is NoteError) {
                if (last_error != state.error) {
                  last_error = state.error;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ErrorDisplayFlushbar()
                        .showErrorFlushbar(context, state.error);
                  });
                  return InvisibleWidget();
                }
              } else if (state is NoteGot) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    appbar_titel = state.note.title;
                    note_text = state.note.note;
                  });
                });
                return Expanded(
                  child: TeXView(
                    renderingEngine: TeXViewRenderingEngine.mathjax(),
                    loadingWidgetBuilder: (context) => Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Text("Rendering...",
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1)
                        ],
                      ),
                    ),
                    style: TeXViewStyle(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor),
                    child: TeXDocument.text(state.note.note),
                  ),
                );
              } else {
                return InvisibleWidget();
              }
            },
          )
        ]));
  }
}

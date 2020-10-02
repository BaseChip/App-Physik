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
  final int noteId;
  NoteViewerPage({@required this.noteId});

  @override
  _NoteViewerPageState createState() => _NoteViewerPageState(noteId: noteId);
}

class _NoteViewerPageState extends State<NoteViewerPage> {
  final int noteId;
  String appbarTitel = "Loading";
  String lastError = "";
  String noteText = "";
  _NoteViewerPageState({@required this.noteId});
  bool madeNoteCall = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitel),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          AdvancedMarkDownEditor editor = AdvancedMarkDownEditor();
          Future.delayed(Duration(milliseconds: 10), () {
            editor.state.noteID = noteId;
            editor.state.textFormFieldText = noteText;
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
    BlocProvider.of<NotesBloc>(context).add(GetNoteEvent(id: noteId));
  }

  BlocProvider<NotesBloc> buildbody(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<NotesBloc>(),
        child: Column(children: <Widget>[
          BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (!madeNoteCall) {
                madeNoteCall = true;
                _getNote(context);
              }
              if (state is NoteError) {
                if (lastError != state.error) {
                  lastError = state.error;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ErrorDisplayFlushbar()
                        .showErrorFlushbar(context, state.error);
                  });
                  return InvisibleWidget();
                }
              } else if (state is NoteGot) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    appbarTitel = state.note.title;
                    noteText = state.note.note;
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
              return InvisibleWidget();
            },
          )
        ]));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/ui/widgets/error_display.dart';
import '../../../../../core/ui/widgets/invisible_widget.dart';
import '../../../../../core/ui/widgets/success_display.dart';
import '../../../../../injection_container.dart';
import '../../bloc/notes_bloc.dart';
import '../../widgets/advanced_editor_widgets/advanced_editor_bottom_appbar_button.dart';
import '../../widgets/advanced_editor_widgets/advanced_editor_save_action_button.dart';
import '../note_viewer.dart';
import '../notes_list_page.dart';

class AdvancedMarkDownEditor extends StatefulWidget {
  /// Sorgt dafür, dass _AdvancedMarkDownEditor State von überall aufgerufen
  /// werden kann
  ///
  /// Syntax: AdvancedMarkDownEditor.of(context).doSomething()
  static _AdvancedMarkDownEditorState of(BuildContext context) => context
      .ancestorStateOfType(const TypeMatcher<_AdvancedMarkDownEditorState>());
  _AdvancedMarkDownEditorState state = _AdvancedMarkDownEditorState();

  AdvancedMarkDownEditor({Key key}) : super();

  @override
  _AdvancedMarkDownEditorState createState() => state;
}

class _AdvancedMarkDownEditorState extends State<AdvancedMarkDownEditor> {
  bool new_note = false;
  String title;
  int noteID;

  /// da die Bloc Befehle nur aus einem BlocContext aufgerufen werden können
  /// speichern wir diesen Context zwischen um ihn fpr die Befehle nutzen können
  BuildContext blocContext;
  static const double _border_padding_navigation = 10;
  TextEditingController _txtController;
  @override
  void initState() {
    _txtController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editor"),
        ),

        /// untere Toolleiste
        bottomNavigationBar: Transform.translate(
          /// Das Offset sorgt dafür, dass die BottomAppBar mit dem Keyboard
          /// nach oben geht und nicht unter der Tatstaur verschwindet
          offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
          child: buildBottomAppBar(context),
        ),
        floatingActionButton: SaveActionButton(),

        /// Lässt den FloatingActionButton central auf der BottomAppBar erscheinen
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        /// Editor
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _txtController,
                expands: true,
                maxLines: null,
                minLines: null,
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.bodyText1.color,
                    fontSize: 20),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 0)),
                //onChanged: (value) {},
              ),
            ),
            buildbloc(context),
          ],
        ));
  }

  /// setzt den übergebenen String ins TextFeld
  set textFormFieldText(String text) {
    /// Da ein \ beim einfügen in die DB verloren geht, muss es beim einfügen als
    /// Text doppelt eingefügt werden, sonst würde es nach jedem speichern ein \
    /// weniger geben, was doof wäre bei den mathematischen Befehlen die ein \\
    /// benutzen (\\frac{1}{2})
    _txtController.text = text.replaceAll("\\", "\\\\");
  }

  BottomAppBar buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Theme.of(context).accentColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EditorBottomAppBarButton(
            replaceStringpattern: "**x**",
            icon: Icons.format_bold,
            tooltip: "Fettgedruckt",
          ),
          EditorBottomAppBarButton(
            replaceStringpattern: "*x*",
            icon: Icons.format_italic,
            tooltip: "Kursiv",
          ),
          EditorBottomAppBarButton(
            replaceStringpattern: "\$\$x\$\$",
            icon: Icons.school,
            tooltip: "Mathe",
          ),
          Padding(
            padding:
                const EdgeInsets.fromLTRB(0, 0, _border_padding_navigation, 0),
            child: Tooltip(
              message: "Löschen",
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).dividerColor,
                ),
                onPressed: () {
                  deleteNote();
                },
              ),
            ),
          ),
        ],
      ),
      //notchMargin: 120,
    );
  }

  /// ersetzt den ausgewählten Text im Textfeld mit dem übergebenen Text
  ///
  /// @param replace - das Muster durch welches der Text ersetzt werden soll,
  /// wobei ein x verwendet wird um zu symbolisieren, dass dort der ausgewählte
  /// Text eingefügt wird
  void replaceSelection(String replace) {
    TextSelection _sel = _txtController.selection;
    String _newText = _txtController.text.replaceRange(_sel.start, _sel.end,
        replace.replaceFirst("x", _sel.textInside(_txtController.text)));

    /// Setzt den neuen Text in das Textfeld
    _txtController.text = _newText;

    /// Sorgt dafür, dass der Kursor wieder da ist, wo er vor dem
    /// setzen des neuen Textes war und nicht am Anfang des Textes
    _txtController.selection = _sel.copyWith(
        baseOffset: _sel.start + replace.length,
        extentOffset: _sel.start + replace.length);
  }

  /// Falls eine Notiz bearbeitet wird, wird die notiz am Server überschrieben
  /// und man wird beim speichern auf den NoteViewer weitergeleitet, falls es
  /// allerdings eine neue Notiz ist, wird eine neue Notiz angelegt und man wird
  /// auf die Seite mit allen Notizen weitergeleitet
  void saveNote() async {
    if (new_note) {
      BlocProvider.of<NotesBloc>(blocContext)
          .add(AddNoteEvent(title: title, note: _txtController.text));

      /// Geht erst zurück auf den HomeScreen der Anwendung um die Route zurück
      /// zusetzen und ruft dann die neue Seite auf, damit die in App Navigation
      /// gut funktioniert
      Future.delayed(Duration(milliseconds: 1), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NotesPage()));
      });
      Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
    } else {
      BlocProvider.of<NotesBloc>(blocContext)
          .add(ChangeNoteEvent(id: noteID, note: _txtController.text));

      /// leitet den User wieder zurück auf die NoteViewerPage und entfernt sich
      /// selber aus dem Speicher
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => NoteViewerPage(note_id: noteID)));
    }
  }

  /// Löscht die aktuelle Notiz
  void deleteNote() {
    ///Falls die Notiz keine neue Notiz ist wird sie vom Server gelöscht,
    ///andernfalls existiert die Notiz auch noch nicht auf dem Server
    if (!new_note) {
      BlocProvider.of<NotesBloc>(blocContext).add(DeleteNoteEvent(id: noteID));
    }

    /// brint den User zurück auf die Seite mit allen Notizen
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => NotesPage()));
  }

  /// setzt den Bloc State wieder auf den initial State zurück
  void setBlocStateInitial() {
    BlocProvider.of<NotesBloc>(blocContext).add(NoteInitialEvent());
  }

  /// Erzeugt den Bloc, der für das speichern und löschen der Notiz zustädig ist
  /// und die Fehler- / Erfolgsnachricht ausgibt
  BlocProvider<NotesBloc> buildbloc(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotesBloc>(),
      child: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          /// Falls wir noch keinen blocContext gespeichert haben, specihern wir
          /// ihn einmal
          if (blocContext == null) {
            blocContext = context;
          }
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (state is NoteSuccessfull) {
              SuccessDisplayFlushbar()
                  .showSuccessFlushbar(context, "Erfolgreich ausgeführt");
              setBlocStateInitial();
            } else if (state is NoteError) {
              ErrorDisplayFlushbar().showErrorFlushbar(context, state.error);
              setBlocStateInitial();
            }
          });
          return InvisibleWidget();
        },
      ),
    );
  }
}

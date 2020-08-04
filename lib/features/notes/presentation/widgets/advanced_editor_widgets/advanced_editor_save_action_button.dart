import 'package:flutter/material.dart';

import '../../pages/markdown_editor/advanced_editor.dart';

class SaveActionButton extends StatelessWidget {
  const SaveActionButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(

        ///Das offset sorgt dafür, dass der Save Button verschwindet, wenn man
        ///die Tastatur öffnet
        offset: Offset(0.0, 5 * MediaQuery.of(context).viewInsets.bottom),
        child: FloatingActionButton(
          onPressed: () {
            AdvancedMarkDownEditor.of(context).saveNote();
          },
          elevation: 2.0,
          child: Icon(
            Icons.save,
            size: 30,
          ),
        ));
  }
}

import 'package:flutter/material.dart';

import '../../pages/markdown_editor/advanced_editor.dart';

class EditorBottomAppBarButton extends StatelessWidget {
  final String replaceStringpattern;
  final IconData icon;
  final String tooltip;
  const EditorBottomAppBarButton(
      {@required this.replaceStringpattern,
      @required this.icon,
      @required this.tooltip})
      : super();

  @override
  Widget build(BuildContext context) {
    const double _border_padding_navigation = 10;
    return Tooltip(
      message: tooltip,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(_border_padding_navigation, 0, 0, 0),
        child: IconButton(
          icon: Icon(
            icon,
            color: Theme.of(context).dividerColor,
          ),
          onPressed: () => AdvancedMarkDownEditor.of(context)
              .replaceSelection(replaceStringpattern),
        ),
      ),
    );
  }
}

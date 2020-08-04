import 'package:flutter/material.dart';

class EditorTextField extends StatelessWidget {
  final from;
  String note = "";
  EditorTextField({@required this.from, this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.5,
        child: TextFormField(
          expands: true,
          maxLines: null,
          minLines: null,
          initialValue: note,
          onChanged: (value) {
            from.input = value;
          },
          style: TextStyle(
              color: Theme.of(context).primaryTextTheme.bodyText1.color,
              fontSize: 20),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 0)),
        ),
      ),
    );
  }
}

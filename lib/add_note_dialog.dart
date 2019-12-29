import 'package:flutter/material.dart';

class AddNoteDialog extends StatefulWidget {
  const AddNoteDialog({this.note, this.noteCallBack});

  final NoteCallBack noteCallBack;
  final String note;

  @override
  _AddNoteDialogState createState() {
    return new _AddNoteDialogState(note,noteCallBack);
  }
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  TextEditingController noteEditingController = new TextEditingController();
  bool validNote = true;

  NoteCallBack noteCallBack;
  String note;

  _AddNoteDialogState(String note,NoteCallBack noteCallBack) {
    this.note = note;
    this.noteCallBack = noteCallBack;
    noteEditingController.text = note;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Note"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            textInputAction: TextInputAction.done,
            onSubmitted: onNoteSubmitted,
            autofocus: true,
            decoration: InputDecoration(
                hintText: "Note",
                errorText: validNote ? null : "Please enter Note"),
            controller: noteEditingController,
            maxLines: 3,
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('CANCEL'),
        ),
        FlatButton(
          onPressed: () => {onNoteSubmitted(noteEditingController.text)},
          child: Text('SAVE'),
        )
      ],
    );
  }

  void onNoteSubmitted(String text) {
    setState(() {
      text.isEmpty ? validNote = false : validNote = true;
      if (validNote) {
        noteCallBack(text.replaceAll("\n", " "));
        Navigator.pop(context);
      }
    });
  }
}

typedef NoteCallBack = void Function(String note);

import 'package:flutter/material.dart';

import 'note.dart';

class NoteDetailsWidget extends StatefulWidget {
  const NoteDetailsWidget({this.note, this.noteCallBack});

  final NoteCallBack noteCallBack;
  final Note note;

  @override
  _NoteDetailsWidgetState createState() {
    return new _NoteDetailsWidgetState(note, noteCallBack);
  }
}

class _NoteDetailsWidgetState extends State<NoteDetailsWidget> {
  NoteCallBack noteCallBack;
  Note note;

  _NoteDetailsWidgetState(Note note, NoteCallBack noteCallBack) {
    this.note = note;
    this.noteCallBack = noteCallBack;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _note = Note("","");
    return Scaffold(
      appBar: AppBar(
        title: note == null ? Text("Create New Note") : Text("Update a Note"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final form = _formKey.currentState;
              if (form.validate()) {
                form.save();
                noteCallBack(_note);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  initialValue: note != null ? note.title : "",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  onSaved: (value) {
                    setState(() {
                      if (value != null) {
                        _note.title = value;
                      }
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextFormField(
                    initialValue: note != null ? note.note : "",
                    textInputAction: TextInputAction.done,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter Note";
                      }
                    },
                    onSaved: (val) => setState(() => _note.note = val),
                    decoration: InputDecoration(
                      hintText: "Note",
                      hintStyle: TextStyle(color: Colors.black54),
                    ),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef NoteCallBack = void Function(Note note);

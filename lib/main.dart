import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/note_listview.dart';

import 'add_note_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          accentColor: Colors.redAccent,

          //button theme
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blue,
              shape: RoundedRectangleBorder(),
              splashColor: Colors.white,
              padding: EdgeInsets.all(4))),
      home: MyHomePage(title: 'Notes Demo By Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          NoteListView(
            items: items,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return AddNoteDialog(
                  noteCallBack: (note) {
                    items.add(note);
                    setState(() {});
                  },
                );
              });
        },
        tooltip: 'Create a Note',
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

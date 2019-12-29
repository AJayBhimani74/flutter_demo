import 'package:flutter/material.dart';
import 'package:flutter_app/note.dart';

import 'note_details.dart';


class NoteListView extends StatefulWidget {
  const NoteListView({this.items});

  final List<Note> items;

  @override
  _NoteListViewState createState() {
    return _NoteListViewState(items);
  }
}

class _NoteListViewState extends State<NoteListView> {

  final int edit = 1;
  final int delete = 2;

  List<Note> items;

  _NoteListViewState(List<Note> items) {
    this.items = items;
  }


  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'No Notes',
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
            ),
          )
        : new Expanded(
            child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: new ListView.separated(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (context) => NoteDetailsWidget(
                              note: items[index],
                              noteCallBack: (note) {
                                setState(() {
                                  items[index] = note;
                                });
                              },
                            ));
                    Navigator.push(context, route);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  items[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                new Text(
                                  items[index].note,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black87),
                                )
                              ]),
                          flex: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
            ),
          ));
  }
}

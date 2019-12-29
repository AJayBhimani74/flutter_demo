import 'package:flutter/material.dart';
import 'package:flutter_app/note.dart';
import 'package:tuple/tuple.dart';

import 'note_details.dart';
import 'main.dart';

class NoteListView extends StatefulWidget {
  const NoteListView({this.items});

  final List<Note> items;

  @override
  _NoteListViewState createState() {
    return _NoteListViewState(items);
  }
}

class _NoteListViewState extends State<NoteListView> {
  var _tapPosition;

  final int edit = 1;
  final int delete = 2;

  List<Note> items;

  _NoteListViewState(List<Note> items) {
    this.items = items;
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
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

  void openOptionsMenu(BuildContext context, int index) {
    RenderBox overlay = Overlay.of(context).context.findRenderObject();
    showMenu(
      position: RelativeRect.fromRect(
          _tapPosition & Size(20, 20),
          // smaller rect, the touch area
          Offset.zero & overlay.size // Bigger rect, the entire screen
          ),
      context: context,
      items: <PopupMenuEntry<Tuple2<int, int>>>[
        PopupMenuItem(
          value: Tuple2(edit, index),
          child: Row(
            children: <Widget>[
              Icon(Icons.edit),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Edit"),
              ),
            ],
          ),
        ),
        PopupMenuDivider(
          height: 1,
        ),
        PopupMenuItem(
          value: Tuple2(delete, index),
          child: Row(
            children: <Widget>[
              Icon(Icons.delete),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Delete"),
              ),
            ],
          ),
        )
      ],
    ).then<void>((Tuple2 data) {
      if (data == null) {
        return;
      }

      if (data.item1 == edit) {
        showDialog(
            context: context,
            builder: (_) {
              return;
            });
      }

      if (data.item1 == delete) {
        setState(() {
          items.removeAt(data.item2);
        });
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:su_task7/screens/description.dart';
import 'package:su_task7/screens/notedetail.dart';

import 'database.dart';
import 'note.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  int count = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  late List<Note> noteList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('fab clicked');
          navigateToDescription(Note('','','',''),);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              // leading: CircleAvatar(
              //   backgroundColor: getPriorityColor(this.noteList[index].priority),
              //   child: getPriorityIcon(this.noteList[index].priority),
              // ),
              title: Text(this.noteList[index].platform!,),
              subtitle: Text(this.noteList[index].username!),
              trailing: IconButton(onPressed: () {
                _delete(context, noteList[index]);
              },
                icon: Icon(Icons.delete),

              ),
              onTap: () {
                debugPrint('tapped');
                navigateToDescription(noteList[index], );
              },
            ),
          );
        }


    );
  }
  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
  void _delete(BuildContext context, Note note) async {

    int? result = await databaseHelper.deleteNote(note.time);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }
  void navigateToDescription(Note note,) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail( note: note);
    }));
    if (result == true) {
      updateListView();
    }
  }
}
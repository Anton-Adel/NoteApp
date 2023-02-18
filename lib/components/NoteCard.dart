import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Models/NoteModel.dart';
import 'package:note_app/app/notes/edit_note.dart';

import '../core/constants/linksApi.dart';


String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'wael:wael12345'));

Map<String, String> myheaders =
{
  'authorization': _basicAuth
};

class noteCard extends StatelessWidget {
  final NoteModel noteModel;
  void Function() onPressed;
   noteCard({Key? key, required this.noteModel,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

        Navigator.push(context, MaterialPageRoute(builder: (context){
          return EditNote(noteTitle: noteModel.notesTitle!, noteContent: noteModel.notesContent!, id: noteModel.notesId!,imagename: noteModel.notesImage!,);
        }));
      },
      child: Card(
        child: Row(
          children: [
           Expanded(
                flex: 1,
                child: Image(image: NetworkImage("$imagepath/${noteModel.notesImage}"),width: 100,height: 100,)),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text("${noteModel.notesTitle}"),
                subtitle: Text("${noteModel.notesContent}"),
                trailing: IconButton(onPressed: onPressed,
                icon: Icon(Icons.delete),
                ),


              ),
            )
          ],
        ),

      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/Data/data_source/DataSource.dart';
import 'package:note_app/Data/repository/Repository.dart';
import 'package:note_app/Domian/Base_Repository/base_repository.dart';
import 'package:note_app/Domian/UseCase/edit_note_usecase.dart';

import 'package:note_app/main.dart';

import '../../components/customtextform.dart';
import '../../components/httpHelper.dart';
import '../../core/constants/linksApi.dart';

class EditNote extends StatefulWidget {
  final String noteTitle;
  final String noteContent;
  final String imagename;
  final int id;

  EditNote(
      {Key? key,
      required this.noteTitle,
      required this.noteContent,
      required this.id,
      required this.imagename})
      : super(key: key);

  @override
  State<EditNote> createState() => _AddNoteState();
}

File? image;

class _AddNoteState extends State<EditNote> {
  var title = TextEditingController();
  var content = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  EditNote() async {
    if (formkey.currentState!.validate()) {
      var response;
        // response = await HttpHelper().postRequest(EDITNOTE,
        //     {
        //       "title": title.text,
        //       "content": content.text,
        //       "imagename": widget.imagename,
        //       "noteid": widget.id.toString(),
        //     }
        // );
        BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
        BaseRepository baseRepository = Repository(baseRemoteDataSource);
        response = await EditNoteUSeCase(baseRepository).call(
            uri: EDITNOTE,
            title: title.text,
            note_id: widget.id.toString(),
            content: content.text,
            image_name: widget.imagename,
            image: image);
      if (response["status"] == "success") {
        Navigator.of(context).popAndPushNamed("home");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    title.text = widget.noteTitle;
    content.text = widget.noteContent;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    customTextForm(
                      label: "title",
                      controller: title,
                    ),
                    customTextForm(
                      label: "content",
                      controller: content,
                    ),
                    MaterialButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(
                                    "Upload Image From!!!",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  alignment: Alignment.center,
                                  actions: [
                                    IconButton(
                                        onPressed: () async {
                                          XFile? xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);
                                          image = File(xfile!.path);
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.camera)),
                                    IconButton(
                                        onPressed: () async {
                                          XFile? xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                          image = File(xfile!.path);
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.menu)),
                                  ],
                                ));
                      },
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 70),
                      child: Text("upload image"),
                    ),
                    MaterialButton(
                      onPressed: () {
                        EditNote();
                      },
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        horizontal: 70,
                      ),
                      child: Text("Add"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

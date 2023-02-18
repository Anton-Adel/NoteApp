import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/Data/data_source/DataSource.dart';
import 'package:note_app/Data/repository/Repository.dart';
import 'package:note_app/Domian/Base_Repository/base_repository.dart';
import 'package:note_app/Domian/UseCase/add_note_usecase.dart';

import 'package:note_app/main.dart';

import '../../components/customtextform.dart';
import '../../components/httpHelper.dart';
import '../../core/constants/linksApi.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}
File? image;
class _AddNoteState extends State<AddNote> {
  var title = TextEditingController();
  var content = TextEditingController();
  GlobalKey<FormState> formkey= GlobalKey<FormState>();

  AddNote()async
  {
    if (image == null) {
      return AwesomeDialog(
          context: context, title: "error", body: Text("there is no image"))
        ..show();
    }
    if (formkey.currentState!.validate()) {
      BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
      BaseRepository baseRepository = Repository(baseRemoteDataSource);
       var response= await AddNoteUseCase(baseRepository).call(
          uri: ADDNOTE, title: title.text, content: content.text, image: image!); // عايز ابقي ارجع ال responce  علشان اعمل check عليه

     // print(responce);
      if(response["status"]=="success")
        {


          image=null;
          Navigator.of(context).popAndPushNamed("home");
        }
      //   var response =await HttpHelper().postWithImage(ADDNOTE,
      //       {
      //         "title":title.text,
      //         "content":content.text,
      //         "userid":preferences.getString("id"),
      //       },
      //     image!
      //   );
      //   if(response["status"]=="success")
      //   {
      //
      //
      //     image=null;
      //     Navigator.of(context).popAndPushNamed("home");
      //   }
      //
      // }
    }
  }
  @override
  Widget build(BuildContext context) {
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
                    customTextForm(label: "title",controller: title,),
                    customTextForm(label: "content",controller: content,),
                    MaterialButton(onPressed: (){
                      showDialog(context: context, builder: (context)=>AlertDialog(
                        title: Text("Upload Image From!!!",style: TextStyle(fontSize: 20),),
                        alignment: Alignment.center,
                        actions: [

                          IconButton(onPressed: ()async{
                            XFile? xfile= await ImagePicker().pickImage(source: ImageSource.camera);
                            image=File(xfile!.path);
                            Navigator.pop(context);

                          }, icon: Icon(Icons.camera)),

                          IconButton(onPressed: ()async{
                      XFile? xfile= await ImagePicker().pickImage(source: ImageSource.gallery);
                      image=File(xfile!.path);
                      Navigator.pop(context);


                          }, icon: Icon(Icons.menu)),

                        ],
                      ));
                    },
                      color: Colors.blue,

                      padding: EdgeInsets.symmetric(horizontal:70 ),
                      child: Text("upload image"),

                    ),
                    MaterialButton(onPressed: (){
                      AddNote();
                    },
                      color: Colors.blue,

                      padding: EdgeInsets.symmetric(horizontal:70, ),
                      child: Text("Add"),

                    ),


                  ],
                ),
              ),
            ),

          ),
        ),
      ),
    )  ;
  }
}




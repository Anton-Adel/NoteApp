import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Data/data_source/DataSource.dart';
import 'package:note_app/Data/repository/Repository.dart';
import 'package:note_app/Domian/Base_Repository/base_repository.dart';
import 'package:note_app/Domian/UseCase/view_notes_usecase.dart';
import 'package:note_app/Models/NoteModel.dart';
import 'package:note_app/components/NoteCard.dart';
import 'package:note_app/components/httpHelper.dart';

import 'package:note_app/main.dart';

import '../core/constants/linksApi.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  getNotes() async
  {
    BaseRemoteDataSource baseRemoteDataSource=RemoteDataSource();
    BaseRepository baseRepository =Repository(baseRemoteDataSource);
    var response = await ViewNotesUseCase(baseRepository).call(uri: ViewNote);
    return response;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
        actions: [
          IconButton(onPressed: (){
            preferences.clear();
            Navigator.of(context).pushReplacementNamed("login");

          }, icon: Icon(Icons.exit_to_app))
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("addnote");
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            FutureBuilder(
                future: getNotes(),
                builder: (context,AsyncSnapshot snapshot)
            {
              if(snapshot.hasData)
                {
                  if (snapshot.data['status']=="fail")
                    {
                      return Center(child: Text("there is no notes"),);
                    }
                  return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  itemBuilder: (context,index)
                  {
                    return //Text( "${snapshot.data["data"][index]["notes_title"]}");
                      noteCard(
                       noteModel: NoteModel.fromJson(snapshot.data["data"][index]),
                      onPressed: ()async{
                        var response =await await HttpHelper().postRequest(DeleteNote,
                            {
                              "noteid":snapshot.data["data"][index]["notes_id"].toString(),
                              "imagename":snapshot.data["data"][index]["notes_image"].toString()
                            });
                        if(response["status"]=="success")
                          {
                            setState(() {

                            });
                          }
                      },
                      );
                  },
                    itemCount: snapshot.data['data'].length,
                  );
                }
              if(snapshot.connectionState==ConnectionState.waiting)
                {
                  return Center(child: Text("LOADING......"));
                }
              return Center(child: Text("LOADING......"));

            })
          ],
        ),
      ),
    );
  }
}

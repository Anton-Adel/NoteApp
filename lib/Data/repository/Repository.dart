import 'dart:io';

import 'package:note_app/Data/data_source/DataSource.dart';
import 'package:note_app/Data/model/note_model.dart';
import 'package:note_app/Domian/Base_Repository/base_repository.dart';
import 'package:note_app/Domian/Entity/Note.dart';
import 'package:note_app/Domian/Entity/User.dart';

import '../../main.dart';
import '../model/user_model.dart';

class Repository extends BaseRepository
{
  BaseRemoteDataSource baseRemoteDataSource;

  Repository(this.baseRemoteDataSource);

  @override
  Future<User> Login({required String uri,required String email, required String password}) async {

    var response=  await baseRemoteDataSource.postRequest(uri,
    {
      "email":email,
      "password":password,
    }
    );
    print("esalm");
    print(response);
    return UserModel.fromJson(response["data"]);
  }

  @override
  void Register({required String uri,required String email, required String password, required String userName}) {
    baseRemoteDataSource.postRequest(uri,
    {
      "username": userName,
      "email":email,
      "password":password
    }
    );
  }

  @override
  Future addNote({required String uri, required String title, required String content, required File image})
  {
    return baseRemoteDataSource.postWithImage(uri,{
      "title":title,
      "content":content,
      "userid":preferences.getString("id"),
    },
        image);
    print("add done");
  }

  @override
  Future EditNote({required String uri, required String note_id,required String title, required String content, required String image_name,  File? image}) async{
   if (image==null)
     {
       print("Innnnnnn");
       return await baseRemoteDataSource.postRequest(uri, {
         "title": title,
         "content": content,
         "imagename": image_name,
         "noteid": note_id,
       });
     }
   else
     {
       return await baseRemoteDataSource.postWithImage(uri, {
         "title": title,
         "content": content,
         "imagename": image_name,
         "noteid": note_id,
       }, image);
     }
  }

  @override
  Future ViewNotes({required String uri}) async{
    var responce = await baseRemoteDataSource.postRequest(uri,
    {
      "userid":preferences.getString("id"),
    }
    );
    print("Eslaaaaaaaaaaaaaaaaaaaaaam");
    print(responce);
    return responce;

  }

}
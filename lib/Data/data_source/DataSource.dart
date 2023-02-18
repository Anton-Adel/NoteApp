import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:note_app/Data/model/user_model.dart';

import '../../components/NoteCard.dart';
abstract class BaseRemoteDataSource
{
  getRequest(String uri);
  postRequest(String uri,Map data);
  postWithImage(String uri,Map data,File file);
}

class RemoteDataSource extends BaseRemoteDataSource
{
  @override
  getRequest(String uri) async
  {

    try
    {
      var response = await http.get(Uri.parse(uri));
      if(response.statusCode==200)
      {
        print("http helper $response");
        var responseJson=jsonDecode(response.body);
        return responseJson;
      }
      else
      {
        print("error ${response.statusCode}");
      }

    }
    catch(e)
    {
      print("catch error $e");
    }

  }

  @override
  postRequest(String uri, Map data) async {
    try
    {
      var response = await http.post(Uri.parse(uri),body: data,headers: myheaders);
      if(response.statusCode==200)
      {
        print("Anton");
        print("http helper $response");
        var responseJson=jsonDecode(response.body);
        print("http helper2 $responseJson");
        return responseJson;
      }
      else
      {
        print("error ${response.statusCode}");
      }

    }
    catch(e)
    {
      print("catch error $e");
    }
  }

  @override
  postWithImage(String uri, Map data, File file) async{
    //print("innnnn");
    var request= http.MultipartRequest("POST",Uri.parse(uri));
    var lenght=await file.length();
    var stream=http.ByteStream(file.openRead());
    request.headers.addAll(myheaders);
    //print("brfor");
    var multipartfile= http.MultipartFile("file",stream,lenght,filename: Uri.file(file.path).pathSegments.last);
// another way to get image name        basename(file.path);
    request.files.add(multipartfile);

    data.forEach((key, value) {
      print(key);
      request.fields[key]=value;
    });


    var myResponse= await request.send();
    var response= await http.Response.fromStream(myResponse);
    if(myResponse.statusCode==200)
    {
      print("done");
      return jsonDecode(response.body);

    }
    else
    {
      print ("error im request with image");
    }
  }
  }



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Data/data_source/DataSource.dart';
import 'package:note_app/Data/repository/Repository.dart';
import 'package:note_app/Domian/Base_Repository/base_repository.dart';
import 'package:note_app/Domian/UseCase/register_usecase.dart';
import 'package:note_app/components/httpHelper.dart';


import '../../components/customtextform.dart';
import '../../core/constants/linksApi.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _loginState();
}

class _loginState extends State<signup> {
  var username=TextEditingController();
  var email=TextEditingController();
  var password=TextEditingController();
  GlobalKey<FormState> formkey= GlobalKey();

  signUp()async
  {
    if(formkey.currentState!.validate())
      {
        BaseRemoteDataSource baseRemoteDataSource= RemoteDataSource();
        BaseRepository baseRepository= Repository(baseRemoteDataSource);
        RegisterUseCase(baseRepository).call(uri: SIGNUP, email: email.text, password: password.text, userName: username.text);
        // var response =await HttpHelper().postRequest(SIGNUP,
        //     {
        //       "username": username.text,
        //       "email":email.text,
        //       "password":password.text
        //     }
        // );
        // if(response["status"]=="success")
        // {
        //
        //   Navigator.of(context).popAndPushNamed("login");
        // }
        // else
        // {
        //   print("signup fail");
        // }
      }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                    Image.asset("assets/images/login.png",width: 200,height: 200,),
                    SizedBox(
                      height: 15,
                    ),
                    customTextForm(label: "Username",controller: username,),

                    customTextForm(label: "Email",controller: email,),
                    customTextForm(label: "password",controller: password,),
                    MaterialButton(onPressed: ()async{

                      await signUp();

                    },
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal:70, ),
                      child: Text("SignUp"),

                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed("login");
                      },
                      child: Text("SignUp"),
                    )


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

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/Data/data_source/DataSource.dart';
import 'package:note_app/Domian/Base_Repository/base_repository.dart';
import 'package:note_app/Domian/Entity/User.dart';
import 'package:note_app/Domian/UseCase/login_usecase.dart';
import 'package:note_app/Presentaion/Controller/note_bloc.dart';
import 'package:note_app/Presentaion/Controller/note_event.dart';
import 'package:note_app/Presentaion/Controller/note_state.dart';
import 'package:note_app/core/constants/request_state.dart';

import 'package:note_app/main.dart';

import '../../Data/repository/Repository.dart';
import '../../components/customtextform.dart';
import '../../components/httpHelper.dart';
import '../../core/constants/linksApi.dart';
import '../../core/sever_locator/ServesLocator.dart';

class login extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
    // BaseRepository baseRepository = Repository(baseRemoteDataSource);
    return BlocProvider(
      create: (BuildContext context)  => sl<NoteBloc>(),
      child: BlocConsumer<NoteBloc, NoteState>(
        listener: (context,state)
        {
          if(state.requestState_login==RequestState.loaded)
            {
              print("Anton Adel Bymassssssy");
              preferences.setString("id", state.user_login!.id.toString());
              Navigator.of(context).pushReplacementNamed("home");
            }

        },
        buildWhen: (previous, current) => previous.requestState_login!=current.requestState_login,
        builder: (context, state)
    {
      NoteBloc noteBloc = BlocProvider.of(context);
      print("Anton Adel Bymassssssy");
      print(state.requestState_login);
      switch (state.requestState_login) {
        case RequestState.loaded:

          return Center(child: CircularProgressIndicator());

        case RequestState.loading:
          return Scaffold(
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
                          Image.asset("assets/images/login.png", width: 200,
                            height: 200,),
                          SizedBox(
                            height: 15,
                          ),
                          customTextForm(label: "Email", controller: email,),
                          customTextForm(
                            label: "password", controller: password,),
                          MaterialButton(onPressed: () {
                            noteBloc.add(LoginEvent(
                                email: email.text, password: password.text));
                          },
                            color: Colors.blue,
                            padding: EdgeInsets.symmetric(horizontal: 70,),
                            child: Text("Login"),

                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("signup");
                            },
                            child: Text("signUp"),
                          )

                        ],
                      ),
                    ),
                  ),

                ),
              ),
            ),

          );
        case RequestState.error:
          return CircularProgressIndicator();


      }

        },
      ),
    );
  }

}

//


import 'package:flutter/material.dart';
import 'package:note_app/app/auth/signup.dart';
import 'package:note_app/app/home.dart';
import 'package:note_app/app/notes/edit_note.dart';
import 'package:note_app/core/sever_locator/ServesLocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Presentaion/Screens/login.dart';
import 'app/notes/add_note.dart';

late SharedPreferences preferences;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.init();
  preferences=await SharedPreferences.getInstance();
  print(preferences.getString("id"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),

        initialRoute: preferences.getString("id")==null?"login":"home",
        routes:
        {
          "login": (context) => login(),
          "signup": (context) => signup(),
          "home": (context) => home(),
          "addnote": (context) => AddNote(),
          //"editnote": (context) => EditNote(noteTitle: "", noteContent: "", id:0 ),
        },



    );
  }
}

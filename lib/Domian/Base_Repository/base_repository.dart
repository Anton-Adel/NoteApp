import 'dart:io';

import 'package:note_app/Domian/Entity/Note.dart';
import 'package:note_app/app/notes/edit_note.dart';

import '../Entity/User.dart';

abstract class BaseRepository
{
  Future<User> Login ({required String uri,required String email,required String password});

  void Register ({required String uri,required String email,required String password,required String userName}); //// ممكن تتعدل

 Future addNote({required String uri,required String title,required String content,required File image});

  Future EditNote({required String uri,required String note_id,required String title,required String content,required String image_name, File? image});
  Future  ViewNotes({required String uri});



}
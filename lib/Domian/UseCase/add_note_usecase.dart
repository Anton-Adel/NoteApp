import 'dart:io';

import 'package:note_app/Domian/Base_Repository/base_repository.dart';

class AddNoteUseCase
{

  BaseRepository baseRepository;

  AddNoteUseCase(this.baseRepository);
  Future call ({required String uri,required String title,required String content,required File image})
  async{
   return await baseRepository.addNote(uri: uri, title: title, content: content, image: image);
  }
}
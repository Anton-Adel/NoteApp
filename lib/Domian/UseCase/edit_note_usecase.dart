import 'dart:io';

import 'package:note_app/Domian/Base_Repository/base_repository.dart';

class EditNoteUSeCase
{
  BaseRepository baseRepository;

  EditNoteUSeCase(this.baseRepository);

  Future call ({required String uri,required String title,required String note_id,required String content,required String image_name, File? image})
  async{
    print("in usecase");
    return await baseRepository.EditNote(uri: uri, title: title,note_id: note_id, content: content,image_name: image_name, image: image);
  }
}
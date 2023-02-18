import 'package:note_app/Domian/Entity/Note.dart';

class NoteModel extends Note_ {
  NoteModel({required super.notesId,
    required super.notesTitle,
    required super.notesContent,
    required super.notesImage,
    required super.notesUsers});

  factory NoteModel.fromJson(Map<String, dynamic> json)=>
      NoteModel(
          notesId : json['notes_id'].toString(),
          notesTitle : json['notes_title'].toString(),
          notesContent : json['notes_content'].toString(),
      notesImage : json['notes_image'].toString(),
      notesUsers : json['notes_users'].toString(),
      );
}

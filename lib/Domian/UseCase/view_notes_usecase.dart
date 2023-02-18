import 'package:note_app/Domian/Base_Repository/base_repository.dart';

import '../Entity/Note.dart';

class ViewNotesUseCase
{
  BaseRepository baseRepository;

  ViewNotesUseCase(this.baseRepository);

  Future call ({required String uri}) async
  {
    return await baseRepository.ViewNotes(uri: uri);

  }
}
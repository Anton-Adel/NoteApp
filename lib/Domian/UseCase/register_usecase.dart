import 'package:note_app/Domian/Base_Repository/base_repository.dart';

import '../Entity/User.dart';

class RegisterUseCase
{
  final BaseRepository baseRepository;

  RegisterUseCase(this.baseRepository);

  void call ({required String uri,required String email,required String password,required String userName})
  {
    baseRepository.Register(uri: uri,email: email, password: password,userName: userName);
  }

}
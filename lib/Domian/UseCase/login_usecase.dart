import 'package:note_app/Domian/Base_Repository/base_repository.dart';

import '../Entity/User.dart';

class LoginUseCase
{
 final BaseRepository baseRepository;

 LoginUseCase(this.baseRepository);

 Future<User> call ({required String uri,required String email,required String password}) async
 {
   return await baseRepository.Login(uri: uri,email: email, password: password);

 }

}
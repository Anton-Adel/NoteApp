
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/Domian/UseCase/login_usecase.dart';
import 'package:note_app/Presentaion/Controller/note_event.dart';
import 'package:note_app/Presentaion/Controller/note_state.dart';
import 'package:note_app/core/constants/linksApi.dart';
import 'package:note_app/core/constants/request_state.dart';

import '../../main.dart';

class NoteBloc extends Bloc<BaseNoteEvent,NoteState>
{

  final LoginUseCase loginUseCase;
  NoteBloc(this.loginUseCase):super(NoteState()) {

    on<LoginEvent>((event, emit) 
    async {
      print("in event");
       var responce=await loginUseCase.call(uri: LOGIN, email: event.email, password: event.password);
       print("Emit now");
       print(responce);
      //preferences.setString("id", responce.id);

      return emit(state.copyWith(user_login: responce,requestState_login: RequestState.loaded));

     }
    );
  }

}
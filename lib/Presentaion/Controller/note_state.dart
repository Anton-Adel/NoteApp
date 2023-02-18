import 'package:equatable/equatable.dart';
import 'package:note_app/core/constants/request_state.dart';

import '../../Domian/Entity/User.dart';

class NoteState extends Equatable {
  final User? user_login;
  final String errorMessage_login;
  final RequestState requestState_login;

  NoteState({this.user_login, this.errorMessage_login="", this.requestState_login=RequestState.loading});

  @override

  List<Object?> get props => [user_login,errorMessage_login,requestState_login];

  NoteState copyWith(
  {
    User? user_login,
     String? errorMessage_login,
     RequestState? requestState_login,

  }
)

  {
  return NoteState(
    user_login: user_login??this.user_login,
     errorMessage_login:  errorMessage_login??this.errorMessage_login,
     requestState_login:  requestState_login?? this.requestState_login
  );
}
}

import 'package:equatable/equatable.dart';

abstract class BaseNoteEvent extends Equatable
{

  BaseNoteEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginEvent extends BaseNoteEvent
{
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends BaseNoteEvent
{
}
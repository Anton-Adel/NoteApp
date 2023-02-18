import 'package:equatable/equatable.dart';

class Note_ extends Equatable {
  String? notesId;
  String? notesTitle;
  String? notesContent;
  String? notesImage;
  String? notesUsers;

  Note_(
      {required this.notesId,
       required this.notesTitle,
       required this.notesContent,
        required this.notesImage,
        required this.notesUsers});

  @override
  // TODO: implement props
  List<Object?> get props => [notesUsers,notesTitle,notesContent,notesImage,notesId];
}
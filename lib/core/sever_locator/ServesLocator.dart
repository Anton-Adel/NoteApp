
import 'package:get_it/get_it.dart';
import 'package:note_app/Data/data_source/DataSource.dart';
import 'package:note_app/Data/repository/Repository.dart';
import 'package:note_app/Domian/Base_Repository/base_repository.dart';
import 'package:note_app/Domian/UseCase/login_usecase.dart';
import 'package:note_app/Presentaion/Controller/note_bloc.dart';

final GetIt sl = GetIt.instance;

class ServiceLocator
{
  static void init()
  {

    sl.registerFactory(() => NoteBloc(sl()));


    sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
    sl.registerLazySingleton<BaseRepository>(() => Repository(sl()));
    sl.registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource());



  }
}
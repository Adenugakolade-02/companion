import 'package:caution_companion/services/http_service.dart';
import 'package:caution_companion/services/navigator_service.dart';
import 'package:caution_companion/services/storage_service.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator(){
  serviceLocator.registerLazySingleton(() => NavigatorService());
  serviceLocator.registerLazySingleton(() => StorageService());
  serviceLocator.registerLazySingleton(() => HttpService());
}

import 'package:caution_companion/pages/authentication/auth_view_model.dart';
import 'package:caution_companion/pages/map/map_view_model.dart';

import 'package:caution_companion/services/navigator_service.dart';
import 'package:caution_companion/services/storage_service.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator(){
  // Registering services
  serviceLocator.registerLazySingleton(() => NavigatorService());
  serviceLocator.registerLazySingleton(() => StorageService());
  // serviceLocator.registerLazySingleton(() => HttpService());


  // registering models
  serviceLocator.registerLazySingleton(() => AuthViewModel());
  serviceLocator.registerLazySingleton(() => MapViewModel());


}

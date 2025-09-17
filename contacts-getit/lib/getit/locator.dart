import 'package:get_it/get_it.dart';
import './contacts_service.dart';


final GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton<ContactService>(() => ContactService());

}
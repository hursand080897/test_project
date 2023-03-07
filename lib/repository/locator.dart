import 'package:get_it/get_it.dart';
import 'package:project/repository/internet_connection.dart';
import 'package:project/repository/remote_config_service.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.registerLazySingleton<RemmoteConfigService>(
      () => RemmoteConfigService());
  locator.registerLazySingleton<InternetConnection>(() => InternetConnection());
}

import 'package:get_it/get_it.dart';
import 'package:sport/repository/internet_connection.dart';
import 'package:sport/repository/push.dart';
import 'package:sport/repository/remote_config_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<RemmoteConfigService>(
      () => RemmoteConfigService());
  locator.registerLazySingleton<InternetConnection>(() => InternetConnection());

  locator.registerLazySingleton<PushNotification>(() => PushNotification());
}

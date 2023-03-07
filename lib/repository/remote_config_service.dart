import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemmoteConfigService {
  Future<FirebaseRemoteConfig> getInstance() async {
    await Firebase.initializeApp();
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 10),
      minimumFetchInterval: const Duration(minutes: 0),
    ));
    await remoteConfig.setDefaults(<String, dynamic>{'my_url': ''});
    RemoteConfigValue(null, ValueSource.valueStatic);
    bool updated = await remoteConfig.fetchAndActivate();
    if (updated) {
      // ignore: avoid_print
      print('updated ${remoteConfig.getString('my_url')}');
    } else {
      // ignore: avoid_print
      print('no update ${remoteConfig.getString('my_url')}');
    }
    return remoteConfig;
  }
}

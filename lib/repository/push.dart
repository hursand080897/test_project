import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotification {
  Future<bool> sendPush() async {
    try {
      await OneSignal.shared.promptUserForPushNotificationPermission();
      await OneSignal.shared.setAppId("a83456ff-b1ef-4815-9b0a-499086fc1450");
      print('sended push');
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }
}

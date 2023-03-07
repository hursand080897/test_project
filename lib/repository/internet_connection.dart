import 'dart:io';

class InternetConnection {
  Future<bool> internetConnectivity() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}

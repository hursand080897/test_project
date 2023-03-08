import 'package:bloc/bloc.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:sport/repository/internet_connection.dart';
import 'package:sport/repository/locator.dart';
import 'package:safe_device/safe_device.dart';
import 'package:sport/repository/push.dart';

import '../../DB/db.dart';
import '../../repository/remote_config_service.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<CartFetchEvent>(_incFetch);
  }
  _incFetch(CartFetchEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(connection: true, loading: true));
    bool status =
        await locator.get<InternetConnection>().internetConnectivity();
    if (status) {
      emit(state.copyWith(connection: true, loading: true));
      final data = await DatabaseHelper.getUrl();
      List<Map<String, dynamic>> myData = data;
      if (myData.isNotEmpty) {
        String myurl = myData[0]['my_url'].toString();
        print('Db $myurl');
        //   myurl = "https://www.google.com/";
        final bool isPlug = await checkEmu(myurl);
        emit(state.copyWith(
          url: myurl,
          plug: isPlug,
          loading: false,
        ));
      } else {
        final FirebaseRemoteConfig remoteConfig =
            await locator.get<RemmoteConfigService>().getInstance();
        String myurl = remoteConfig.getString('url');
        print('Fb $myurl');
        //   myurl = "https://www.google.com/";
        final bool isPlug = await checkEmu(myurl);
        if (!isPlug) await DatabaseHelper.addUrl(myurl);
        emit(state.copyWith(url: myurl, plug: isPlug, loading: false));
      }
    } else {
      emit(state.copyWith(connection: false, loading: false));
    }
  }

  checkEmu(String url) async {
    bool isRealDevice = await SafeDevice.isRealDevice;
    if (url == '' || !isRealDevice) {
      return true;
    } else {
      await locator.get<PushNotification>().sendPush();
      return false;
    }
  }
}

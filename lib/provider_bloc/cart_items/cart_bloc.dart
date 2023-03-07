import 'package:bloc/bloc.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:project/repository/internet_connection.dart';
import 'package:project/repository/locator.dart';
import 'package:safe_device/safe_device.dart';

import '../../DB/db.dart';
import '../../repository/remote_config_service.dart';
import 'package:project/values/constants.dart' as Constants;
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
      if (myData.isEmpty) {
        String myurl = myData[0]['my_url'].toString();
        final bool isPlug = await checkEmu(myurl);
        print(isPlug);
        emit(state.copyWith(
          url: myData[0]['my_url'].toString(),
          plug: isPlug,
          loading: false,
        ));
        Constants.url = myData[0]['my_url'].toString();
      } else {
        print('url');
        final FirebaseRemoteConfig remoteConfig =
            await locator.get<RemmoteConfigService>().getInstance();
        String myurl = remoteConfig.getString('my_url');
        final bool isPlug = await checkEmu(myurl);
        print(myurl);
        print(isPlug);
        emit(state.copyWith(url: myurl, plug: isPlug, loading: false));
        await DatabaseHelper.clearUrl();
        await DatabaseHelper.addUrl(myurl);
      }
    } else {
      emit(state.copyWith(connection: false, loading: false));
    }
  }

  checkEmu(String url) async {
    bool isRealDevice = await SafeDevice.isRealDevice;
    if (url == '' || !isRealDevice) return true;
    return false;
  }
}

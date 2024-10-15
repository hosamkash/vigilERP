import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'connectivity_event.dart';

part 'connectivity_state.dart';

class connectivity_Bloc extends Bloc<connectivity_Event, connectivity_State> {
  StreamSubscription<List<ConnectivityResult>>? subscription;

  connectivity_Bloc() : super(connected_StateInitial()) {
    on<connectivity_Event>((event, emit) {
      if (event is connected_Event) {
        emit(connected_State(message: 'تم الإتصال بالإنترنت'));
      } else if (event is notConnected_Event) {
        emit(notConnected_State(message: 'تم قطع الإتصال بالإنترنت'));
      }
    });

    // Subscribe to connectivity changes
    subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> connResults) {
      if (connResults.any((result) {
        return result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet ||
          result == ConnectivityResult.mobile;
      })) {
        add(connected_Event());
      } else {
        add(notConnected_Event());
      }
    });

    // @override
    // Future<void> close() {
    //   subscription!.cancel();
    //   return super.close();
    // }
  }
}

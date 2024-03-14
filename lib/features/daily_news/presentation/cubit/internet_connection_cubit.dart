import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:newsapp/core/enums/connection_type.dart';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  final Connectivity? connectivity;
  StreamSubscription? _connectivityStreamSubscription;

  InternetConnectionCubit({this.connectivity})
      : super(InternetConnectionLoading()) {
    listenToInternetConnection();
  }

  StreamSubscription<ConnectivityResult> listenToInternetConnection() {
    return _connectivityStreamSubscription =
        connectivity!.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnectionConnected(ConnectionType.wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnectionConnected(ConnectionType.mobile);
      } else {
        emitInternetConnectionDisconnected();
      }
    });
  }

  void emitInternetConnectionDisconnected() {
    emit(InternetConnectionDisconnected());
  }

  void emitInternetConnectionConnected(ConnectionType connectionType) {
    emit(InternetConnectionConnected(connectionType: connectionType));
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription?.cancel();
    return super.close();
  }
}

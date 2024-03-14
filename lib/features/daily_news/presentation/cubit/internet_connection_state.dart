part of 'internet_connection_cubit.dart';

class InternetConnectionState extends Equatable {
  const InternetConnectionState();

  @override
  List<Object> get props => [];
}

final class InternetConnectionLoading extends InternetConnectionState {}

final class InternetConnectionConnected extends InternetConnectionState {
  final ConnectionType connectionType;
  const InternetConnectionConnected({required this.connectionType});

  @override
  String toString() {
    return 'InternetConnectionConnected { connectionType: $connectionType }';
  }
}

final class InternetConnectionDisconnected extends InternetConnectionState {
  
}

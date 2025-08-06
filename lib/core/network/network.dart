import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();

 @override
Future<bool> get isConnected async {
  final results = await Connectivity().checkConnectivity();

  // Check if at least one of the connection types is WiFi or mobile
  return results.any(
    (result) =>
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi,
  );
}

}

import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

enum ConnectivityStatus { WiFi, Cellular, Offline }

abstract class ConnectivityService {
  Future<bool> get isConnected;
}

class ConnectivityServiceImpl implements ConnectivityService {
  @override
  Future<bool> get isConnected => _isConnected();

  Future<bool> _isConnected() async {
    return await (Connectivity().checkConnectivity()).then(
        (connectivityResult) =>
            connectivityResult == ConnectivityResult.none ? false : true);
  }
}

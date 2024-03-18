import 'package:google_docs_clone/config/app_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  static SocketClient? _instance;
  IO.Socket? socket;

  // Private constructor
  SocketClient._internal() {
    socket = IO.io(AppConfig.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket?.onConnect((_) => print('connect: ${socket?.id}'));
    socket?.onDisconnect((_) => print('disconnect'));
    socket?.onConnectError((data) => print('SOCKET Error - $data'));
    socket?.onConnectTimeout((data) => print('SOCKET TIMEOUT - $data'));
  }

  // Getter to access the instance of the socket
  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }

  // Connect to the server
  Future<void> connect({
    Function()? onConnect,
    Function(dynamic)? onConnectError,
    Function(dynamic)? onConnectTimeout,
  }) async {
    socket?.onConnect((_) => onConnect?.call());
    socket?.onConnectError((data) => onConnectError?.call(data));
    socket?.onConnectTimeout((data) => onConnectTimeout?.call(data));
    socket?.connect();
  }

  // Send data to the server
  void send(String event, dynamic message) {
    socket?.emit(event, message);
  }

  // Listen to the server
  void listen(String event, Function(dynamic) callback) {
    socket?.on(event, (data) => callback(data));
  }

  // Close the socket connection
  void close() {
    socket?.dispose();
  }
}

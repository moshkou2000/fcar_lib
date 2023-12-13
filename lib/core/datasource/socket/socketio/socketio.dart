import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../utility/logger.dart';
import '../socket.dart';
import '../socket.enum.dart';

/// [setup] the socket in the highest level.
///
/// do not forget to call [dispose]
///
/// Example
///   final ISocket socket = Socketio(socketUrl: Flavor.socketUrl);
///   socket.setup(
///     SocketUrl.bidding,
///     onConnect: (d) {},
///     onError: (d) {},
///     onReconnect: (d) {},
///     onReconnecting: (d) {},
///     onDisconnect: (d) {},
///   );
///
class Socketio extends ISocket {
  static Socketio? _singleton;
  factory Socketio({required String socketUrl}) {
    _singleton ??= Socketio._internal(socketUrl: socketUrl);
    return _singleton!;
  }
  Socketio._internal({required String socketUrl}) : super(socketUrl: socketUrl);

  IO.Socket? _socket;

  @override
  void dispose() {
    _socket?.disconnect();
    _socket?.dispose();
  }

  @override
  void setup({
    required dynamic Function(dynamic) onConnect,
    required dynamic Function(dynamic) onError,
    dynamic Function(dynamic)? onReconnect,
    dynamic Function(dynamic)? onReconnecting,
    dynamic Function(dynamic)? onDisconnect,
  }) async {
    _socket = IO.io(socketUrl, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    _socket?.connect();

    _socket?.onConnect(onConnect);
    _socket?.onError(onError);
    if (onReconnect != null) _socket?.onReconnect(onReconnect);
    if (onReconnecting != null) _socket?.onReconnecting(onReconnecting);
    if (onDisconnect != null) _socket?.onDisconnect(onDisconnect);
  }

  @override
  void clearListeners() {
    _socket?.clearListeners();
  }

  @override
  void connect() {
    _socket?.connect();
  }

  @override
  void subscribe(
    SocketEvent event, {
    required dynamic Function(dynamic) handler,
  }) {
    _socket?.on(event.name, handler);
  }

  @override
  void unsubscribe(
    SocketEvent event, {
    required dynamic Function(dynamic) handler,
  }) {
    _socket?.off(event.name, handler);
  }

  @override
  void emit(
    SocketEvent event, {
    required Map<String, dynamic> body,
  }) {
    if (_socket?.connected == true) {
      _socket?.emit(event.name, body);
    } else {
      logger.warning('Socketio.emit: socket is not connected!!!');
    }
  }
}

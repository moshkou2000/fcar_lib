import 'socket.enum.dart';

/// All Socets that used as provider must implement [ISocket]
///
/// Here is an example [body] argument of [sendMessage]
/// {
///   'message': message,
///   'senderId': userId,
///   'receiverId': receiverId,
///   'time': DateTime.now().millisecondsSinceEpoch,
/// }
///
///
abstract class ISocket {
  // ex: socketUrl = SocketUrl.bidding
  String socketUrl;
  ISocket({required this.socketUrl});

  /// disconnect/close & dispose
  void dispose();

  /// Default event listeners
  void setup({
    required dynamic Function(dynamic) onConnect,
    required dynamic Function(dynamic) onError,
    dynamic Function(dynamic)? onReconnect,
    dynamic Function(dynamic)? onReconnecting,
    dynamic Function(dynamic)? onDisconnect,
  });

  /// This function unbinds all the handlers for all the events.
  void clearListeners();

  /// This function calls to open socket connection
  void connect();

  /// This function binds the [handler] as a listener to the [event]
  void subscribe(
    SocketEvent event, {
    required dynamic Function(dynamic) handler,
  });

  /// This function attempts to unbind the [handler] from the [event]
  void unsubscribe(
    SocketEvent event, {
    required dynamic Function(dynamic) handler,
  });

  /// Emits to this client.
  /// make sure the socket is connected before emit
  void emit(
    SocketEvent event, {
    required Map<String, dynamic> body,
  });
}

import 'dart:io';
import 'package:flutter/foundation.dart';


class WebSocketService {
  final void Function(dynamic message) onData;
  final VoidCallback onConnected;
  final VoidCallback onDisconnected;
  WebSocket? _socket;

  WebSocketService({
    required this.onData,
    required this.onConnected,
    required this.onDisconnected,
  });

  void connect() async {
    try {
     _socket = await WebSocket.connect('ws://10.0.2.2:8080/ws');
      onConnected();

      _socket!.listen(
        onData,
        onDone: _handleDisconnect,
        onError: (_) => _handleDisconnect(),
      );
    } catch (_) {
      onDisconnected();
    }
  }

  void _handleDisconnect() {
    _socket = null;
    onDisconnected();
  }
}

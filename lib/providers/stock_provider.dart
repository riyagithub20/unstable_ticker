import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../services/websocket_service.dart';

enum ConnectionStatus { connecting, connected, reconnecting, disconnected }

class StockProvider extends ChangeNotifier {
  final Map<String, Stock> _stocks = {};
  ConnectionStatus status = ConnectionStatus.connecting;
  late WebSocketService _socketService;
  int _reconnectAttempts = 0;

  StockProvider() {
    _socketService = WebSocketService(
      onData: _handleData,
      onConnected: () {
        status = ConnectionStatus.connected;
        _reconnectAttempts = 0;
        notifyListeners();
      },
      onDisconnected: _reconnect,
    );
    _socketService.connect();
  }

  List<Stock> get stocks => _stocks.values.toList();

void _handleData(dynamic message) {
  if (message is! String) return; // Guard against non-string messages

  try {
    final decoded = jsonDecode(message);
    if (decoded is! List) return;

    for (var item in decoded) {
      final ticker = item['ticker'];
      final price = double.tryParse(item['price'] ?? '');

      if (ticker != null && price != null) {
        final previousPrice = _stocks[ticker]?.price ?? price;
        final isAnomaly = _detectAnomaly(ticker, price, previousPrice);

        _stocks[ticker] = Stock(
          ticker: ticker,
          price: price,
          previousPrice: previousPrice,
          hasAnomaly: isAnomaly,
        );
      }
    }
    notifyListeners();
  } catch (_) {
    // Discard malformed JSON
  }
}

  bool _detectAnomaly(String ticker, double newPrice, double oldPrice) {
    if (ticker == "GOOG" && newPrice < oldPrice * 0.5) {
      return true; // Price dropped over 50% instantly - flag as anomaly
    }
    return false;
  }

  void _reconnect() {
    status = ConnectionStatus.reconnecting;
    notifyListeners();

    _reconnectAttempts++;
    final delay = min(pow(2, _reconnectAttempts).toInt(), 30);

    Future.delayed(Duration(seconds: delay), () {
      _socketService.connect();
    });
  }
}

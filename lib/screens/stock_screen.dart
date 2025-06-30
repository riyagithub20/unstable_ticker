// File: lib/screens/stock_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/stock_provider.dart';
import '../widgets/stock_tile.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({Key? key}) : super(key: key);

  String _statusText(ConnectionStatus status) {
    switch (status) {
      case ConnectionStatus.connecting:
        return "Connecting...";
      case ConnectionStatus.connected:
        return "Connected";
      case ConnectionStatus.reconnecting:
        return "Reconnecting...";
      case ConnectionStatus.disconnected:
        return "Disconnected";
    }
  }

  Color _statusColor(ConnectionStatus status) {
    switch (status) {
      case ConnectionStatus.connected:
        return Colors.green;
      case ConnectionStatus.reconnecting:
        return Colors.orange;
      case ConnectionStatus.connecting:
      case ConnectionStatus.disconnected:
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StockProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Unstable Ticker', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.circle, size: 12, color: _statusColor(provider.status)),
                const SizedBox(width: 6),
                Text(
                  _statusText(provider.status),
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF0D0D0D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.separated(
          itemCount: provider.stocks.length,
          separatorBuilder: (context, index) => const Divider(color: Colors.grey, height: 1),
          itemBuilder: (context, index) {
            final stock = provider.stocks[index];
            return StockTile(stock: stock);
          },
        ),
      ),
    );
  }
}
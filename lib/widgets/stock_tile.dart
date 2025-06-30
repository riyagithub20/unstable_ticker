// File: lib/widgets/stock_tile.dart
import 'package:flutter/material.dart';
import '../models/stock.dart';

class StockTile extends StatefulWidget {
  final Stock stock;

  const StockTile({Key? key, required this.stock}) : super(key: key);

  @override
  State<StockTile> createState() => _StockTileState();
}

class _StockTileState extends State<StockTile> {
  Color? _flashColor;

  @override
  void didUpdateWidget(covariant StockTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.stock.price > widget.stock.previousPrice) {
      _flash(Colors.green);
    } else if (widget.stock.price < widget.stock.previousPrice) {
      _flash(Colors.red);
    }
  }

  void _flash(Color color) {
    setState(() => _flashColor = color);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _flashColor = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Icon(Icons.trending_up, color: widget.stock.hasAnomaly ? Colors.orange : Colors.blueAccent),
        title: Text(
          widget.stock.ticker,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        subtitle: Text(
          "\$${widget.stock.price.toStringAsFixed(2)}",
          style: TextStyle(
            color: _flashColor ?? Colors.white,
            fontWeight: widget.stock.hasAnomaly ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: widget.stock.hasAnomaly
            ? const Icon(Icons.warning, color: Colors.orange)
            : null,
      ),
    );
  }
}

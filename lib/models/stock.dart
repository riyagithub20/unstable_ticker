class Stock {
  final String ticker;
  double price;
  double previousPrice;
  bool hasAnomaly;

  Stock({
    required this.ticker,
    required this.price,
    this.previousPrice = 0.0,
    this.hasAnomaly = false,
  });
}

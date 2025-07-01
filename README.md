Unstable Ticker - Flutter Stock Tracker
 A resilient Flutter application that consumes an unstable WebSocket feed to display real-time stock prices.
 The app handles corrupted data, detects logical anomalies, and ensures a smooth, robust UI experience,
 fulfilling all the requirements outlined in the provided assignment.
  Setup Instructions
 Prerequisites:

Flutter 3.x installed (
 Get Flutter)
 Dart SDK
 Git (for version control)
 Clone the Repository:
 git clone https://github.com/your-username/unstable_ticker.git
 cd unstable_ticker
 Install Dependencies:
 flutter pub get
 Run the Mock WebSocket Server:
 cd path/to/mock_server.dart
 dart run mock_server.dart
 Note: Keep this server running in a separate terminal. It simulates unstable stock price data.
 Run the Flutter App:
 flutter run
 For Android emulator, use 
10.0.2.2 as the localhost IP, which is already configured.

1.  Architectural Decisions

State Management:
 provider for lightweight, reactive state updates.
 Project Structure:
 models/ - Stock model definition
 providers/ - Business logic & state handling
 services/ - WebSocket abstraction & reconnect logic
 screens/ - UI screens
 widgets/ - Reusable UI components (e.g., StockTile)
 Separation of Concerns:
 UI listens to 
StockProvider for minimal, efficient rebuilds.
 WebSocket logic isolated in 
WebSocketService .
 Clear differentiation between presentation (UI) and data processing layers.
 Why Provider?

Simple for small-to-medium state needs
 Minimal boilerplate
 Easy 
ChangeNotifier pattern for reactive UI
 Anomaly Detection Heuristic
 Rule:

A price drop of over 50% for 
GOOG stock in a single update is considered anomalous.
 Such prices are ignored from display.
 The affected stock shows a visual warning icon.
 Trade-offs:
Prevents extreme unrealistic fluctuations from confusing users.\ ⚠️ In a legitimate market crash
 scenario, the heuristic may trigger false positives. However, for this controlled environment, it fulfills logical
 anomaly detection.
 
 ️ Robustness & Resilience Features

Corrupted Data Handling:
 Malformed JSON discarded silently without app crashes.
 Network Drops:
 Automatic reconnect with Exponential Backoff strategy (2s → 4s → 8s → ... max 30s).
 UI reflects real-time connection status.
 Anomaly Indication:
 Anomalous stocks flagged with warning icons.
 Last valid price retained.

2. UI & User Experience Enhancements


Dark theme resembling real stock apps.
 Price changes flash green (up) or red (down).
 Card-based stock list with clear separators.
 Connection status indicator in the AppBar.
Performance Analysis


Utilized Flutter DevTools to monitor performance.
 Achieved:

Green UI and Raster threads, indicating no jank.
 Optimized widget rebuilds:
 Only the affected StockTile rebuilds on price updates.
 ListView.separated used for performance and visual clarity.
 Screenshot:
 Green bars confirm smooth 60 FPS rendering.
 Future Improvements (Optional)

More sophisticated anomaly detection using historical price trends.
 Additional stock details (charts, percentage changes).
 Robust test coverage for data parsing and logic.
 Platform-adaptive UI for iOS.
 Assignment Requirements Checklist
Conclusion
 This project demonstrates:

Practical Flutter architecture
 Robust handling of unreliable real-time data
 Thoughtful anomaly detection with clear trade-off consideration
 Smooth UI under stress
### Screenshot:

![Performance Overlay Screenshot](assets/performance_screenshot.png)

*Green bars confirm smooth 60 FPS rendering.*

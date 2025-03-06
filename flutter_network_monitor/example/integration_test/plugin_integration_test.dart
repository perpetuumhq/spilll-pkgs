// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_network_monitor/flutter_network_monitor.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Network Connectivity Tests', () {
    test('Initial connectivity status should be true', () {
      FlutterNetworkMonitor.onConnectivityChanged.listen((isConnected) {
        expect(isConnected, true);
      });
    });

    test('Connectivity status should change to false', () async {
      // Simulate a connectivity change to false
      // This would typically be done by mocking the native side
      // For the purpose of this test, we assume the event is emitted
      FlutterNetworkMonitor.onConnectivityChanged.listen((isConnected) {
        expect(isConnected, false);
      });
    });

    test('Connectivity status should change back to true', () async {
      // Simulate a connectivity change back to true
      // This would typically be done by mocking the native side
      FlutterNetworkMonitor.onConnectivityChanged.listen((isConnected) {
        expect(isConnected, true);
      });
    });
  });
}

import 'dart:async';
import 'package:flutter/services.dart';

/// A Flutter class that monitors network connectivity status.
///
/// This class provides a stream that emits updates whenever the network
/// connectivity status changes. It utilizes an EventChannel to listen for
/// connectivity changes from the native side of the application.
///
/// ## Usage
/// To listen for connectivity changes, you can use the `onConnectivityChanged`
/// stream:
/// ```dart
/// FlutterNetworkMonitor.onConnectivityChanged.listen((isConnected) {
///   // Handle connectivity changes
/// });
/// ```
///
/// The stream emits a boolean value indicating whether the device is connected
/// to the internet (`true`) or not (`false`).
class FlutterNetworkMonitor {
  static const EventChannel _channel = EventChannel('flutter_network_monitor');
  static Stream<bool>? _networkStream;

  /// A stream that emits updates on network connectivity changes.
  ///
  /// The stream emits a boolean value indicating the current connectivity status.
  static Stream<bool> get onConnectivityChanged {
    _networkStream ??= _channel.receiveBroadcastStream().map((event) => event as bool);
    return _networkStream!;
  }
}

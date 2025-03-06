# flutter_network_monitor

A Flutter plugin for monitoring network connectivity.

## Getting Started

This project provides a Flutter plugin that allows you to monitor the network connectivity status of the device. It includes platform-specific implementation code for both Android and iOS.

### Installation

To use this plugin, add `flutter_network_monitor` as a dependency in your `pubspec.yaml` file:

```sh
flutter pub add flutter_network_monitor
```

## Usage

```dart
 StreamSubscription<bool>? _subscription;
 _subscription = FlutterNetworkMonitor.onConnectivityChanged.       listen((status) {
      setState(() {
          isConnected = status;
        });
    });
```


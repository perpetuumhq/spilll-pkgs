import Flutter
import UIKit
import Network

/// A Flutter plugin that monitors network connectivity status using NWPathMonitor.
public class FlutterNetworkMonitorPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private var monitor: NWPathMonitor?
    private var eventSink: FlutterEventSink?

    /// Registers the plugin with the Flutter plugin registrar.
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterEventChannel(name: "flutter_network_monitor", binaryMessenger: registrar.messenger())
        let instance = FlutterNetworkMonitorPlugin()
        channel.setStreamHandler(instance)
    }

    /// Starts listening for network connectivity changes.
    public func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                let isConnected = path.status == .satisfied
                eventSink(isConnected)
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitorQueue", qos: .background)
        monitor?.start(queue: queue)
        return nil
    }

    /// Stops listening for network connectivity changes and cleans up resources.
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        monitor?.cancel()
        monitor = nil
        eventSink = nil
        return nil
    }
}

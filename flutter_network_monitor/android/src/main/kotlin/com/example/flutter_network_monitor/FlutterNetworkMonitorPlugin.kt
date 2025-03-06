package com.example.flutter_network_monitor

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import android.os.Handler
import android.os.Looper

class FlutterNetworkMonitorPlugin : FlutterPlugin, EventChannel.StreamHandler {
    private lateinit var context: Context
    private var eventSink: EventChannel.EventSink? = null
    private var connectivityManager: ConnectivityManager? = null
    private var networkCallback: ConnectivityManager.NetworkCallback? = null
    private val mainHandler = Handler(Looper.getMainLooper()) // Ensures UI thread updates

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        val eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "flutter_network_monitor")
        eventChannel.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink?) {
        this.eventSink = eventSink
        connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        networkCallback = object : ConnectivityManager.NetworkCallback() {
            override fun onAvailable(network: Network) {
                sendEvent(true)
            }

            override fun onLost(network: Network) {
                sendEvent(false)
            }
        }

        val request = NetworkRequest.Builder()
            .addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            .build()

        connectivityManager?.registerNetworkCallback(request, networkCallback!!)

        // Check initial network state
        sendEvent(isConnected())
    }

    override fun onCancel(arguments: Any?) {
        connectivityManager?.unregisterNetworkCallback(networkCallback!!)
        eventSink = null
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {}

    private fun sendEvent(isConnected: Boolean) {
        mainHandler.post {
            eventSink?.success(isConnected)
        }
    }

    private fun isConnected(): Boolean {
        val network = connectivityManager?.activeNetwork ?: return false
        val capabilities = connectivityManager?.getNetworkCapabilities(network) ?: return false
        return capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
    }
}

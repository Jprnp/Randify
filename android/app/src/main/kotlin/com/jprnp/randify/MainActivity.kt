package com.jprnp.randify
import android.content.Context

import android.content.BroadcastReceiver
import android.content.Intent
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel



class MainActivity: FlutterActivity() {
  private val CHANNEL = "callback.com.jprnp.randify/channel";
  private val EVENTS = "callback.com.jprnp.randify/events";
  private var startString: String? = null;
  private var linksReceiver: BroadcastReceiver? = null;

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    var intent: Intent = intent;
    var data = intent.data;

    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
      if (call.method == "initialLink") {
        if (startString != null) {
          result.success(startString)
        }
      }
    }

    EventChannel(flutterView, EVENTS).setStreamHandler(
            object : EventChannel.StreamHandler {
              override fun onListen(args: Any, events: EventChannel.EventSink) {
                linksReceiver = createChangeReceiver(events)
              }

              override fun onCancel(args: Any) {
                linksReceiver = null
              }
            }
    )

    if (data != null) {
      startString = data.toString();

      linksReceiver?.onReceive(this.getApplicationContext(), intent)
    }
  }

  override fun onNewIntent(intent: Intent?) {
    super.onNewIntent(intent);
    if(intent?.action == Intent.ACTION_VIEW && linksReceiver != null) {
      linksReceiver!!.onReceive(this.applicationContext, intent);
    }
  }

  private fun createChangeReceiver(events: EventChannel.EventSink): BroadcastReceiver {
    return object : BroadcastReceiver() {
      override fun onReceive(context: Context, intent: Intent) {
        // NOTE: assuming intent.getAction() is Intent.ACTION_VIEW

        val dataString = intent.dataString

        if (dataString == null) {
          events.error("UNAVAILABLE", "Link unavailable", null)
        } else {
          events.success(dataString)
        }
      }
    }
  }
}

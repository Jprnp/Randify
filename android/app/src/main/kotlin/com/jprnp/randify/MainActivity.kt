package com.jprnp.randify

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  private val CHANNEL = "callback.com.jprnp.randify/channel";
  private val EVENTS = "callback.com.jprnp.randify/events";
  private var startString: String? = null;
  private var linksReceiver: BroadcastReceiver? = null;

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
  }
}

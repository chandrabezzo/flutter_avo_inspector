package com.solusibejo.flutter_avo_inspector

import android.app.Activity
import android.app.Application
import androidx.annotation.NonNull
import app.avo.inspector.AvoInspector
import app.avo.inspector.AvoInspectorEnv
import com.solusibejo.flutter_avo_inspector.consts.Arguments
import com.solusibejo.flutter_avo_inspector.consts.Constants
import com.solusibejo.flutter_avo_inspector.consts.MethodNames

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterAvoInspectorPlugin */
class FlutterAvoInspectorPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var application: Application? = null
  private var activity: Activity? = null
  private var avo: AvoInspector? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, Constants.pluginName)
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when(call.method){
      MethodNames.initialize -> {
        initialize(call, result)
      }
      MethodNames.hasInitialized -> {
        hasInitialized(result)
      }
      MethodNames.trackEventParams -> {
        FlutterAvoInspectorMethods.trackEventParams(avo!!, call, result)
      }
      MethodNames.trackEventJson -> {
        FlutterAvoInspectorMethods.trackEventJson(avo!!, call, result)
      }
      MethodNames.logging -> {
        FlutterAvoInspectorMethods.logging(call, result)
      }
      MethodNames.isLogging -> {
        FlutterAvoInspectorMethods.isLogging(result)
      }
      MethodNames.setBatchSize -> {
        FlutterAvoInspectorMethods.setBatchSize(call, result)
      }
      MethodNames.batchSize -> {
        FlutterAvoInspectorMethods.batchSize(result)
      }
      MethodNames.setBatchFlushSeconds -> {
        FlutterAvoInspectorMethods.setBatchFlushSeconds(call, result)
      }
      MethodNames.batchFlushSeconds -> {
        FlutterAvoInspectorMethods.batchFlushSeconds(result)
      }
      MethodNames.showVisualInspector -> {
        FlutterAvoInspectorMethods.showVisualInspector(activity!!, avo!!, call, result)
      }
      MethodNames.hideVisualInspector -> {
        FlutterAvoInspectorMethods.hideVisualInspector(activity!!, avo!!, result)
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    application = binding.activity.application
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    application = binding.activity.application
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    application = null
    activity = null
  }

  private fun initialize(
    call: MethodCall,
    result: Result
  ){
    val apiKey = call.argument<String>(Arguments.apiKey) ?: ""
    val env = call.argument<String>(Arguments.environment) ?: Constants.development

    if(application != null){
      avo = instance(apiKey, application!!, getEnv(env), activity)
      result.success(201)
    }
    else {
      result.error("500", "Application not initialize",
        "Application needed when initialize AvoInspector")
    }
  }

  private fun instance(
    apiKey: String, application: Application, env: AvoInspectorEnv,
    rootActivityForVisualInspector: Activity?
  ): AvoInspector {
    return AvoInspector(apiKey, application, env, rootActivityForVisualInspector)
  }

  private fun hasInitialized(
    result: Result
  ): Boolean {
    return if(avo != null){
      result.success(201)
      true
    }
    else {
      result.error("404", "Avo Not Initialized",
        "Please call method initialize first")
      false
    }
  }

  private fun getEnv(environment: String): AvoInspectorEnv {
    return when(environment){
      Constants.staging -> AvoInspectorEnv.Staging
      Constants.production -> AvoInspectorEnv.Prod
      else -> AvoInspectorEnv.Dev
    }
  }
}

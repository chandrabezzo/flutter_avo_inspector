
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'flutter_avo_inspector_env.dart';
import 'consts/arguments.dart';
import 'consts/constants.dart';
import 'consts/method_names.dart';
import 'consts/visual_inspector_mode.dart';

class FlutterAvoInspector {
  static const MethodChannel _channel = MethodChannel(Constants.pluginName);

  /// Initialize method to prepare Avo Inspector. Need to call this method
  /// first and once in main.dart
  static Future<int> initialize({
    required String apiKey,
    required FlutterAvoInspectorEnv env,
  }) async {
    final arguments = <String, dynamic>{
      Arguments.apiKey: apiKey,
      Arguments.environment: _convertEnvToString(env),
    };

    try {
      final invoke =
          await _channel.invokeMethod<int>(MethodNames.initialize, arguments);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      return Constants.errorMethod;
    }
  }

  static String _convertEnvToString(FlutterAvoInspectorEnv env) {
    String environment = '';
    switch (env) {
      case FlutterAvoInspectorEnv.staging:
        environment = Constants.staging;
        break;
      case FlutterAvoInspectorEnv.production:
        environment = Constants.production;
        break;
      default:
        environment = Constants.development;
        break;
    }

    return environment;
  }

  /// To check Avo Inspector has been initialized or not.
  /// If Avo Inspector never call [initialize], we can't use all available 
  /// methods
  static Future<int> get hasInitialized async {
    try {
      final invoke =
          await _channel.invokeMethod<int>(MethodNames.hasInitialized);
      return invoke ?? Constants.errorNotFound;
    } catch (error) {
      return Constants.errorNotFound;
    }
  }

  /// To send event schemas to Avo Inspector. 
  /// You can send any payload via params as [Map].
  static Future<int> trackEventParams({
    required String eventName,
    Map<String, dynamic>? params,
  }) async {
    final arguments = <String, dynamic>{
      Arguments.eventName: eventName,
    };

    if (params != null) arguments[Arguments.eventParams] = params;

    try {
      final invoke = await _channel.invokeMethod<int>(
          MethodNames.trackEventParams, arguments);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  /// To send event schemas to Avo Inspector. You can send any payload via 
  /// params as [Map], but will be converted as JSON. This method same approach
  /// with [trackEventParams].
  static Future<int> trackEventJson({
    required String eventName,
    Map<String, dynamic>? json,
  }) async {
    final arguments = <String, dynamic>{
      Arguments.eventName: eventName,
    };

    if(json != null) arguments[Arguments.eventJson] = jsonEncode(json);

    try {
      final invoke = await _channel.invokeMethod<int>(
          MethodNames.trackEventJson, arguments);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  /// You can enabled/disable [logging] in terminal during development 
  /// using Avo Inspector
  static Future<int> logging({required bool isEnableLogging}) async {
    final arguments = <String, dynamic>{
      Arguments.isEnableLogging: isEnableLogging,
    };

    try {
      final invoke =
          await _channel.invokeMethod<int>(MethodNames.logging, arguments);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  /// Check logging status
  static Future<bool> get isLogging async {
    try {
      final invoke = await _channel.invokeMethod<bool>(MethodNames.isLogging);
      return invoke ?? false;
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
  }

  /// Control batching size using [setBatchSize].
  /// Enables manual control over events batching. Default batch size in 
  /// production is 30, i.e. the library attempts to send event schemas to 
  /// the server when it has 30 or more schemas. In development batching is 
  /// disabled by default.
  static Future<int> setBatchSize({
    required int batchSize,
  }) async {
    final arguments = <String, dynamic>{
      Arguments.batchSize: batchSize,
    };

    try {
      final invoke =
          await _channel.invokeMethod<int>(MethodNames.setBatchSize, arguments);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  /// Get value of batch size
  static Future<int> get batchSize async {
    try {
      final invoke = await _channel.invokeMethod<int>(MethodNames.batchSize);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  /// Control batching interval using [setBatchFlushSeconds].
  /// Enables manual control over events batching. Default production batch 
  /// flush interval is 30 seconds, i.e. the library attempts to send event 
  /// schemas to the server when 30 or more seconds pass, 
  /// given there are unsent schemas.
  static Future<int> setBatchFlushSeconds({
    required int batchFlushSeconds,
  }) async {
    final arguments = <String, dynamic>{
      Arguments.batchFlushSeconds: batchFlushSeconds,
    };

    try {
      final invoke = await _channel.invokeMethod<int>(
          MethodNames.setBatchFlushSeconds, arguments);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  /// Get value of batch interval
  static Future<int> get batchFlushSeconds async {
    try {
      final invoke =
          await _channel.invokeMethod<int>(MethodNames.batchFlushSeconds);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  /// Set visual inspector mode, by default is Bubble.
  static Future<int> showVisualInspector({
    required VisualInspectorMode mode,
  }) async {
    int viMode = 1;

    if (mode == VisualInspectorMode.bar) viMode = 0;

    final arguments = <String, dynamic>{
      Arguments.visualInspectorMode: viMode,
    };

    try {
      final invoke = await _channel.invokeMethod<int>(
          MethodNames.showVisualInspector, arguments);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  /// Hide visual inspector
  static Future<int> get hideVisualInspector async {
    try {
      final invoke =
          await _channel.invokeMethod<int>(MethodNames.hideVisualInspector);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }
}

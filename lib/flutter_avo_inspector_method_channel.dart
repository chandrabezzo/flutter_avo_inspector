import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_avo_inspector/src/consts/constants.dart';
import 'package:flutter_avo_inspector/src/flutter_avo_inspector_env.dart';

import 'flutter_avo_inspector_platform_interface.dart';
import 'src/consts/arguments.dart';
import 'src/consts/method_names.dart';
import 'src/visual_inspector_mode.dart';

/// An implementation of [FlutterAvoInspectorPlatform] that uses method channels.
class MethodChannelFlutterAvoInspector extends FlutterAvoInspectorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(Constants.pluginName);

  @override
  Future<int> initialize({
    required String apiKey,
    required appName,
    required appVersion,
    required FlutterAvoInspectorEnv env,
  }) async {
    final arguments = <String, dynamic>{
      Arguments.apiKey: apiKey,
      Arguments.environment: env.name,
    };

    try {
      final invoke = await methodChannel.invokeMethod<int>(
          MethodNames.initialize, arguments);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      return Constants.errorMethod;
    }
  }

  @override
  Future<int> get hasInitialized async {
    try {
      final invoke =
          await methodChannel.invokeMethod<int>(MethodNames.hasInitialized);
      return invoke ?? Constants.errorNotFound;
    } catch (error) {
      return Constants.errorNotFound;
    }
  }

  @override
  Future<int> trackEventParams({
    required String eventName,
    Map<String, dynamic>? params,
  }) async {
    final arguments = <String, dynamic>{
      Arguments.eventName: eventName,
    };

    if (params != null) arguments[Arguments.eventParams] = params;

    try {
      final invoke = await methodChannel.invokeMethod<int>(
          MethodNames.trackEventParams, arguments);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  @override
  Future<int> trackEventJson({
    required String eventName,
    Map<String, dynamic>? json,
  }) async {
    final arguments = <String, dynamic>{
      Arguments.eventName: eventName,
    };

    if (json != null) arguments[Arguments.eventJson] = jsonEncode(json);

    try {
      final invoke = await methodChannel.invokeMethod<int>(
          MethodNames.trackEventJson, arguments);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  @override
  Future<int> logging(bool isEnableLogging) async {
    final arguments = <String, dynamic>{
      Arguments.isEnableLogging: isEnableLogging,
    };

    try {
      final invoke =
          await methodChannel.invokeMethod<int>(MethodNames.logging, arguments);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  @override
  Future<bool> get isLogging async {
    try {
      final invoke =
          await methodChannel.invokeMethod<bool>(MethodNames.isLogging);
      return invoke ?? false;
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
  }

  @override
  Future<int> setBatchSize(int batchSize) async {
    final arguments = <String, dynamic>{
      Arguments.batchSize: batchSize,
    };

    try {
      final invoke = await methodChannel.invokeMethod<int>(
          MethodNames.setBatchSize, arguments);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  @override
  Future<int> get batchSize async {
    try {
      final invoke =
          await methodChannel.invokeMethod<int>(MethodNames.batchSize);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  @override
  Future<int> setBatchFlushSeconds(int batchFlushSeconds) async {
    final arguments = <String, dynamic>{
      Arguments.batchFlushSeconds: batchFlushSeconds,
    };

    try {
      final invoke = await methodChannel.invokeMethod<int>(
          MethodNames.setBatchFlushSeconds, arguments);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  @override
  Future<int> get batchFlushSeconds async {
    try {
      final invoke =
          await methodChannel.invokeMethod<int>(MethodNames.batchFlushSeconds);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  @override
  Future<int> showVisualInspector(VisualInspectorMode mode) async {
    int viMode = 1;

    if (mode == VisualInspectorMode.bar) viMode = 0;

    final arguments = <String, dynamic>{
      Arguments.visualInspectorMode: viMode,
    };

    try {
      final invoke = await methodChannel.invokeMethod<int>(
          MethodNames.showVisualInspector, arguments);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }

  @override
  Future<int> get hideVisualInspector async {
    try {
      final invoke = await methodChannel
          .invokeMethod<int>(MethodNames.hideVisualInspector);
      return invoke ?? Constants.errorMethod;
    } catch (error) {
      debugPrint(error.toString());
      return Constants.errorMethod;
    }
  }
}

import 'package:flutter_avo_inspector/src/flutter_avo_inspector_env.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_avo_inspector_method_channel.dart';
import 'src/visual_inspector_mode.dart';

abstract class FlutterAvoInspectorPlatform extends PlatformInterface {
  /// Constructs a FlutterAvoInspectorPlatform.
  FlutterAvoInspectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAvoInspectorPlatform _instance =
      MethodChannelFlutterAvoInspector();

  /// The default instance of [FlutterAvoInspectorPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAvoInspector].
  static FlutterAvoInspectorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAvoInspectorPlatform] when
  /// they register themselves.
  static set instance(FlutterAvoInspectorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<int> initialize({
    required String apiKey,
    required String appName,
    required String appVersion,
    required FlutterAvoInspectorEnv env,
  }) async =>
      throw UnimplementedError('initialize() has not been implemented.');

  Future<int> get hasInitialized async =>
      throw UnimplementedError('hasInitialized() has not been implemented.');

  Future<int> trackEventParams({
    required String eventName,
    Map<String, dynamic>? params,
  }) async =>
      throw UnimplementedError('trackEventParams() has not been implemented.');

  Future<int> trackEventJson({
    required String eventName,
    Map<String, dynamic>? json,
  }) async =>
      throw UnimplementedError('trackEventJson() has not been implemented.');

  Future<int> logging(bool isEnableLogging) async =>
      throw UnimplementedError('logging() has not been implemented.');

  Future<bool> get isLogging async =>
      throw UnimplementedError('isLogging() has not been implemented.');

  Future<int> setBatchSize(int batchSize) async =>
      throw UnimplementedError('setBatchSize() has not been implemented.');

  Future<int> get batchSize async =>
      throw UnimplementedError('batchSize() has not been implemented.');

  Future<int> setBatchFlushSeconds(int batchFlushSeconds) async =>
      throw UnimplementedError(
          'setBatchFlushSeconds() has not been implemented.');

  Future<int> get batchFlushSeconds async =>
      throw UnimplementedError('batchFlushSeconds() has not been implemented.');

  Future<int> showVisualInspector(VisualInspectorMode mode) async =>
      throw UnimplementedError(
          'showVisualInspector() has not been implemented.');

  Future<int> get hideVisualInspector async => throw UnimplementedError(
      'hideVisualInspector() has not been implemented.');
}

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_avo_inspector_method_channel.dart';

abstract class FlutterAvoInspectorPlatform extends PlatformInterface {
  /// Constructs a FlutterAvoInspectorPlatform.
  FlutterAvoInspectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAvoInspectorPlatform _instance = MethodChannelFlutterAvoInspector();

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

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_avo_inspector_platform_interface.dart';

/// An implementation of [FlutterAvoInspectorPlatform] that uses method channels.
class MethodChannelFlutterAvoInspector extends FlutterAvoInspectorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_avo_inspector');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

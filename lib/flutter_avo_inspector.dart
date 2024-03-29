import 'flutter_avo_inspector_platform_interface.dart';
import 'src/flutter_avo_inspector_env.dart';
import 'src/visual_inspector_mode.dart';

export 'src/flutter_avo_inspector_env.dart';
export 'src/visual_inspector_mode.dart';

class FlutterAvoInspector {
  FlutterAvoInspector({
    required String apiKey,
    required String appName,
    required String appVersion,
    FlutterAvoInspectorEnv env = FlutterAvoInspectorEnv.development,
  }) {
    FlutterAvoInspectorPlatform.instance.initialize(
      apiKey: apiKey,
      appName: appName,
      appVersion: appVersion,
      env: env,
    );
  }

  Future<int> get hasInitialized async =>
      await FlutterAvoInspectorPlatform.instance.hasInitialized;

  Future<int> trackEventParams({
    required String eventName,
    Map<String, dynamic>? params,
  }) async =>
      await FlutterAvoInspectorPlatform.instance
          .trackEventParams(eventName: eventName, params: params);

  Future<int> trackEventJson({
    required String eventName,
    Map<String, dynamic>? json,
  }) async =>
      await FlutterAvoInspectorPlatform.instance
          .trackEventJson(eventName: eventName, json: json);

  Future<int> logging(bool isEnableLogging) async =>
      await FlutterAvoInspectorPlatform.instance.logging(isEnableLogging);

  static Future<bool> get isLogging async =>
      await FlutterAvoInspectorPlatform.instance.isLogging;

  Future<int> setBatchSize(int batchSize) async =>
      await FlutterAvoInspectorPlatform.instance.setBatchSize(batchSize);

  Future<int> get batchSize async =>
      await FlutterAvoInspectorPlatform.instance.batchSize;

  Future<int> setBatchFlushSeconds(int batchFlushSeconds) async =>
      await FlutterAvoInspectorPlatform.instance
          .setBatchFlushSeconds(batchFlushSeconds);

  Future<int> get batchFlushSeconds async =>
      await FlutterAvoInspectorPlatform.instance.batchFlushSeconds;

  Future<int> showVisualInspector(VisualInspectorMode mode) async =>
      await FlutterAvoInspectorPlatform.instance.showVisualInspector(mode);

  Future<int> get hideVisualInspector async =>
      await FlutterAvoInspectorPlatform.instance.hideVisualInspector;
}

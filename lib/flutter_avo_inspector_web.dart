// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'flutter_avo_inspector.dart';
import 'flutter_avo_inspector_platform_interface.dart';
import 'src/avo_batcher.dart';
import 'src/avo_installation_id.dart';
import 'src/avo_network_calls_handler.dart';
import 'src/avo_parser.dart';
import 'src/avo_session_tracker.dart';

/// A web implementation of the FlutterAvoInspectorPlatform of the FlutterAvoInspector plugin.
class FlutterAvoInspectorWeb extends FlutterAvoInspectorPlatform {
  /// Constructs a FlutterAvoInspectorWeb
  FlutterAvoInspectorWeb();

  late AvoBatcher _avoBatcher;

  static void registerWith(Registrar registrar) {
    FlutterAvoInspectorPlatform.instance = FlutterAvoInspectorWeb();
  }

  @override
  Future<int> initialize({
    required String apiKey,
    required String appName,
    required String appVersion,
    required FlutterAvoInspectorEnv env,
  }) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final avoInstallationId = AvoInstallationId();

    final networkHandler = AvoNetworkCallsHandler(
      apiKey: apiKey,
      envName: env.toString().split('.').last,
      appName: appName,
      appVersion: appVersion,
      libVersion: '1.0',
    );

    final sessionTracker = AvoSessionTracker(sharedPreferences: sharedPrefs);

    if (env == FlutterAvoInspectorEnv.development) {
      AvoBatcher.batchSizeThreshold = 1;
    } else {
      AvoBatcher.batchSizeThreshold = 30;
    }

    _avoBatcher = AvoBatcher(
      sessionTracker: sessionTracker,
      sharedPreferences: sharedPrefs,
      networkCallsHandler: networkHandler,
      avoInstallationId: avoInstallationId.getInstallationId(sharedPrefs),
    );

    return 200;
  }

  @override
  Future<int> trackEventParams({
    required String eventName,
    Map<String, dynamic>? params,
  }) async {
    debugPrint("event name $eventName");

    final parsedParams = extractSchemaFromEventParams(
      eventParams: params ?? {},
    );
    debugPrint("event params $parsedParams");

    _avoBatcher.handleTrackSchema(
      eventName: eventName,
      eventSchema: parsedParams,
    );

    return 200;
  }
}

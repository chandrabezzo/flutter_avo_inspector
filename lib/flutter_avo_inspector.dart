
import 'flutter_avo_inspector_platform_interface.dart';

class FlutterAvoInspector {
  Future<String?> getPlatformVersion() {
    return FlutterAvoInspectorPlatform.instance.getPlatformVersion();
  }
}

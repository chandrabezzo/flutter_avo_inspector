import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_avo_inspector/flutter_avo_inspector.dart';
import 'package:flutter_avo_inspector/flutter_avo_inspector_platform_interface.dart';
import 'package:flutter_avo_inspector/flutter_avo_inspector_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterAvoInspectorPlatform
    with MockPlatformInterfaceMixin
    implements FlutterAvoInspectorPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterAvoInspectorPlatform initialPlatform = FlutterAvoInspectorPlatform.instance;

  test('$MethodChannelFlutterAvoInspector is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterAvoInspector>());
  });

  test('getPlatformVersion', () async {
    FlutterAvoInspector flutterAvoInspectorPlugin = FlutterAvoInspector();
    MockFlutterAvoInspectorPlatform fakePlatform = MockFlutterAvoInspectorPlatform();
    FlutterAvoInspectorPlatform.instance = fakePlatform;

    expect(await flutterAvoInspectorPlugin.getPlatformVersion(), '42');
  });
}

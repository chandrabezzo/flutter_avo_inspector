// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_avo_inspector/flutter_avo_inspector_method_channel.dart';

// void main() {
//   MethodChannelFlutterAvoInspector platform = MethodChannelFlutterAvoInspector();
//   const MethodChannel channel = MethodChannel('flutter_avo_inspector');

//   TestWidgetsFlutterBinding.ensureInitialized();

//   setUp(() {
//     channel.setMockMethodCallHandler((MethodCall methodCall) async {
//       return '42';
//     });
//   });

//   tearDown(() {
//     channel.setMockMethodCallHandler(null);
//   });

//   test('getPlatformVersion', () async {
//     expect(await platform.getPlatformVersion(), '42');
//   });
// }

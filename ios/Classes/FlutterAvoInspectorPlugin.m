#import "FlutterAvoInspectorPlugin.h"
#if __has_include(<flutter_avo_inspector/flutter_avo_inspector-Swift.h>)
#import <flutter_avo_inspector/flutter_avo_inspector-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_avo_inspector-Swift.h"
#endif

@implementation FlutterAvoInspectorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAvoInspectorPlugin registerWithRegistrar:registrar];
}
@end

#ifndef FLUTTER_PLUGIN_FLUTTER_AVO_INSPECTOR_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_AVO_INSPECTOR_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_avo_inspector {

class FlutterAvoInspectorPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterAvoInspectorPlugin();

  virtual ~FlutterAvoInspectorPlugin();

  // Disallow copy and assign.
  FlutterAvoInspectorPlugin(const FlutterAvoInspectorPlugin&) = delete;
  FlutterAvoInspectorPlugin& operator=(const FlutterAvoInspectorPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_avo_inspector

#endif  // FLUTTER_PLUGIN_FLUTTER_AVO_INSPECTOR_PLUGIN_H_

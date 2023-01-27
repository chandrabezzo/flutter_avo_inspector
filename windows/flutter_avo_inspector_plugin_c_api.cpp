#include "include/flutter_avo_inspector/flutter_avo_inspector_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_avo_inspector_plugin.h"

void FlutterAvoInspectorPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_avo_inspector::FlutterAvoInspectorPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

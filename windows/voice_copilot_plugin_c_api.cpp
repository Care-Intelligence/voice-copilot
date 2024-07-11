#include "include/voice_copilot/voice_copilot_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "voice_copilot_plugin.h"

void VoiceCopilotPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  voice_copilot::VoiceCopilotPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

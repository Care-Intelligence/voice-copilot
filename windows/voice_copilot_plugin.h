#ifndef FLUTTER_PLUGIN_VOICE_COPILOT_PLUGIN_H_
#define FLUTTER_PLUGIN_VOICE_COPILOT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace voice_copilot {

class VoiceCopilotPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  VoiceCopilotPlugin();

  virtual ~VoiceCopilotPlugin();

  // Disallow copy and assign.
  VoiceCopilotPlugin(const VoiceCopilotPlugin&) = delete;
  VoiceCopilotPlugin& operator=(const VoiceCopilotPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace voice_copilot

#endif  // FLUTTER_PLUGIN_VOICE_COPILOT_PLUGIN_H_

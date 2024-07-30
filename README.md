# Voice Copilot

Pacote do Voice da Care intelligence.

## Suporte de Plataforma

| Android | iOS | MacOS | Web | Linux | Windows |
| :-----: | :-: | :---: | :-: | :---: | :-----: |
|   ✔️    | ✔️  |  	❌   | 	❌  |  	❌   |    ❌   |

## Requisitos

- Flutter >=1.17.0
- Flutter Min SDK 23
- Dart >=2.12.0 <3.0.0
- Android `compileSDK` 29
- Java 8
- Android Gradle Plugin >=4.1.0
- Gradle wrapper >=6.5

## Como Usar

Importe `package:voice_beta/voice_beta.dart`, instancie `CareVoiceCopilot` e utilize os métodos `start()` e `stop()` para controlar a gravação de áudio.

Exemplo:

```dart
import 'package:voice_beta/voice_beta.dart';

CareVoiceCopilot voiceCopilot = CareVoiceCopilot(language: "en", api_key: "xxxx.xxxxxx-xxx.xxxxx");

bool started = await voiceCopilot.start();
if (started) {
  print('Recording started.');
}

Map<String, dynamic> recordingData = await voiceCopilot.stop();
print('Recording stopped with data: $recordingData');

bool recordingData = await voiceCopilot.cancelAudio();
print('Audio cancelled');
```

Android:

Para permitir a gravação de áudio no Android, adicione as permissões necessárias no seu arquivo AndroidManifest.xml:

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

IOS:

No seu arquivo ios/Runner/Info.plist, adicione a chave e a descrição necessárias para a permissão de gravação de áudio:

```xml
<key>NSMicrophoneUsageDescription</key>
<string>Gravação de áudio necessária para funcionalidades de voz.</string>
```
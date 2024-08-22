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

## Como Usar

Importe `package:voice_beta/voice_beta.dart`, instancie `CareVoiceCopilot` e utilize os métodos `start()` e `stop()` para controlar a gravação de áudio.

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

Para o uso da ferramenta de assistentes para seguir o passo de instanciar a classe e então usar o `getAssistants` para obter a lista com todos o assistentes disponivel para uso de acordo com sua `Api Key`, proximo passo seria o `useAssistants` onde você passaria essa lista com todos os assistentes e o `transcript` em texto para o seu uso.

```dart
import 'package:voice_beta/voice_beta.dart';

CareVoiceCopilot voiceCopilot = CareVoiceCopilot(language: "en", api_key: "xxxx.xxxxxx-xxx.xxxxx");

List<Assistant> assistantList = await voiceCopilot.getAssistants();
print(assistantList);

List<Map<String, dynamic>> entities = await voiceCopilot.useAssistants(assistantList, "Texto com o transcript para o uso dos assistentes.");
print(entities);
```
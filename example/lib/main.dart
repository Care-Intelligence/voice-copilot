import 'package:flutter/material.dart';
import 'package:voice_copilot/voice_copilot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _voiceCopilotPlugin = CareVoiceCopilot(language: "pt", apiKey: "");

  String _startResult = 'Not started';
  String _stopResult = 'Not stopped';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin Example App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Start Result: $_startResult'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  bool startResult = await _voiceCopilotPlugin.start();
                  setState(() {
                    _startResult = startResult
                        ? 'Recording started'
                        : 'Failed to start recording';
                  });
                },
                child: const Text('Start Recording'),
              ),
              const SizedBox(height: 20),
              Text('Stop Result: $_stopResult'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> stopResult =
                      await _voiceCopilotPlugin.stop();
                  setState(() {
                    _stopResult = 'Stopped: ${stopResult["transcript"]}';
                  });
                },
                child: const Text('Stop Recording'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:voice_copilot/models/assistants/main.dart';
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
  String _startResultCalibration = 'Not started';
  String _stopResult = 'Not stopped';
  String _stopResultCalibration = 'Not stopped';
  String _assistants = 'None';
  String _entities = 'None';
  List<Assistant>? _assistantList;

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
              Text('Start Calibration Result: $_startResultCalibration'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  bool startResult = await _voiceCopilotPlugin.startCalibration(
                      "Beber água suficiente é essencial para manter o corpo funcionando corretamente.");
                  setState(() {
                    _startResultCalibration = startResult
                        ? 'Recording started'
                        : 'Failed to start recording';
                  });
                },
                child: const Text('Start Calibration'),
              ),
              Text('Stop Calibration Result: $_stopResultCalibration'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  Map stopResult = await _voiceCopilotPlugin.stopCalibration();
                  setState(() {
                    _stopResultCalibration = "$stopResult";
                  });
                },
                child: const Text('Stop Calibration'),
              ),
              Text('Start Result: $_startResult'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  bool startResult = await _voiceCopilotPlugin.start(null);
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
              const SizedBox(height: 20),
              Text('Assistants: $_assistants'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  List<Assistant> assistants =
                      await _voiceCopilotPlugin.getAssistants();

                  _assistantList = assistants;

                  setState(() {
                    _assistants = assistants.map((e) => e.toJson()).toString();
                  });
                },
                child: const Text('Get Assistants'),
              ),
              const SizedBox(height: 20),
              Text('Entities: $_entities'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  List<Map<String, dynamic>> entities =
                      await _voiceCopilotPlugin.useAssistants(
                          _assistantList ?? [],
                          "Vitima caiu de uma altura de 30 metros, morte subita");
                  setState(() {
                    _entities = entities.toString();
                  });
                },
                child: const Text('Use Assistants'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

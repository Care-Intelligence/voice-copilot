import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:voice_copilot/voice_copilot.dart';

import 'mock.dart';

void main() {
  group('CareVoiceCopilot', () {
    late CareVoiceCopilot copilot;
    late MockRecordService mockRecordService;

    setUp(() {
      mockRecordService = MockRecordService();
      copilot = CareVoiceCopilot(language: 'en', apiKey: "");
    });

    test('start() should return true when recording starts', () async {
      // Configurando o mock para retornar true quando startRecord for chamado
      when(mockRecordService.startRecord(any)).thenAnswer((_) async => true);

      bool result = await copilot.start();
      expect(result, isTrue);

      // Verificando se startRecord foi chamado uma vez
      verify(mockRecordService.startRecord(any)).called(1);
    });

    test('stop() should return a valid Map when recording stops', () async {
      // Configurando o mock para retornar um Map específico quando stopRecord for chamado
      when(mockRecordService.stopRecord("any", "any"))
          .thenAnswer((_) async => {'status': 'stopped'});

      Map<String, dynamic> result = await copilot.stop();
      expect(result, isA<Map<String, dynamic>>());
      expect(result['status'], equals('stopped'));

      // Verificando se stopRecord foi chamado uma vez
      verify(mockRecordService.stopRecord("any", "any")).called(1);
    });
  });
}

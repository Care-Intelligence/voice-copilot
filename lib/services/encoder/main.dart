import 'dart:io';
import 'package:record/record.dart';

enum AudioEncoderType {
  opus,
  flac,
}

extension AudioEncoderTypeExtension on AudioEncoderType {
  AudioEncoder get encoder {
    switch (this) {
      case AudioEncoderType.opus:
        return AudioEncoder.opus;
      case AudioEncoderType.flac:
        return AudioEncoder.flac;
    }
  }

  String get label {
    switch (this) {
      case AudioEncoderType.opus:
        return 'opus';
      case AudioEncoderType.flac:
        return 'flac';
    }
  }

  int get sampleRate {
    switch (this) {
      case AudioEncoderType.opus:
        return 44000;
      case AudioEncoderType.flac:
        return 32000;
    }
  }

  int get bitRate {
    switch (this) {
      case AudioEncoderType.opus:
      case AudioEncoderType.flac:
        return 16000;
    }
  }

  int get audioChannelCount {
    switch (this) {
      case AudioEncoderType.opus:
      case AudioEncoderType.flac:
        return 2;
    }
  }
}

class EncoderService {
  AudioEncoderType defaultEncoder = AudioEncoderType.opus;

  List getRecordConfig() {
    if (Platform.isIOS) {
      defaultEncoder = AudioEncoderType.flac;
    }

    return [
      RecordConfig(
        encoder: defaultEncoder.encoder,
        sampleRate: defaultEncoder.sampleRate,
        numChannels: defaultEncoder.audioChannelCount,
        bitRate: defaultEncoder.bitRate,
      ),
      defaultEncoder.name
    ];
  }
}

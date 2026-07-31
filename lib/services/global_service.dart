import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:vibration/vibration.dart';

@Singleton()
class GlobalService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playSound(String path) async {
    await _audioPlayer.play(AssetSource(path));
  }

  Future<void> vibrate({int duration = 50}) async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: duration, pattern: [50, 50, 50, 50], intensities: [1, 255]);
    }
  }

  Future<File?> getImage({required ImageSource imageSource}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}

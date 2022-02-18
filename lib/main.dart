import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:pong_game/pong_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.device.fullScreen();
  Flame.device.setOrientation(DeviceOrientation.portraitUp);

  FlameAudio.audioCache.loadAll([
    'Blop.mp3',
    'MirrorBreaking.mp3',
  ]);

  final pongGame = PongGame();
  runApp(GameWidget(
    game: pongGame,
  ));
}

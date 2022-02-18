import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

import '../pong_game.dart';

class Background extends RectangleComponent {
  Background(this.game) : super(size: game.size);

  PongGame game;

  @override
  Future<void>? onLoad() {
    paint.color = const Color(0xFFFFFFFF);

    return super.onLoad();
  }
}

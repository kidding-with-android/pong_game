import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

import '../pong_game.dart';

class Ball extends CircleComponent {
  Ball(this.game)
      : super(
            radius: game.tileSize * .25,
            position: Vector2((game.canvasSize.x / 2),
                ((game.canvasSize.y / game.tileSize) - 1.5) * game.tileSize));

  PongGame game;

  final double _moveStep = .2;
  int direction = 1;

  @override
  Future<void>? onLoad() {
    paint.color = const Color(0xFF000000);
    anchor = Anchor.topCenter;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (game.started) {
      if (position.y < 0 || position.y > game.canvasSize.y) {
        direction = direction * -1;
      }

      position.setValues(
          position.x, position.y + (direction * game.tileSize * dt * 5));
    }

    super.update(dt);
  }
}

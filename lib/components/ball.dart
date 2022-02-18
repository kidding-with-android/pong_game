import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

import '../pong_game.dart';

class Ball extends RectangleComponent {
  Ball(this.game)
      : super(
            size: Vector2(game.tileSize * .5, game.tileSize * .5),
            position: Vector2((game.canvasSize.x / 2),
                ((game.canvasSize.y / game.tileSize) - 1.5) * game.tileSize));

  PongGame game;

  @override
  Future<void>? onLoad() {
    paint.color = const Color(0xFF000000);
    anchor = Anchor.topCenter;

    return super.onLoad();
  }
}

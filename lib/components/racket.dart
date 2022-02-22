import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';

import '../pong_game.dart';

class Racket extends RectangleComponent with Collidable {
  Racket(this.game)
      : super(
            size: Vector2(game.tileSize * 3, game.tileSize * .5),
            position: Vector2((game.canvasSize.x / 2),
                ((game.canvasSize.y / game.tileSize) - 1) * game.tileSize));

  PongGame game;

  final double _moveSpeed = 15;
  int _direction = 0;

  @override
  Future<void>? onLoad() {
    paint.color = const Color(0xFF000000);
    anchor = Anchor.topCenter;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (_direction != 0) _move(dt);
    super.update(dt);
  }

  startMoveLeft() {
    _direction = -1;
  }

  startMoveRight() {
    _direction = 1;
  }

  stopMoving() {
    _direction = 0;
  }

  _move(double dt) {
    double nextPos =
        position.x + (_direction * game.tileSize * dt * _moveSpeed);
    double max = game.canvasSize.x - (size.x / 2);
    double min = 0 + (size.x / 2);

    if (nextPos < min) {
      position.setValues(min, position.y);
      return;
    }

    if (nextPos > max) {
      position.setValues(max, position.y);
      return;
    }

    position.setValues(nextPos, position.y);
  }
}

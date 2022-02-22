import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:pong_game/components/racket.dart';

import '../pong_game.dart';

class Ball extends CircleComponent with Collidable {
  Ball(this.game)
      : super(
            radius: game.tileSize * .25,
            position: Vector2((game.canvasSize.x / 2),
                ((game.canvasSize.y / game.tileSize) - 1.5) * game.tileSize));

  PongGame game;

  final double _moveSpeed = 5;
  int directionX = 1;
  int directionY = 1;

  bool _collisionX = false;
  bool _collisionY = false;

  @override
  Future<void>? onLoad() {
    paint.color = const Color(0xFF000000);
    anchor = Anchor.topCenter;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (game.started) {
      if (_collisionX) {
        directionX *= -1;
        _collisionX = false;
      }
      if (_collisionY) {
        directionY *= -1;
        _collisionY = false;
      }

      position.setValues(
          position.x + (directionX * game.tileSize * dt * _moveSpeed),
          position.y + (directionY * game.tileSize * dt * _moveSpeed));
    }

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is ScreenCollidable<FlameGame>) {
      if (intersectionPoints.first.x <= 0 ||
          intersectionPoints.first.x >= game.canvasSize.x) {
        _collisionX = true;
      }

      if (intersectionPoints.first.y <= 0 ||
          intersectionPoints.first.y >= game.canvasSize.y) {
        _collisionY = true;
      }
      print(
          "[${DateTime.now().toIso8601String()}] bateu na parede (${other.toString()})");
    }

    if (other is Racket) {}
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(Collidable other) {
    // TODO: implement onCollisionEnd
    super.onCollisionEnd(other);
  }
}

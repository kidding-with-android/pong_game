import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
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

  @override
  Future<void>? onLoad() {
    paint.color = const Color(0xFF000000);
    anchor = Anchor.topCenter;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (game.started) {
      position.setValues(
          position.x + (directionX * game.tileSize * dt * _moveSpeed),
          position.y + (directionY * game.tileSize * dt * _moveSpeed));
    }

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (game.started) {
      if (other is ScreenCollidable<FlameGame>) {
        // Esquerda
        if (intersectionPoints.first.x <= 0) {
          FlameAudio.play('Blop.mp3');
          directionX = 1;
        }
        // Direita
        if (intersectionPoints.first.x >= game.canvasSize.x) {
          FlameAudio.play('Blop.mp3');
          directionX = -1;
        }

        // Topo
        if (intersectionPoints.first.y <= 0) {
          FlameAudio.play('Blop.mp3');
          directionY = 1;
        }
        //Baixo
        if (intersectionPoints.first.y >= game.canvasSize.y) {
          game.started = false;
        }
        print("[${DateTime.now().toIso8601String()}] bateu na parede");
      }

      if (other is Racket) {
        if (intersectionPoints.first.y == other.position.y) {
          FlameAudio.play('Blop.mp3');
          directionY = -1;
        }

        print("[${DateTime.now().toIso8601String()}] bateu na raquete");
      }
    }
    super.onCollision(intersectionPoints, other);
  }
}

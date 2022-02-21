import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:pong_game/components/background.dart';
import 'package:pong_game/components/ball.dart';
import 'package:pong_game/components/racket.dart';

class PongGame extends FlameGame with TapDetector, LongPressDetector {
  double tileSize = 0;
  bool started = true;

  late Racket racket;
  late Ball ball;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(Background(this));

    racket = Racket(this);
    add(racket);

    ball = Ball(this);
    add(ball);
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    tileSize = canvasSize.r / 9;

    super.onGameResize(canvasSize);
  }

  @override
  void onTapDown(TapDownInfo info) {
    _moveRacket(info.eventPosition);
    super.onTapDown(info);
  }

  @override
  void onTapUp(TapUpInfo info) {
    racket.stopMoving();
    super.onTapUp(info);
  }

  @override
  void onLongPressStart(LongPressStartInfo info) {
    _moveRacket(info.eventPosition);
    super.onLongPressStart(info);
  }

  @override
  void onLongPressEnd(LongPressEndInfo info) {
    racket.stopMoving();
    super.onLongPressEnd(info);
  }

  void _moveRacket(EventPosition e) {
    if (e.game.x > (canvasSize.x / 2)) {
      racket.startMoveRight();
    } else {
      racket.startMoveLeft();
    }
  }
}

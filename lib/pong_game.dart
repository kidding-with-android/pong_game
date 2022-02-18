import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:pong_game/components/background.dart';
import 'package:pong_game/components/ball.dart';
import 'package:pong_game/components/racket.dart';

class PongGame extends FlameGame with TapDetector, LongPressDetector {
  double tileSize = 0;
  late Racket racket;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(Background(this));

    racket = Racket(this);
    add(racket);

    add(Ball(this));
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    tileSize = canvasSize.r / 9;

    super.onGameResize(canvasSize);
  }

  // @override
  // void render(Canvas canvas) {
  //   // TODO: implement render
  //   super.render(canvas);
  // }

  // @override
  // void update(double dt) {
  //   // TODO: implement update
  //   super.update(dt);
  // }

  bool _pressed = false;

  @override
  void onTapDown(TapDownInfo info) {
    _pressed = true;
    _moveRacket(info.eventPosition);
    super.onTapDown(info);
  }

  @override
  void onTapUp(TapUpInfo info) {
    _pressed = false;
    super.onTapUp(info);
  }

  @override
  void onLongPressStart(LongPressStartInfo info) {
    _pressed = true;
    _moveRacket(info.eventPosition);
    super.onLongPressStart(info);
  }

  @override
  void onLongPressEnd(LongPressEndInfo info) {
    _pressed = false;
    super.onLongPressEnd(info);
  }

  void _moveRacket(EventPosition e) {
    Future.doWhile(() async {
      if (e.game.x > (canvasSize.x / 2)) {
        racket.moveRight();
      } else {
        racket.moveLeft();
      }

      return await Future.delayed(
          const Duration(milliseconds: 1), () => _pressed);
    });
  }
}

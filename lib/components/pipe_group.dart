import 'package:flame/components.dart';
import 'package:flap_bird/components/pipe.dart';
import 'package:flap_bird/game/conifguration.dart';
import 'package:flap_bird/game/flappy_bird_game.dart';
import 'package:flap_bird/game/pipe_position.dart';

class PipeGroup extends PositionComponent
    with HasGameRef<FlappyBirdGame> {
  PipeGroup();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    addAll([
      Pipe(height: 100, pipePosition: PipePosition.top),
      Pipe(height: 200, pipePosition: PipePosition.bottom),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;
  }
}

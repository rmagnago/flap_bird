import 'dart:math';

import 'package:flame/components.dart';
import 'package:flap_bird/components/pipe.dart';
import 'package:flap_bird/game/conifguration.dart';
import 'package:flap_bird/game/flappy_bird_game.dart';
import 'package:flap_bird/game/pipe_position.dart';
import 'package:flutter/widgets.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();

  final _random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);
    final centerY = spacing + _random.nextDouble() * (heightMinusGround - spacing);

    addAll([
      Pipe(height: centerY - spacing / 2, pipePosition: PipePosition.top),
      Pipe(height: heightMinusGround - (centerY + spacing / 2), pipePosition: PipePosition.bottom),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;

    if (position.x < -10) {
      removeFromParent();
      debugPrint('Pipe removido');
    }

    if (gameRef.isGameOver){
      removeFromParent();
      gameRef.isGameOver = false;
    }
  }
}

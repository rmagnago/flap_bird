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
    // O grupo nasce fora da tela, à direita
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - Config.groundHeight;

    // Espaço entre os canos
    final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);

    // Posição central aleatória
    final centerY = spacing + _random.nextDouble() * (heightMinusGround - spacing);

    // Criar cano superior
    final topPipe = Pipe(
      height: centerY - spacing / 2,
      pipePosition: PipePosition.top,
    )
      ..position.x = 0; // ← garante coordenada relativa ao grupo

    // Criar cano inferior
    final bottomPipe = Pipe(
      height: heightMinusGround - (centerY + spacing / 2),
      pipePosition: PipePosition.bottom,
    )
      ..position.x = 0; // ← garante coordenada relativa ao grupo

    addAll([topPipe, bottomPipe]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Move todo o grupo para a esquerda
    position.x -= Config.gameSpeed * dt;

    // Remove da tela e atualiza score
    if (position.x < -10) {
      removeFromParent();
      updateScore();
      debugPrint('Pipe removido');
    }

    // Se o jogo acabou, remove o grupo
    if (gameRef.isGameOver) {
      removeFromParent();
      gameRef.isGameOver = false;
    }
  }

  void updateScore() {
    gameRef.bird.score += 1;
  }
}

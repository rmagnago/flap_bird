import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flap_bird/game/assets.dart';
import 'package:flap_bird/game/bird_moviment.dart';
import 'package:flap_bird/game/conifguration.dart';
import 'package:flap_bird/game/flappy_bird_game.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Bird();

  int score = 0;

  @override
  Future<void> onLoad() async {
    final birdMidFlap = await gameRef.loadSprite(Assets.birdMidFlap);
    final birdDownFlap = await gameRef.loadSprite(Assets.birdDownFlap);
    final birdUpFlap = await gameRef.loadSprite(Assets.birdUpFlap);

    size = Vector2(50, 40);

    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.down: birdDownFlap,
    };

    current = BirdMovement.middle;

    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);

    add(CircleHitbox());
  }

  void fly() {
    add(
      MoveByEffect(
        Vector2(0, Config.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
      ),
    );
    current = BirdMovement.up;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    debugPrint('Colidiu');
  }

  void reset() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
  }

  void gameOver() {
    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
    game.isGameOver = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += Config.birdVelocity * dt;
  }
}

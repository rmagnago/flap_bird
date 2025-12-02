import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flap_bird/game/assets.dart';
import 'package:flap_bird/game/conifguration.dart';
import 'package:flap_bird/game/flappy_bird_game.dart';

class Ground extends ParallaxComponent<FlappyBirdGame>
    with HasGameRef<FlappyBirdGame> {
  Ground();

  RectangleHitbox? _collider;

  @override
  Future<void> onLoad() async {
    final ground = await Flame.images.load(Assets.ground);
    parallax = Parallax([
      ParallaxLayer(ParallaxImage(ground, fill: LayerFill.none)),
    ]);

    // Cria o collider, dimensões corretas serão aplicadas em onGameResize
    _collider = RectangleHitbox();
    add(_collider!);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    // Garante que o hitbox acompanha o tamanho real do jogo
    if (_collider != null) {
      _collider!
        ..position = Vector2(0, size.y - Config.groundHeight)
        ..size = Vector2(size.x, Config.groundHeight);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = Config.gameSpeed;
  }
}

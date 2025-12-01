import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flap_bird/game/assets.dart';
import 'package:flap_bird/game/conifguration.dart';

class Ground extends ParallaxComponent {
  Ground();

  @override
  Future<void> onLoad() async {
    final ground = await Flame.images.load(Assets.ground);
    parallax = Parallax([
      ParallaxLayer(ParallaxImage(ground, fill: LayerFill.none)),
    ]);
  }

  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = Config.gameSpeed;
  }
}

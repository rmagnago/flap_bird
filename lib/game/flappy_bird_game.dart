import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flap_bird/components/background.dart';
import 'package:flap_bird/components/ground.dart';
import 'package:flap_bird/components/bird.dart';
import 'package:flap_bird/components/pipe_group.dart';
import 'package:flap_bird/game/conifguration.dart';

class FlappyBirdGame extends FlameGame with TapDetector {
  late Bird bird;
  Timer interval = Timer(Config.pipeInterval, repeat: true);

  @override
  Future<void> onLoad() async {
    addAll([Background(), Ground(), bird = Bird(), PipeGroup()]);

    interval.onTick = () {
      add(PipeGroup());
    };
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
  }
}

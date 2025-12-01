import 'package:flame/game.dart';
import 'package:flap_bird/components/background.dart';
import 'package:flap_bird/components/ground.dart';
import 'package:flap_bird/components/bird.dart';

class FlappyBirdGame extends FlameGame {
  late Bird bird;

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      ]);
  }
}

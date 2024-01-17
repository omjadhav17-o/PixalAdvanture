import 'dart:async';

import 'package:flame/components.dart';

import 'package:space_invader/components/pixal_adventure.dart';

class BackgroundTtiled extends SpriteComponent with HasGameRef<PixalAdventure> {
  final String color;
  BackgroundTtiled({
    this.color = 'Gray',
    position,
  }) : super(position: position);
  final double scrollspeed = 0.4;
  @override
  FutureOr<void> onLoad() {
    priority = -100;
    size = Vector2.all(64.7);
    sprite = Sprite(game.images.fromCache('Background/$color.png'));

    return super.onLoad();
  }

  @override
  void updateTree(double dt) {
    position.y += scrollspeed;
    double tilesize = 64;
    int scrHight = (game.size.y / tilesize).floor();

    if (position.y > scrHight * tilesize) {
      position.y = -tilesize;
    }
    super.updateTree(dt);
  }
}

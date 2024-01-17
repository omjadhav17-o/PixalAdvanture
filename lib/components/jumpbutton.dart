import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:space_invader/components/pixal_adventure.dart';

class Jumpbutton extends SpriteComponent
    with HasGameRef<PixalAdventure>, TapCallbacks {
  Jumpbutton();

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('joy/Vector.png'));
    position = Vector2(game.size.x - 32 - 64, game.size.y - 32 - 64);
    priority = 100;
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.player.isjump = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.player.isjump = false;
    super.onTapUp(event);
  }
}

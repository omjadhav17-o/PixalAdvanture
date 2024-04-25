import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_invader/components/customhitbox.dart';
import 'package:space_invader/components/pixal_adventure.dart';

class Apple5 extends SpriteAnimationComponent
    with HasGameRef<PixalAdventure>, CollisionCallbacks {
  final String fruit;

  Apple5({
    this.fruit = 'apple1',
    position,
    size,
  }) : super(
          position: position,
          size: size,
        );

  final double stepTime = 0.05;
  final hitbox = CustomHitbox(
    offsetX: 10,
    offsetY: 10,
    width: 12,
    height: 12,
  );
  bool collected = false;
  int count = 0;
  @override
  FutureOr<void> onLoad() {
    add(
      RectangleHitbox(
        position: Vector2(hitbox.offsetX, hitbox.offsetY),
        size: Vector2(hitbox.width, hitbox.height),
        collisionType: CollisionType.passive, //checks collision with it self
      ),
    );
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Items/Fruits/$fruit.png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );

    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Items/Fruits/$fruit.png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );

    return super.onLoad();
  }

  void colliding5() {
    if (!collected) {
      animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Items/Fruits/Collected.png'),
        SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: stepTime,
            textureSize: Vector2.all(32),
            loop: false),
      );

      collected = true;
      position.x = 368.00;
      position.y = 48.00;
      animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Items/Fruits/apple5.png'),
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: stepTime,
          textureSize: Vector2.all(32),
        ),
      );
    }
    //removeFromParent();
  }
}

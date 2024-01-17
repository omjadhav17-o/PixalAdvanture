import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_invader/components/collision.dart';
import 'package:space_invader/components/customhitbox.dart';
import 'package:space_invader/components/fruits.dart';

import 'package:space_invader/components/pixal_adventure.dart';
import 'package:space_invader/components/utilite.dart';

enum Players { idel, running, jumping, falling }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixalAdventure>, CollisionCallbacks {
  //position ->>position of player
  Player({position, this.name = 'Mask Dude'})
      : super(
            position:
                position); //this send the postion to spriteanimationgroupcomponent
  String name;
  late final SpriteAnimation idelanimation;
  late final SpriteAnimation runninganimatons;
  late final SpriteAnimation jumpinganimatios;
  late final SpriteAnimation fallinganimatios;
  double steptime = 0.05;
  List<CollisionBlock> collisionblock = [];

  double gravity = 9.8;
  double terminalvelocity = 400;
  double jumpforce = 260;
  double horimovement = 0;
  Vector2 velocity = Vector2.zero();
  double movingspeed = 100;
  bool isonground = false;
  bool isjump = false;
  CustomHitbox hitbox = CustomHitbox(
    offsetX: 10,
    offsetY: 4,
    width: 14,
    height: 28,
  );
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  @override
  FutureOr<void> onLoad() {
    _loadanimations();

    // startingPosition = Vector2(position.x, position.y);

    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt; //add the delta time for each updation
    while (accumulatedTime >= fixedDeltaTime) {
      upadte_playersate();
      _updateplayersmovement(fixedDeltaTime);

      //_updatephase();
      _playerCollision();
      _addgravity(fixedDeltaTime);
      _verticalcollision();

      accumulatedTime -= fixedDeltaTime;
    }

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Fruit) {
      other.colliding();
    }
    super.onCollision(intersectionPoints, other);
  }

  void _loadanimations() {
    idelanimation = _spriteAnimation('Idle');

    runninganimatons = _spriteAnimation('Run');

    fallinganimatios = _spriteAnimation('Fall');

    jumpinganimatios = _spriteAnimation('Jump');

    //add list of animatios
    animations = {
      Players.idel: idelanimation,
      Players.running: runninganimatons,
      Players.jumping: jumpinganimatios,
      Players.falling: fallinganimatios
    };

    //current animations
    current = Players.idel;
  }

  //funcion to add characters
  SpriteAnimation _spriteAnimation(String character) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('Main Characters/$name/$character (32x32).png'),
        SpriteAnimationData.sequenced(
            amount: 11, stepTime: steptime, textureSize: Vector2.all(32)));
  }

  void upadte_playersate() {
    Players players = Players.idel;

    if (horimovement < 0 && scale.x > 0.0) {
      flipHorizontallyAroundCenter();
    } else if (horimovement > 0 && scale.x < 0.0) {
      flipHorizontallyAroundCenter();
    }

    if (velocity.x > 0 || velocity.x < 0) {
      players = Players.running;
    }

    //check if falling ,set to fall
    //if (velocity.y > 0) players = Players.falling;

    // Checks if jumping, set to jumping
    //if (velocity.y < 0) players = Players.jumping;

    current = players;
  }

  void _updatephase() {}

  void _updateplayersmovement(dt) {
    if (isjump && isonground) _jumpPlayer(dt);
    velocity.x = horimovement *
        movingspeed; //movespeed will mulitply the distance traveled with it so that it will travel more pixels in that time
    //updates the position of player as we have used update() by adding the new distance tarvelled which is velocity datatype
    position.x += velocity.x * dt; //we used delta time to keep fps same
  }

  void _jumpPlayer(double dt) {
    velocity.y = -jumpforce;
    position.y += velocity.y * dt;
    isjump = false;
    isonground = false;
  }

  void _playerCollision() {
    for (final block in collisionblock) {
      if (!block.isplatform) {
        if (checkcollision(this, block)) {
          if (velocity.x > 0) {
            velocity.x = 0;
            position.x = block.x - hitbox.offsetX - hitbox.width;
            break;
          }
          if (velocity.x < 0) {
            velocity.x = 0;
            position.x = block.x + block.width + hitbox.width + hitbox.offsetX;
            break;
          }
        }
      }
    }
  }

  void _verticalcollision() {
    for (final block in collisionblock) {
      if (block.isplatform) {
        if (checkcollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isonground = true;
            break;
          }
        }
      } else {
        if (checkcollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isonground = true;
            break;
          }
          if (velocity.y < 0) {
            velocity.y = 0;
            position.y = block.y + block.height - hitbox.offsetY;
            break;
          }
        }
      }
    }
  }

  //add gravity
  void _addgravity(double dt) {
    velocity.y += gravity;
    velocity.y = velocity.y.clamp(-jumpforce, terminalvelocity);
    position.y += velocity.y * dt;
  }
}

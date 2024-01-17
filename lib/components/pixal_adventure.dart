import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:space_invader/components/Players.dart';
import 'package:space_invader/components/jumpbutton.dart';

import 'package:space_invader/components/level.dart';

class PixalAdventure extends FlameGame
    with DragCallbacks, TapCallbacks, HasCollisionDetection {
  late final CameraComponent cam;
  late JoystickComponent joystick;
  Player player = Player(name: 'Mask Dude');

  @override
  @override
  void update(double dt) {
    update_joystick();
    super.update(dt);
  }

  FutureOr<void> onLoad() async {
    //takes all images first
    await images.loadAllImages();

    //integrates the level animation into the game
    final world = Level(player: player);

    cam = CameraComponent.withFixedResolution(
        world: world, width: 600, height: 368);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([world, cam]);

    add_joystick();

    return super.onLoad();
  }

  void add_joystick() {
    joystick = JoystickComponent(
        priority: -100,
        knob: SpriteComponent(
          sprite: Sprite(images.fromCache('joy/knob.png')),
        ),
        background: SpriteComponent(
          sprite: Sprite(
            images.fromCache('joy/joystick.png'),
          ),
        ),
        margin: const EdgeInsets.only(left: 40, bottom: 70),
        knobRadius: 50);
    add(joystick);
    add(Jumpbutton());
  }

  void update_joystick() {
    switch (joystick.direction) {
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horimovement = 1;
        break;

      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horimovement = -1;
        break;

      default:
        player.horimovement = 0;
    }
  }
}

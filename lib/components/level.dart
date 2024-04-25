import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:space_invader/components/Apple%20copy%202.dart';
import 'package:space_invader/components/Apple%20copy%203.dart';
import 'package:space_invader/components/Apple%20copy%204.dart';
import 'package:space_invader/components/Apple%20copy.dart';
import 'package:space_invader/components/Apple.dart';
import 'package:space_invader/components/Background.dart';
import 'package:space_invader/components/Players.dart';
import 'package:space_invader/components/collision.dart';
import 'package:space_invader/components/fruits.dart';
import 'package:space_invader/components/pixal_adventure.dart';

class Level extends World with HasGameRef<PixalAdventure> {
  Color backgroundColor() => const Color(0xFF211F30);
  late TiledComponent level;
  final Player player;
  Level({required this.player});
  List<CollisionBlock> collisionblock = [];
  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('level-01.tmx', Vector2.all(16));
    add(level);

    // //final fruits = Fruit(
    //   fruit: 'Apple',
    //   position: Vector2(0, 0),
    //   size: Vector2(70, 70),
    // );
    //add(fruits);

    addBackground();

    addspawnpoints();

    addcollosion();
    //find the postion of player in the animation and update the postion in game

    return super.onLoad();
  }

  void addcollosion() {
    final collisionlayer = level.tileMap.getLayer<ObjectGroup>('collision');
    for (final collision in collisionlayer!.objects) {
      switch (collision.class_) {
        //all the x,y coordinate of platform is storoed in collosion
        case 'platform':
          final platform = CollisionBlock(
            position: Vector2(collision.x, collision.y),
            size: Vector2(collision.width, collision.height),
            isplatform: true,
          );
          collisionblock.add(platform);
          add(platform);
          break;
        default:
          final block = CollisionBlock(
            position: Vector2(collision.x, collision.y),
            size: Vector2(collision.width, collision.height),
            isplatform: false,
          );
          collisionblock.add(block);
          add(block);
      }
    }

    player.collisionblock = collisionblock;
  }

  void addspawnpoints() {
    final Spawnpointlayer = level.tileMap.getLayer<ObjectGroup>('Spawnpint');
    for (final spawnpoint in Spawnpointlayer!.objects) {
      switch (spawnpoint.class_) {
        case 'Player':
          player.position = Vector2(spawnpoint.x, spawnpoint.y);
          //player addition logic is here
          add(player);
          break;
        case 'Fruit':
          var fruits = Fruit(
            fruit: spawnpoint.name,
            position: Vector2(spawnpoint.x, spawnpoint.y),
            size: Vector2(spawnpoint.width, spawnpoint.height),
          );

          add(fruits);
          break;
        case 'apple1':
          var apple1 = Apple1(
            fruit: spawnpoint.name,
            position: Vector2(spawnpoint.x, spawnpoint.y),
            size: Vector2(spawnpoint.width, spawnpoint.height),
          );

          add(apple1);
          break;
        case 'apple2':
          var apple2 = Apple2(
            fruit: spawnpoint.name,
            position: Vector2(spawnpoint.x, spawnpoint.y),
            size: Vector2(spawnpoint.width, spawnpoint.height),
          );

          add(apple2);
          break;
        case 'apple3':
          var apple3 = Apple3(
            fruit: spawnpoint.name,
            position: Vector2(spawnpoint.x, spawnpoint.y),
            size: Vector2(spawnpoint.width, spawnpoint.height),
          );

          add(apple3);
          break;
        case 'apple4':
          var apple4 = Apple4(
            fruit: spawnpoint.name,
            position: Vector2(spawnpoint.x, spawnpoint.y),
            size: Vector2(spawnpoint.width, spawnpoint.height),
          );

          add(apple4);
          break;
        case 'apple5':
          var apple5 = Apple5(
            fruit: spawnpoint.name,
            position: Vector2(spawnpoint.x, spawnpoint.y),
            size: Vector2(spawnpoint.width, spawnpoint.height),
          );

          add(apple5);
          break;
        default:
      }
    }
  }

  void addBackground() {
    final backgoundlayer = level.tileMap.getLayer('Tile Layer 1');

    //final backgroundcolr = backgoundlayer.properties.getValue('Background');

    // final backgourndtile = BackgroundTtiled(
    //   color: backgroundcolr ?? 'Gray',
    //   position: Vector2(0, 0),
    // );
    // add(backgourndtile);
    const tilesize = 64;

    final tiledx = (game.size.x / tilesize).floor();
    final tiledy = (game.size.y / tilesize).floor();

    if (backgoundlayer != null) {
      for (double y = 0; y < game.size.y / tiledy; y++) {
        for (double x = 0; x < tiledx; x++) {
          final backgroundcolr =
              backgoundlayer.properties.getValue('Background');

          final backgourndtile = BackgroundTtiled(
            color: backgroundcolr ?? 'Gray',
            position: Vector2(x * tilesize, y * tilesize),
          );

          add(backgourndtile);
        }
      }
    }
  } //add backgournd
}

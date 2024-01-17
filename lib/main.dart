import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:space_invader/components/pixal_adventure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.device.setLandscape();
  await Flame.device.fullScreen();
  PixalAdventure game = PixalAdventure();
  runApp(GameWidget(game: kDebugMode ? PixalAdventure() : game));
}

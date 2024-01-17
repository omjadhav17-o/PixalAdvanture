import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  bool isplatform;
  CollisionBlock({position, size, this.isplatform = false})
      : super(position: position, size: size);
}

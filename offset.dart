import 'package:flutter/material.dart';

extension OffsetExtension on Offset {
  bool isOutsideOf(RenderBox box) {
    final boxSize = box.size;
    final boxPosition = box.localToGlobal(Offset.zero);

    return dx < boxPosition.dx ||
        dx > boxPosition.dx + boxSize.width ||
        dy < boxPosition.dy ||
        dy > boxPosition.dy + boxSize.height;
  }
}

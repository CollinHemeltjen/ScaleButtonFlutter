import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScaleButton extends HookWidget {
  const ScaleButton({
    super.key,
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final pressed = useState(false);
    final controller = useAnimationController(duration: const Duration(milliseconds: 100));
    final animationProgress = useAnimation(controller);
    final scale = 1 - animationProgress * 0.1;

    useEffect(
      () {
        if (pressed.value) {
          controller.forward();
        } else {
          controller.reverse();
        }
        return;
      },
      [pressed.value],
    );

    // Scale animation
    return Transform.scale(
      scale: scale,
      child: Listener(
        onPointerDown: (_) {
          pressed.value = true;
        },
        onPointerUp: (PointerUpEvent event) {
          if (!event.position.isOutsideOf(context.findRenderObject() as RenderBox)) {
            onTap.call();
          }

          pressed.value = false;
        },
        onPointerMove: (event) {
          if (event.position.isOutsideOf(context.findRenderObject() as RenderBox)) {
            pressed.value = false;
          } else {
            pressed.value = true;
          }
        },
        child: child,
      ),
    );
  }
}

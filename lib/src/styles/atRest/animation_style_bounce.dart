import 'package:flutter/animation.dart';

import '../../widget_animator.dart';
import '../animation_settings.dart';
import '../animation_style.dart';

/// At rest animation [AnimationStyleBounce] bounces the widget by lifting it up and bouncing it down
class AnimationStyleBounce extends AnimationAtRestStyle {
  @override
  AnimationSettings getSettings(
      WidgetRestingEffects effects, AnimationController animationController) {
    AnimationSettings _animationSettings =
        AnimationSettings(animationController: animationController);

    double strength = -20.0;
    strength = (strength * effects.effectStrength!).clamp(-1000, 1000);

    _animationSettings.offsetYAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: strength)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: strength, end: 0)
              .chain(CurveTween(curve: Curves.bounceOut)),
          weight: 50.0,
        ),
      ],
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));

    return _animationSettings;
  }
}

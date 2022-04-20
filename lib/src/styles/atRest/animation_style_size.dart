import 'package:flutter/animation.dart';

import '../../widget_animator.dart';
import '../animation_settings.dart';
import '../animation_style.dart';

/// At rest animation [AnimationAtRestStyle] changes the size of the widget, small effect strength will shrink the scale (e.g. 0.5), larger numbers will grow the scale (e.g. 2)
class AnimationStyleSize extends AnimationAtRestStyle {
  @override
  AnimationSettings getSettings(
      WidgetRestingEffects effects, AnimationController animationController) {
    AnimationSettings _animationSettings =
        AnimationSettings(animationController: animationController);

    double increaseScale = 1.25;
    increaseScale = (increaseScale * effects.effectStrength!).clamp(-500, 500);

    _animationSettings.scaleAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1, end: increaseScale)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: increaseScale, end: 1)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50.0,
        ),
      ],
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));

    return _animationSettings;
  }
}

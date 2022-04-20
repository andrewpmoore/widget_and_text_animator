import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

import '../../widget_animator.dart';
import '../animation_settings.dart';
import '../animation_style.dart';

/// At rest animation [AnimationStyleWave] which waves the widget up and down
class AnimationStyleWave extends AnimationAtRestStyle {
  @override
  AnimationSettings getSettings(
      WidgetRestingEffects effects, AnimationController animationController) {
    AnimationSettings _animationSettings =
        AnimationSettings(animationController: animationController);

    double offset = 4;
    offset = (offset * effects.effectStrength!).clamp(-200, 200);

    _animationSettings.offsetYAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: -offset)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 25.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -offset, end: offset)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: offset, end: 0)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 25.0,
        ),
      ],
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));

    return _animationSettings;
  }
}

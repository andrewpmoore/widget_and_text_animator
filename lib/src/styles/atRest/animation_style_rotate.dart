import 'package:flutter/animation.dart';
import 'dart:math' as math;

import '../../widget_animator.dart';
import '../animation_settings.dart';
import '../animation_style.dart';

/// At rest animation [AnimationAtRestStyle] rotates the widget around a center axis, using a [Curves.easeInOut] if you want a rest on each rotation
class AnimationStyleRotate extends AnimationAtRestStyle {
  @override
  AnimationSettings getSettings(
      WidgetRestingEffects effects, AnimationController animationController) {
    AnimationSettings _animationSettings =
        AnimationSettings(animationController: animationController);

    _animationSettings.rotationAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: math.pi / 0.5)
              .chain(CurveTween(curve: effects.curve!)),
          weight: 100.0,
        ),
      ],
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));

    return _animationSettings;
  }
}

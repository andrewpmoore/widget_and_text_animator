import 'package:flutter/animation.dart';
import 'dart:math' as math;
import 'package:flutter/widgets.dart';

import '../../widget_animator.dart';
import '../animation_settings.dart';
import '../animation_style.dart';

/// At rest animation [AnimationStyleSwing] rotate the widget back and forward to give it a swinging effect, note a larger effect strength gives a smaller rotation
/// and a smaller effect strength gives a bigger rotation
class AnimationStyleSwing extends AnimationAtRestStyle {
  @override
  AnimationSettings getSettings(
      WidgetRestingEffects effects, AnimationController animationController) {
    AnimationSettings _animationSettings =
        AnimationSettings(animationController: animationController);

    double rotationAmount = 8;
    rotationAmount =
        (-rotationAmount * (effects.effectStrength!)).clamp(-300, 300);

    _animationSettings.rotationAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: math.pi / rotationAmount)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 25.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(
                  begin: math.pi / rotationAmount,
                  end: -math.pi / rotationAmount)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -math.pi / rotationAmount, end: 0)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 25.0,
        ),
      ],
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));

    return _animationSettings;
  }
}

import 'package:flutter/animation.dart';
import 'dart:math' as math;

import '../../widget_animator.dart';
import '../animation_settings.dart';
import '../animation_style.dart';

class AnimationStyleRotate extends AnimationAtRestStyle{
  @override
  AnimationSettings getSettings(WidgetRestingEffects effects, AnimationController animationController) {

    AnimationSettings _animationSettings = AnimationSettings(animationController: animationController);

    _animationSettings.rotationAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: math.pi/0.5)
              .chain(CurveTween(curve: effects.curve!)),
          weight: 100.0,
        ),
      ],
    ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));

    return _animationSettings;

  }

}
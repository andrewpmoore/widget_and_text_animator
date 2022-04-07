import 'package:flutter/animation.dart';

import '../widget_animator.dart';
import 'animation_settings.dart';
import 'animation_style.dart';

class AnimationStylePulse extends AnimationStyle{
  @override
  AnimationSettings getSettings(WidgetRestingEffects effects, AnimationController animationController) {

    AnimationSettings _animationSettings = AnimationSettings(animationController: animationController);

    double strength = 1 - (effects.effectStrength!.clamp(0, 1));

    _animationSettings.opacityAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1, end: strength)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: strength, end: 1)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 50.0,
        ),
      ],
    ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));

    return _animationSettings;

  }

}
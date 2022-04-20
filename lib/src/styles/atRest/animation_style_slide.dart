import 'package:flutter/widgets.dart';

import '../../widget_animator.dart';
import '../animation_settings.dart';
import '../animation_style.dart';

/// At rest animation [AnimationStyleSlide] skew the widget to the right and left on a center axis
class AnimationStyleSlide extends AnimationAtRestStyle {
  @override
  AnimationSettings getSettings(
      WidgetRestingEffects effects, AnimationController animationController) {
    AnimationSettings _animationSettings =
        AnimationSettings(animationController: animationController);

    double skewAmount = 0.2;

    skewAmount = (skewAmount * effects.effectStrength!); //.clamp(-100, 100);
    _animationSettings.skewAlignment = Alignment.center;
    _animationSettings.skewXAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: skewAmount)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 25.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: skewAmount, end: -skewAmount)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -skewAmount, end: 0)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 25.0,
        ),
      ],
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));

    return _animationSettings;
  }
}

import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

import '../../widget_animator.dart';
import '../animation_settings.dart';
import '../animation_style.dart';

/// At rest animation [AnimationStyleFidget] which randomly slightly moves the widget position around
class AnimationStyleFidget extends AnimationAtRestStyle {
  @override
  AnimationSettings getSettings(
      WidgetRestingEffects effects, AnimationController animationController) {
    AnimationSettings _animationSettings =
        AnimationSettings(animationController: animationController);

    double effectStrength = effects.effectStrength!.clamp(0.3, 300);

    Random rnd = Random();
    int min = (-5 * effectStrength).toInt().clamp(-50, 50);
    int max = (5 * effectStrength).toInt().clamp(-50, 50);

    List<TweenSequenceItem<double>> xList = [];
    List<TweenSequenceItem<double>> yList = [];

    int iterations = (_getRandomNumber(3, 10, rnd)).toInt();
    double nextRandom = 0;
    double currentRandom = _getRandomNumber(min, max, rnd);

    xList.add(
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: currentRandom)
            .chain(CurveTween(curve: effects.curve!)),
        weight: 100 / (iterations + 2),
      ),
    );
    for (int i = 0; i < iterations; i++) {
      nextRandom = _getRandomNumber(min, max, rnd);
      xList.add(
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: currentRandom, end: nextRandom)
              .chain(CurveTween(curve: effects.curve!)),
          weight: 100 / (iterations + 2),
        ),
      );
      currentRandom = nextRandom;
    }
    xList.add(
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: currentRandom, end: 0)
            .chain(CurveTween(curve: effects.curve!)),
        weight: 100 / (iterations + 2),
      ),
    );

    iterations = (_getRandomNumber(3, 10, rnd)).toInt();
    nextRandom = 0;
    currentRandom = _getRandomNumber(min, max, rnd);
    yList.add(
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: currentRandom)
            .chain(CurveTween(curve: effects.curve!)),
        weight: 100 / (iterations + 2),
      ),
    );
    for (int i = 0; i < iterations; i++) {
      nextRandom = _getRandomNumber(min, max, rnd);
      yList.add(
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: currentRandom, end: nextRandom)
              .chain(CurveTween(curve: effects.curve!)),
          weight: 100 / (iterations + 2),
        ),
      );
      currentRandom = nextRandom;
    }
    yList.add(
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: currentRandom, end: 0)
            .chain(CurveTween(curve: effects.curve!)),
        weight: 100 / (iterations + 2),
      ),
    );

    _animationSettings.offsetXAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[for (var x in xList) x],
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));

    _animationSettings.offsetYAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[for (var y in yList) y],
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));

    return _animationSettings;
  }

  double _getRandomNumber(int min, int max, Random rnd) {
    return (min + rnd.nextInt(max - min) + rnd.nextDouble());
  }
}

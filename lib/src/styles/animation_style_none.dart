import 'package:flutter/animation.dart';

import '../widget_animator.dart';
import 'animation_settings.dart';
import 'animation_style.dart';

class AnimationStyleNone extends AnimationStyle{
  @override
  AnimationSettings getSettings(WidgetRestingEffects effects, AnimationController animationController) {
    AnimationSettings _animationSettings = AnimationSettings(animationController: animationController);
    return _animationSettings;
  }

}
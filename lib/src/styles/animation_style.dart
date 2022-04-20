import 'package:flutter/material.dart';
import '../../widget_and_text_animator.dart';

/// [AnimationAtRestStyle] base abstract class for all 'At Rest' animation settings to use
abstract class AnimationAtRestStyle {
  AnimationSettings getSettings(
      WidgetRestingEffects effects, AnimationController animationController);
}

/// [AnimationTransitionStyle] base abstract class for all transition animation settings to use
abstract class AnimationTransitionStyle {
  AnimationSettings getSettings(
      WidgetTransitionEffects effects, AnimationController animationController);
}

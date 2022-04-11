import 'package:flutter/material.dart';
import '../../widget_and_text_animator.dart';

abstract class AnimationAtRestStyle {
  AnimationSettings getSettings(WidgetRestingEffects effects, AnimationController animationController);
}

abstract class AnimationTransitionStyle {
  AnimationSettings getSettings(WidgetTransitionEffects effects, AnimationController animationController);
}
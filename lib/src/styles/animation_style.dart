import 'package:flutter/material.dart';

import '../widget_animator.dart';
import 'animation_settings.dart';

abstract class AnimationStyle {
  AnimationSettings getSettings(WidgetRestingEffects effects, AnimationController animationController);
}
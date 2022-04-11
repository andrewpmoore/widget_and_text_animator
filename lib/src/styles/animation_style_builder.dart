import 'package:flutter/animation.dart';

import '../widget_animator.dart';
import 'animation_settings.dart';


typedef AtRestAnimationSettingsBuilder = AnimationSettings Function(WidgetRestingEffects effects, AnimationController animationController);

typedef TransitionAnimationSettingsBuilder = AnimationSettings Function(WidgetTransitionEffects effects, AnimationController animationController);


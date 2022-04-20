import 'package:flutter/animation.dart';

import '../widget_animator.dart';
import 'animation_settings.dart';

/// [AtRestAnimationSettingsBuilder] used for custom builder for 'at rest' animations
typedef AtRestAnimationSettingsBuilder = AnimationSettings Function(
    WidgetRestingEffects effects, AnimationController animationController);

/// [TransitionAnimationSettingsBuilder] used for custom builder for 'transition' animations
typedef TransitionAnimationSettingsBuilder = AnimationSettings Function(
    WidgetTransitionEffects effects, AnimationController animationController);

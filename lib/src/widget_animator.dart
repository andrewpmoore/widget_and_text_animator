import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/src/styles/transitions/animation_incoming_transition_offset_and_scale.dart';
import 'package:widget_and_text_animator/src/styles/transitions/animation_incoming_transition_offset_and_scale_and_step.dart';
import 'package:widget_and_text_animator/src/styles/transitions/animation_outgoing_transition_offset_and_scale.dart';

import 'styles/animation_style_builder.dart';
import 'styles/atRest/animation_style_dangle.dart';
import 'styles/atRest/animation_style_fidget.dart';
import 'styles/atRest/animation_style_none.dart';
import 'styles/atRest/animation_style_pulse.dart';
import 'styles/atRest/animation_style_rotate.dart';
import 'styles/atRest/animation_style_size.dart';
import 'styles/atRest/animation_style_slide.dart';
import 'styles/atRest/animation_style_vibrate.dart';
import 'styles/animation_settings.dart';
import 'styles/atRest/animation_style_bounce.dart';
import 'styles/atRest/animation_style_swing.dart';
import 'styles/atRest/animation_style_wave.dart';

enum _WidgetAnimationStatus {
  incoming,
  rest,
  outgoing,
}

///A range of default effects to show when an widget isn't transitioning and is _at rest_
enum WidgetRestingEffectStyle {
  pulse,
  rotate,
  bounce,
  slide,
  swing,
  wave,
  size,
  fidget,
  dangle,
  vibrate,
  none
}

///Sample transition effects for when widgets are either transitioning in or out
enum WidgetTransitionEffectStyle {
  incomingOffsetAndThenScale,
  incomingOffsetAndThenScaleAndStep,
  outgoingOffsetAndThenScale,
  none
}

///Widget animator is a class you can wrap around any [Widget] to enable a collection of different animations effects to it,
///they are broken down into three categories
/// - Incoming transitions - for when the widget is first rendered onto the screen
/// - At rest animations - which will show once the incoming transition is complete while the widget is active
/// - Outgoing transitions - for when a change is detected (either by the [Key] of the child changing or by the widget type changing)
/// the widget will only change once the outgoing transition has completed
/// All transitions (incoming/at rest/outgoing) are optional
class WidgetAnimator extends StatefulWidget {
  /// [WidgetTransitionEffects] to show when a widget is first rendered
  final WidgetTransitionEffects? incomingEffect;

  /// [WidgetTransitionEffects] to show when a widget is being replaced
  final WidgetTransitionEffects? outgoingEffect;

  /// [WidgetTransitionEffects] to show when a widget is displayed any not transitioning in or out
  final WidgetRestingEffects? atRestEffect;

  /// [Function] callback to call once the incoming animation has completed
  final Function(Key?)? onIncomingAnimationComplete;

  /// [Function] callback to call once the outgoing animation has completed
  final Function(Key?)? onOutgoingAnimationComplete;

  /// [Widget] the child widget to render that requires animating
  final Widget? child;

  /// Constructor for the [WidgetAnimator]
  const WidgetAnimator(
      {Key? key,
      this.incomingEffect,
      this.outgoingEffect,
      this.atRestEffect,
      this.child,
      this.onIncomingAnimationComplete,
      this.onOutgoingAnimationComplete})
      : super(key: key);

  @override
  State<WidgetAnimator> createState() => _WidgetAnimatorState();
}

class _WidgetAnimatorState extends State<WidgetAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late AnimationSettings _animationSettings;

  int atRestNumberOfPlays = 0;

  ///[Widget] child to display at this point in time
  Widget? childToDisplay;

  ///[Widget] child to hold is used to hold a change to a widget while any outgoing animations are played from the previous child widget
  Widget? childToHold;
  WidgetTransitionEffects? outgoingTransitionToHold;
  WidgetTransitionEffects? outgoingTransitionToDisplay;

  Key? widgetKey;

  ///[_WidgetAnimationStatus] to determine which state the animation is currently at (incoming/atRest/outgoing)
  late _WidgetAnimationStatus widgetAnimationStatus;

  @override
  void initState() {
    super.initState();

    ///initialise the animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 0),
      vsync: this,
    );
    _animationSettings =
        AnimationSettings(animationController: _animationController);
    _animationSettings.opacityAnimation = Tween<double>(begin: 0, end: 0)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
    _animationSettings.scaleAnimation = Tween<double>(begin: 1, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationSettings.offsetXAnimation = Tween<double>(begin: 0, end: 0)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
    _animationSettings.offsetYAnimation = Tween<double>(begin: 0, end: 0)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
    _animationSettings.rotationAnimation = Tween<double>(begin: 0, end: 0)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
    _animationSettings.blurXAnimation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationSettings.blurYAnimation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationSettings.skewXAnimation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationSettings.skewYAnimation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));

    widgetKey =
        widget.child?.key ?? const ValueKey('default-widget-animator-key');
    childToDisplay = widget.child;
    outgoingTransitionToDisplay = widget.outgoingEffect;

    _addAnimationListener();
    _initIncoming();
  }

  void _addAnimationListener() {
    _animationController.addStatusListener((status) {
      if (widgetAnimationStatus == _WidgetAnimationStatus.incoming) {
        if (status == AnimationStatus.completed) {
          ///switch from the incoming animation completing to the 'atRest' state
          _initAtRest();
          if (widget.onIncomingAnimationComplete != null &&
              widget.child != null) {
            ///trigger the callback once the incoming animation has completed
            widget.onIncomingAnimationComplete!(widget.child?.key);
          }
        }
      } else if (widgetAnimationStatus == _WidgetAnimationStatus.rest) {
        if (status == AnimationStatus.completed) {
          ///increment the number of times an animation at rest has played
          atRestNumberOfPlays++;
          int target = widget.atRestEffect?.numberOfPlays ?? 0;

          ///work out whether the animation needs to repeat and if it has, whether it's yet reached it's numberOfPlays
          if (target <= 0) {
            //if it's set to -1, then repeat forever
            _animationController.forward(from: 0);
          } else if (atRestNumberOfPlays < target) {
            _animationController.forward(from: 0);
          } else {
            // print('this one plays no more $childToDisplay');
          }
        }
      } else if (widgetAnimationStatus == _WidgetAnimationStatus.outgoing) {
        if (status == AnimationStatus.completed) {
          ///the old outgoing animation has now finished, so take the replacement child at set it to display and trigger any incoming effects
          childToDisplay = childToHold;
          outgoingTransitionToDisplay = outgoingTransitionToHold;
          _initIncoming();
          if (widget.onOutgoingAnimationComplete != null &&
              widget.child != null) {
            ///trigger the callback now the outgoing animation has completed
            widget.onOutgoingAnimationComplete!(widget.child?.key);
          }
        }
      }
    });
  }

  void _initIncoming() async {
    ///Initialise or create the incoming effect and set defaults for items not specified
    WidgetTransitionEffects incomingEffect = widget.incomingEffect ??
        WidgetTransitionEffects(
            opacity: 1000, duration: const Duration(milliseconds: 1));

    Duration incomingDelay =
        incomingEffect.delay ?? const Duration(milliseconds: 0);
    Duration incomingDuration =
        incomingEffect.duration ?? const Duration(milliseconds: 300);
    Curve incomingCurve = incomingEffect.curve ?? Curves.easeInOut;

    ///set the animation status
    widgetAnimationStatus = _WidgetAnimationStatus.incoming;

    ///set the animation to the start and set the duration
    _animationController.value = 0;
    _animationController.duration = Duration(
        milliseconds:
            incomingDuration.inMilliseconds + incomingDelay.inMilliseconds);

    if (incomingEffect.builder != null) {
      ///a builder was supplied so set the animation settings based upon this
      _animationSettings =
          incomingEffect.builder!(incomingEffect, _animationController);
    } else if (incomingEffect.style != WidgetTransitionEffectStyle.none) {
      ///a style for the transition animation was supplied so set the animations settings based on the style
      switch (incomingEffect.style) {
        case WidgetTransitionEffectStyle.incomingOffsetAndThenScale:
          _animationSettings = AnimationIncomingTransitionOffsetAndScale()
              .getSettings(incomingEffect, _animationController);
          break;
        case WidgetTransitionEffectStyle.incomingOffsetAndThenScaleAndStep:
          _animationSettings =
              AnimationIncomingTransitionOffsetAndScaleAndStep()
                  .getSettings(incomingEffect, _animationController);
          break;
        default:
          break;
      }
    } else {
      ///no style was specified, so work through all the transition settings and set a tween sequence for each type
      _animationSettings.opacityAnimation = TweenSequence<double>(
        <TweenSequenceItem<double>>[
          if (incomingDelay.inMilliseconds.toDouble() > 0)
            TweenSequenceItem<double>(
              tween: Tween<double>(begin: 0, end: 0)
                  .chain(CurveTween(curve: Curves.ease)),
              weight: incomingDelay.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive),
            ),
          TweenSequenceItem<double>(
              tween: Tween<double>(begin: 0, end: 1)
                  .chain(CurveTween(curve: incomingCurve)),
              weight: incomingDuration.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive)),
        ],
      ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.linear));

      _animationSettings.scaleAnimation = TweenSequence<double>(
        <TweenSequenceItem<double>>[
          if (incomingDelay.inMilliseconds.toDouble() > 0)
            TweenSequenceItem<double>(
              tween: Tween<double>(
                      begin: incomingEffect.scale ?? 0,
                      end: incomingEffect.scale ?? 0)
                  .chain(CurveTween(curve: Curves.ease)),
              weight: incomingDelay.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive),
            ),
          TweenSequenceItem<double>(
              tween: Tween<double>(begin: incomingEffect.scale ?? 1, end: 1)
                  .chain(CurveTween(curve: incomingCurve)),
              weight: incomingDuration.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive)),
        ],
      ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.linear));

      _animationSettings.offsetXAnimation = TweenSequence<double>(
        <TweenSequenceItem<double>>[
          if (incomingDelay.inMilliseconds.toDouble() > 0)
            TweenSequenceItem<double>(
              tween: Tween<double>(
                      begin: incomingEffect.offset?.dx ?? 0,
                      end: incomingEffect.offset?.dx ?? 0)
                  .chain(CurveTween(curve: Curves.ease)),
              weight: incomingDelay.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive),
            ),
          TweenSequenceItem<double>(
              tween:
                  Tween<double>(begin: incomingEffect.offset?.dx ?? 0, end: 0)
                      .chain(CurveTween(curve: incomingCurve)),
              weight: incomingDuration.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive)),
        ],
      ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.linear));

      _animationSettings.offsetYAnimation = TweenSequence<double>(
        <TweenSequenceItem<double>>[
          if (incomingDelay.inMilliseconds.toDouble() > 0)
            TweenSequenceItem<double>(
              tween: Tween<double>(
                      begin: incomingEffect.offset?.dy ?? 0,
                      end: incomingEffect.offset?.dy ?? 0)
                  .chain(CurveTween(curve: Curves.ease)),
              weight: incomingDelay.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive),
            ),
          TweenSequenceItem<double>(
              tween:
                  Tween<double>(begin: incomingEffect.offset?.dy ?? 0, end: 0)
                      .chain(CurveTween(curve: incomingCurve)),
              weight: incomingDuration.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive)),
        ],
      ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.linear));

      _animationSettings.rotationAnimation = TweenSequence<double>(
        <TweenSequenceItem<double>>[
          if (incomingDelay.inMilliseconds.toDouble() > 0)
            TweenSequenceItem<double>(
              tween: Tween<double>(
                      begin: incomingEffect.rotation ?? 0,
                      end: incomingEffect.rotation ?? 0)
                  .chain(CurveTween(curve: Curves.ease)),
              weight: incomingDelay.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive),
            ),
          TweenSequenceItem<double>(
              tween: Tween<double>(begin: incomingEffect.rotation ?? 0, end: 0)
                  .chain(CurveTween(curve: incomingCurve)),
              weight: incomingDuration.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive)),
        ],
      ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.linear));

      _animationSettings.blurXAnimation = TweenSequence<double>(
        <TweenSequenceItem<double>>[
          if (incomingDelay.inMilliseconds.toDouble() > 0)
            TweenSequenceItem<double>(
              tween: Tween<double>(
                      begin: incomingEffect.blur?.dx ?? 0,
                      end: incomingEffect.blur?.dx ?? 0)
                  .chain(CurveTween(curve: Curves.ease)),
              weight: incomingDelay.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive),
            ),
          TweenSequenceItem<double>(
              tween: Tween<double>(begin: incomingEffect.blur?.dx ?? 0, end: 0)
                  .chain(CurveTween(curve: incomingCurve)),
              weight: incomingDuration.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive)),
        ],
      ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.linear));

      _animationSettings.blurYAnimation = TweenSequence<double>(
        <TweenSequenceItem<double>>[
          if (incomingDelay.inMilliseconds.toDouble() > 0)
            TweenSequenceItem<double>(
              tween: Tween<double>(
                      begin: incomingEffect.blur?.dy ?? 0,
                      end: incomingEffect.blur?.dy ?? 0)
                  .chain(CurveTween(curve: Curves.ease)),
              weight: incomingDelay.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive),
            ),
          TweenSequenceItem<double>(
              tween: Tween<double>(begin: incomingEffect.blur?.dy ?? 0, end: 0)
                  .chain(CurveTween(curve: incomingCurve)),
              weight: incomingDuration.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive)),
        ],
      ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.linear));

      _animationSettings.skewXAnimation = TweenSequence<double>(
        <TweenSequenceItem<double>>[
          if (incomingDelay.inMilliseconds.toDouble() > 0)
            TweenSequenceItem<double>(
              tween: Tween<double>(
                      begin: incomingEffect.skew?.dx ?? 0,
                      end: incomingEffect.skew?.dx ?? 0)
                  .chain(CurveTween(curve: Curves.ease)),
              weight: incomingDelay.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive),
            ),
          TweenSequenceItem<double>(
              tween: Tween<double>(begin: incomingEffect.skew?.dx ?? 0, end: 0)
                  .chain(CurveTween(curve: incomingCurve)),
              weight: incomingDuration.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive)),
        ],
      ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.linear));

      _animationSettings.skewYAnimation = TweenSequence<double>(
        <TweenSequenceItem<double>>[
          if (incomingDelay.inMilliseconds.toDouble() > 0)
            TweenSequenceItem<double>(
              tween: Tween<double>(
                      begin: incomingEffect.skew?.dy ?? 0,
                      end: incomingEffect.skew?.dy ?? 0)
                  .chain(CurveTween(curve: Curves.ease)),
              weight: incomingDelay.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive),
            ),
          TweenSequenceItem<double>(
              tween: Tween<double>(begin: incomingEffect.skew?.dy ?? 0, end: 0)
                  .chain(CurveTween(curve: incomingCurve)),
              weight: incomingDuration.inMilliseconds
                  .toDouble()
                  .clamp(0.0001, double.minPositive)),
        ],
      ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.linear));
    }

    ///play the incoming animation
    _animationController.forward();
  }

  void _initAtRest() async {
    ///Initialise or create the at rest animation and set defaults for items not specified
    WidgetRestingEffects restingEffects = widget.atRestEffect ??
        WidgetRestingEffects(
            style: WidgetRestingEffectStyle.none,
            delay: const Duration(days: 0),
            duration: const Duration(days: 1),
            effectStrength: 1,
            alignment: Alignment.center,
            curve: Curves.linear);

    assert(!(restingEffects.style == null && restingEffects.builder == null),
        'You must specify either a style or a builder, but neither were supplied');
    assert(!(restingEffects.style != null && restingEffects.builder != null),
        'You must specify either a style or a builder, but not both');

    Duration restDuration =
        restingEffects.duration ?? const Duration(milliseconds: 2400);
    restingEffects.effectStrength = restingEffects.effectStrength ?? 1;
    restingEffects.curve = restingEffects.curve ?? Curves.easeInOut;

    if (mounted) {
      setState(() {
        ///change the animate state to atRest
        widgetAnimationStatus = _WidgetAnimationStatus.rest;
      });
    }

    ///set the animation to the start and set it's duration
    _animationController.value = 0;
    _animationController.duration = restDuration;

    if (restingEffects.style != null) {
      ///a style has been specified so make a call to that style to get the animation settings
      switch (restingEffects.style) {
        case WidgetRestingEffectStyle.pulse:
          _animationSettings = AnimationStylePulse()
              .getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.rotate:
          _animationSettings = AnimationStyleRotate()
              .getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.bounce:
          _animationSettings = AnimationStyleBounce()
              .getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.slide:
          _animationSettings = AnimationStyleSlide()
              .getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.dangle:
          _animationSettings = AnimationStyleDangle()
              .getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.swing:
          _animationSettings = AnimationStyleSwing()
              .getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.wave:
          _animationSettings = AnimationStyleWave()
              .getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.size:
          _animationSettings = AnimationStyleSize()
              .getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.fidget:
          _animationSettings = AnimationStyleFidget()
              .getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.vibrate:
          _animationSettings = AnimationStyleVibrate()
              .getSettings(restingEffects, _animationController);
          break;
        default:
          _animationSettings = AnimationStyleNone()
              .getSettings(restingEffects, _animationController);
          break;
      }
    } else {
      ///we don't have a style then we'll have a builder for a custom animation
      _animationSettings =
          restingEffects.builder!(restingEffects, _animationController);
    }

    ///play the animation, unless one isn't required
    if (restingEffects.style != WidgetRestingEffectStyle.none) {
      _animationController.forward();
    }
  }

  void _initOutgoing() async {
    ///Initialise or create the incoming effect and set defaults for items not specified
    WidgetTransitionEffects outgoingEffect = outgoingTransitionToDisplay ??
        WidgetTransitionEffects(
            opacity: 1, duration: const Duration(milliseconds: 1));
    Duration outgoingDuration =
        outgoingEffect.duration ?? const Duration(milliseconds: 300);
    Curve outgoingCurve = outgoingEffect.curve ?? Curves.easeInOut;
    if (mounted) {
      setState(() {
        ///set the animation status to outgoing
        widgetAnimationStatus = _WidgetAnimationStatus.outgoing;
      });
    }

    _animationController.duration = outgoingDuration;

    if (outgoingEffect.builder != null) {
      ///a builder was specified, so use its data as the animation settings
      _animationSettings =
          outgoingEffect.builder!(outgoingEffect, _animationController);
    } else if (outgoingEffect.style != WidgetTransitionEffectStyle.none) {
      ///a style was specified so use this for the animation settings
      switch (outgoingEffect.style) {
        case WidgetTransitionEffectStyle.outgoingOffsetAndThenScale:
          _animationSettings = AnimationOutgoingTransitionOffsetAndScale()
              .getSettings(outgoingEffect, _animationController);
          break;
        default:
          break;
      }
    } else {
      ///no builder or style specified so use the specific properties to set up the animation tween settings
      _animationSettings.opacityAnimation = Tween<double>(
              begin: _animationSettings.opacityAnimation?.value,
              end: outgoingEffect.opacity ?? 0)
          .animate(CurvedAnimation(
              parent: _animationController, curve: outgoingCurve));
      _animationSettings.scaleAnimation = Tween<double>(
              begin: _animationSettings.scaleAnimation?.value,
              end: outgoingEffect.scale ?? 1)
          .animate(CurvedAnimation(
              parent: _animationController, curve: outgoingCurve));
      _animationSettings.offsetXAnimation = Tween<double>(
              begin: _animationSettings.offsetXAnimation?.value,
              end: outgoingEffect.offset?.dx ?? 0)
          .animate(CurvedAnimation(
              parent: _animationController, curve: outgoingCurve));
      _animationSettings.offsetYAnimation = Tween<double>(
              begin: _animationSettings.offsetYAnimation?.value,
              end: outgoingEffect.offset?.dy ?? 0)
          .animate(CurvedAnimation(
              parent: _animationController, curve: outgoingCurve));
      _animationSettings.rotationAnimation = Tween<double>(
              begin: _animationSettings.rotationAnimation?.value,
              end: outgoingEffect.rotation ?? 0)
          .animate(CurvedAnimation(
              parent: _animationController, curve: outgoingCurve));
      _animationSettings.blurXAnimation = Tween<double>(
              begin: _animationSettings.blurXAnimation?.value,
              end: outgoingEffect.blur?.dx ?? 0)
          .animate(CurvedAnimation(
              parent: _animationController, curve: outgoingCurve));
      _animationSettings.blurYAnimation = Tween<double>(
              begin: _animationSettings.blurYAnimation?.value,
              end: outgoingEffect.blur?.dy ?? 0)
          .animate(CurvedAnimation(
              parent: _animationController, curve: outgoingCurve));
      _animationSettings.skewXAnimation = Tween<double>(
              begin: _animationSettings.skewXAnimation?.value,
              end: outgoingEffect.skew?.dx ?? 0)
          .animate(CurvedAnimation(
              parent: _animationController, curve: outgoingCurve));
      _animationSettings.skewYAnimation = Tween<double>(
              begin: _animationSettings.skewYAnimation?.value,
              end: outgoingEffect.skew?.dy ?? 0)
          .animate(CurvedAnimation(
              parent: _animationController, curve: outgoingCurve));
      _animationController.value = 0;
    }

    ///play the outgoing animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  ///the widget has changed (either [Key] or widget type), so store the new details ready for when the previous outgoing animation has completed
  void _widgetChanged() {
    if (mounted) {
      setState(() {
        widgetKey =
            widget.child?.key ?? const ValueKey('default-widget-animator-key');
        childToHold = widget.child;
        outgoingTransitionToHold = widget.outgoingEffect;
      });
    }

    ///start outgoing animation
    _initOutgoing();
  }

  @override
  Widget build(BuildContext context) {
    ///check to see if the widget has changed [Key] or it's type, if it has, trigger a change
    Key widgetChild =
        widget.child?.key ?? const ValueKey('default-widget-animator-key');
    if ((widgetChild != widgetKey) ||
        (widget.child.runtimeType != childToDisplay.runtimeType)) {
      _widgetChanged();
    }

    ///Apply all the effects to the widget based on the tween values
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return _OptionalFiltered(
            blurX: _animationSettings.blurXAnimation!.value,
            blurY: _animationSettings.blurYAnimation!.value,
            child: _OptionalRotate(
              angle: _animationSettings.rotationAnimation!.value,
              child: _OptionalSkew(
                alignment: _animationSettings.skewAlignment,
                skewX: _animationSettings.skewXAnimation!.value,
                skewY: _animationSettings.skewYAnimation!.value,
                child: _OptionalTranslate(
                  offsetX: _animationSettings.offsetXAnimation!.value,
                  offsetY: _animationSettings.offsetYAnimation!.value,
                  child: _OptionalScale(
                    scale: _animationSettings.scaleAnimation!.value,
                    child: _OptionalOpacity(
                      opacity: _animationSettings.opacityAnimation!.value,
                      child: childToDisplay ?? const SizedBox(),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

/// [_OptionalFiltered] this widget will either just pass the child straight through or apply the blur effects if specified
class _OptionalFiltered extends StatelessWidget {
  final Widget child;
  final double blurX;
  final double blurY;
  const _OptionalFiltered(
      {Key? key, required this.child, required this.blurX, required this.blurY})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (blurX > 0 || blurY > 0) {
      return ImageFiltered(
        imageFilter: ImageFilter.blur(
            sigmaX: blurX.clamp(0.001, 1000), sigmaY: blurY.clamp(0.001, 1000)),
        child: child,
      );
    } else {
      return child;
    }
  }
}

/// [_OptionalTranslate] this widget will either just pass the child straight through or apply the offset effects if specified
class _OptionalTranslate extends StatelessWidget {
  final Widget child;
  final double offsetX;
  final double offsetY;
  const _OptionalTranslate(
      {Key? key,
      required this.child,
      required this.offsetX,
      required this.offsetY})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (offsetX != 0 || offsetY != 0) {
      return Transform.translate(
        offset: Offset(offsetX, offsetY),
        child: child,
      );
    } else {
      return child;
    }
  }
}

/// [_OptionalSkew] this widget will either just pass the child straight through or apply the skew effects if specified
class _OptionalSkew extends StatelessWidget {
  final Widget child;
  final double skewX;
  final double skewY;
  final Alignment? alignment;
  const _OptionalSkew(
      {Key? key,
      required this.child,
      required this.skewX,
      required this.skewY,
      this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (skewX != 0 || skewY != 0) {
      return Transform(
        transform: Matrix4.skew(
          skewX.clamp(-2, 2),
          skewY.clamp(-2, 2),
        ),
        alignment: alignment,
        child: child,
      );
    } else {
      return child;
    }
  }
}

/// [_OptionalRotate] this widget will either just pass the child straight through or apply the rotation effects if specified
class _OptionalRotate extends StatelessWidget {
  final Widget child;
  final double angle;
  const _OptionalRotate({Key? key, required this.child, required this.angle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (angle != 0) {
      return Transform.rotate(
        angle: angle,
        child: child,
      );
    } else {
      return child;
    }
  }
}

/// [_OptionalScale] this widget will either just pass the child straight through or apply the scale effects if specified
class _OptionalScale extends StatelessWidget {
  final Widget child;
  final double scale;
  const _OptionalScale({Key? key, required this.child, required this.scale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (scale != 1) {
      return Transform.scale(
        scale: scale,
        child: child,
      );
    } else {
      return child;
    }
  }
}

/// [_OptionalOpacity] this widget will either just pass the child straight through or apply the opacity effects if specified
class _OptionalOpacity extends StatelessWidget {
  final Widget child;
  final double opacity;
  const _OptionalOpacity({Key? key, required this.child, required this.opacity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (opacity != 1) {
      return Opacity(
        opacity: opacity.clamp(0, 1),
        child: child,
      );
    } else {
      return child;
    }
  }
}

///Class for setting up the incoming or outgoing transition effects
class WidgetTransitionEffects {
  /// [Offset] set up the offset from the position that the widget would normally render, e.g. Offset(50, 20) would render 50 pixels to the right and 20 below the normal location
  /// Offset(-50, -20) would render 50 pixels to the left and 20 above the normal location
  final Offset? offset;

  /// [Offset] Skew, the amount of skew on the X and Y axis e.g. Offset(0.2, 0.5) would be a skew of 0.2 on the X axis and 0.5 on the Y axis
  final Offset? skew;

  /// [double] The scale proportion compared to the widgets normal size, the default scale is 1.25x the normal size, use smaller numbers such as 0.5 to decrease the size and values larger
  /// then one to increase the size
  final double? scale;

  /// [Offset] Blur, the amount of blur on the X and Y axis e.g. Offset(2, 5) would be a blur of 2 on the X axis
  /// and 5 on the Y axis, note that this effect can be quite performance intensive, so try to limit the amount it's used
  final Offset? blur;

  /// [double] The rotation in radians, so math.pi/0.5 will rotate a full circle, math.pi/6 will rotate a small amount
  final double? rotation;

  /// [double] an opacity range from 0..1
  final double? opacity;

  /// [Curve] A curve for the animation tween the play
  final Curve? curve;

  /// [TransitionAnimationSettingsBuilder] The builder allows you to create your own custom combinations of the above properties for maximum flexibility,
  /// returns a [TransitionAnimationSettingsBuilder] see the samples.dart in the examples project for an example of using the builder
  TransitionAnimationSettingsBuilder? builder;

  /// [Duration] the duration that the transition effect will play for
  final Duration? duration;

  /// [Duration] a delay before playing the transition effect
  final Duration? delay;

  /// [WidgetTransitionEffectStyle] style for the potential for more complex animation timings
  final WidgetTransitionEffectStyle style;

  static Duration defaultDuration = const Duration(milliseconds: 300);

  ///Widget transition effect constructor where a style is passed in
  @protected
  WidgetTransitionEffects.withStyle(
      {this.offset,
      this.opacity,
      this.scale,
      this.blur,
      this.rotation,
      this.curve,
      this.skew,
      this.duration,
      this.delay,
      this.builder,
      required this.style});

  ///Default constructor with the ability to specify and values available)
  WidgetTransitionEffects(
      {this.offset,
      this.opacity,
      this.scale,
      this.blur,
      this.rotation,
      this.curve,
      this.skew,
      this.duration,
      this.delay,
      this.builder})
      : style = WidgetTransitionEffectStyle.none;

  ///Default scale for reducing scale from 3x down to the original size
  WidgetTransitionEffects.incomingScaleDown(
      {this.offset,
      this.opacity,
      this.blur,
      this.rotation,
      this.curve,
      this.skew,
      this.delay,
      this.duration})
      : scale = 3,
        style = WidgetTransitionEffectStyle.none;

  ///Default scale for increasing scale from 0x size to 1x size
  WidgetTransitionEffects.incomingScaleUp(
      {this.offset,
      this.opacity,
      this.blur,
      this.rotation,
      this.curve,
      this.skew,
      this.delay,
      this.duration})
      : scale = 0,
        style = WidgetTransitionEffectStyle.none;

  ///Scale down the text to 0 scale when outgoing
  WidgetTransitionEffects.outgoingScaleDown(
      {this.offset,
      this.opacity,
      this.blur,
      this.rotation,
      this.curve,
      this.skew,
      this.delay,
      this.duration})
      : scale = 0,
        style = WidgetTransitionEffectStyle.none;

  ///Scale up the text to 3x scale when outgoing
  WidgetTransitionEffects.outgoingScaleUp(
      {this.offset,
      this.opacity,
      this.blur,
      this.rotation,
      this.curve,
      this.skew,
      this.delay,
      this.duration})
      : scale = 3,
        style = WidgetTransitionEffectStyle.none;

  ///Slide widget in from the left by 150 offset
  WidgetTransitionEffects.incomingSlideInFromLeft(
      {this.opacity,
      this.rotation,
      this.skew,
      this.delay,
      this.scale,
      this.curve,
      this.blur,
      this.duration})
      : offset = const Offset(-150, 0),
        style = WidgetTransitionEffectStyle.none;

  ///Slide widget in from the right by 150 offset
  WidgetTransitionEffects.incomingSlideInFromRight(
      {this.opacity,
      this.rotation,
      this.skew,
      this.delay,
      this.scale,
      this.curve,
      this.blur,
      this.duration})
      : offset = const Offset(150, 0),
        style = WidgetTransitionEffectStyle.none;

  ///Slide widget in from the top by 150 offset
  WidgetTransitionEffects.incomingSlideInFromTop(
      {this.opacity,
      this.rotation,
      this.skew,
      this.delay,
      this.scale,
      this.curve,
      this.blur,
      this.duration})
      : offset = const Offset(0, -150),
        style = WidgetTransitionEffectStyle.none;

  ///Slide widget in from the bottom by 150 offset
  WidgetTransitionEffects.incomingSlideInFromBottom(
      {this.opacity,
      this.rotation,
      this.skew,
      this.delay,
      this.scale,
      this.curve,
      this.blur,
      this.duration})
      : offset = const Offset(0, 150),
        style = WidgetTransitionEffectStyle.none;

  ///Slide widget out to the left by 150 offset
  WidgetTransitionEffects.outgoingSlideOutToLeft(
      {this.opacity,
      this.rotation,
      this.skew,
      this.delay,
      this.scale,
      this.curve,
      this.blur,
      this.duration})
      : offset = const Offset(-150, 0),
        style = WidgetTransitionEffectStyle.none;

  ///Slide widget out to the right by 150 offset
  WidgetTransitionEffects.outgoingSlideOutToRight(
      {this.opacity,
      this.rotation,
      this.skew,
      this.delay,
      this.scale,
      this.curve,
      this.blur,
      this.duration})
      : offset = const Offset(150, 0),
        style = WidgetTransitionEffectStyle.none;

  ///Slide widget out to the top by 150 offset
  WidgetTransitionEffects.outgoingSlideOutToTop(
      {this.opacity,
      this.rotation,
      this.skew,
      this.delay,
      this.scale,
      this.curve,
      this.blur,
      this.duration})
      : offset = const Offset(0, -150),
        style = WidgetTransitionEffectStyle.none;

  ///Slide widget out to the bottom by 150 offset
  WidgetTransitionEffects.outgoingSlideOutToBottom(
      {this.opacity,
      this.rotation,
      this.skew,
      this.delay,
      this.scale,
      this.curve,
      this.blur,
      this.duration})
      : offset = const Offset(0, 150),
        style = WidgetTransitionEffectStyle.none;

  ///Move up into standard position and scale
  WidgetTransitionEffects.incomingOffsetThenScale({this.duration, this.delay})
      : style = WidgetTransitionEffectStyle.incomingOffsetAndThenScale,
        rotation = 0,
        scale = 1,
        skew = const Offset(0, 0),
        blur = const Offset(0, 0),
        offset = const Offset(0, 0),
        opacity = 1,
        curve = Curves.linear;

  ///Move up slightly above standard position and scale, then jump down to standard location
  WidgetTransitionEffects.incomingOffsetThenScaleAndStep(
      {this.duration, this.delay})
      : style = WidgetTransitionEffectStyle.incomingOffsetAndThenScaleAndStep,
        rotation = 0,
        scale = 1,
        skew = const Offset(0, 0),
        blur = const Offset(0, 0),
        offset = const Offset(0, 0),
        opacity = 1,
        curve = Curves.linear;

  ///Move down and scale
  WidgetTransitionEffects.outgoingOffsetThenScale({this.duration, this.delay})
      : style = WidgetTransitionEffectStyle.outgoingOffsetAndThenScale,
        rotation = 0,
        scale = 1,
        skew = const Offset(0, 0),
        blur = const Offset(0, 0),
        offset = const Offset(0, 0),
        opacity = 1,
        curve = Curves.linear;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WidgetTransitionEffects &&
          runtimeType == other.runtimeType &&
          offset == other.offset &&
          scale == other.scale &&
          opacity == other.opacity &&
          builder == other.builder &&
          blur == other.blur &&
          skew == other.skew &&
          rotation == other.rotation &&
          duration == other.duration &&
          delay == other.delay &&
          curve == other.curve;

  @override
  int get hashCode =>
      offset.hashCode ^
      builder.hashCode ^
      scale.hashCode ^
      duration.hashCode ^
      delay.hashCode ^
      skew.hashCode ^
      opacity.hashCode ^
      blur.hashCode ^
      rotation.hashCode ^
      curve.hashCode;
}

///Class for setting up the animation effects to play while the widget is not transitioning on or off the screen
class WidgetRestingEffects {
  /// [WidgetRestingEffectStyle] specify either a style or a builder, a _style_ is selected from the Enum from the default options available
  WidgetRestingEffectStyle? style;

  /// [AtRestAnimationSettingsBuilder] The builder allows you to create your own custom combinations of the above properties for maximum flexibility,
  /// returns a [AtRestAnimationSettingsBuilder] see the samples.dart in the examples project for an example of using the builder
  AtRestAnimationSettingsBuilder? builder;

  /// The [Duration] to play the _at rest_ animation for
  Duration? duration;

  /// The animation [Curve] to use
  Curve? curve;

  /// The number of times the animation should play for, will default to repeat if not specified (or the number of plays <= 0)
  int? numberOfPlays;

  /// The alignment of the effect, only used for the skew effect
  Alignment? alignment;

  /// [double] The effect strength, varies depending on the style, but allows for larger or smaller version of the default effect. The default value being 1.
  /// So for example, if you wanted a larger scaling effect you could specify a larger effect strength (e.g. 2) and for smaller effects you could specify a smaller number (e.g. 0.5)
  double? effectStrength;
  Duration? delay;

  ///Default constructor for `at rest` animations
  WidgetRestingEffects(
      {this.style,
      this.builder,
      this.duration,
      this.alignment,
      this.curve,
      this.numberOfPlays,
      this.effectStrength,
      this.delay});

  ///Constructor to wave the text up and down
  WidgetRestingEffects.wave(
      {this.builder,
      this.duration,
      this.alignment,
      this.curve,
      this.numberOfPlays,
      this.effectStrength,
      this.delay})
      : style = WidgetRestingEffectStyle.wave;

  ///Constructor to pulse the opacity of the widget
  WidgetRestingEffects.pulse(
      {this.builder,
      this.duration,
      this.alignment,
      this.curve,
      this.numberOfPlays,
      this.effectStrength,
      this.delay})
      : style = WidgetRestingEffectStyle.pulse;

  ///Constructor to rotate the widget
  WidgetRestingEffects.rotate(
      {this.builder,
      this.duration,
      this.alignment,
      this.curve,
      this.numberOfPlays,
      this.effectStrength,
      this.delay})
      : style = WidgetRestingEffectStyle.rotate;

  ///Constructor bounce the widget up and down
  WidgetRestingEffects.bounce(
      {this.builder,
      this.duration,
      this.alignment,
      this.curve,
      this.numberOfPlays,
      this.effectStrength,
      this.delay})
      : style = WidgetRestingEffectStyle.bounce;

  ///Constructor to slide the widget side-to-side with a skew effect
  WidgetRestingEffects.slide(
      {this.builder,
      this.duration,
      this.alignment,
      this.curve,
      this.numberOfPlays,
      this.effectStrength,
      this.delay})
      : style = WidgetRestingEffectStyle.slide;

  ///Constructor to swing the widget with rotation side-to-side
  WidgetRestingEffects.swing(
      {this.builder,
      this.duration,
      this.alignment,
      this.curve,
      this.numberOfPlays,
      this.effectStrength,
      this.delay})
      : style = WidgetRestingEffectStyle.swing;

  ///Constructor to scale up and down the size of the widget
  WidgetRestingEffects.size(
      {this.builder,
      this.duration,
      this.alignment,
      this.curve,
      this.numberOfPlays,
      this.effectStrength,
      this.delay})
      : style = WidgetRestingEffectStyle.size;

  ///Constructor randomly move the widget on the X and Y axis from its standard position
  WidgetRestingEffects.fidget(
      {this.builder,
      this.duration,
      this.alignment,
      this.curve,
      this.numberOfPlays,
      this.effectStrength,
      this.delay})
      : style = WidgetRestingEffectStyle.fidget;

  ///Constructor to dangle the widget using skew from the top of the widget
  WidgetRestingEffects.dangle(
      {this.builder,
      this.duration,
      this.alignment,
      this.curve,
      this.numberOfPlays,
      this.effectStrength,
      this.delay})
      : style = WidgetRestingEffectStyle.dangle;

  ///Constructor to randomly vibrate the widget position in a sudden stepped movement
  WidgetRestingEffects.vibrate(
      {this.builder,
      this.duration,
      this.alignment,
      this.curve,
      this.numberOfPlays,
      this.effectStrength,
      this.delay})
      : style = WidgetRestingEffectStyle.vibrate;

  ///Constructor for no `at rest` effect
  WidgetRestingEffects.none(
      {this.builder,
      this.duration,
      this.alignment,
      this.curve,
      this.numberOfPlays,
      this.effectStrength,
      this.delay})
      : style = WidgetRestingEffectStyle.none;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WidgetRestingEffects &&
          runtimeType == other.runtimeType &&
          style == other.style &&
          builder == other.builder &&
          duration == other.duration &&
          curve == other.curve &&
          numberOfPlays == other.numberOfPlays &&
          alignment == other.alignment &&
          effectStrength == other.effectStrength &&
          delay == other.delay;

  @override
  int get hashCode =>
      style.hashCode ^
      builder.hashCode ^
      duration.hashCode ^
      alignment.hashCode ^
      curve.hashCode ^
      numberOfPlays.hashCode ^
      effectStrength.hashCode ^
      delay.hashCode;
}

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


enum WidgetTransitionEffectStyle {
  incomingOffsetAndThenScale,
  incomingOffsetAndThenScaleAndStep,
  outgoingOffsetAndThenScale,
  none
}

class WidgetAnimator extends StatefulWidget {

  final WidgetTransitionEffects? incomingEffect;
  final WidgetTransitionEffects? outgoingEffect;
  final WidgetRestingEffects? atRestEffect;

  final Function(Key?)? onIncomingAnimationComplete;
  final Function(Key?)? onOutgoingAnimationComplete;

  final Widget? child;

  const WidgetAnimator({Key? key, this.incomingEffect, this.outgoingEffect, this.atRestEffect, this.child, this.onIncomingAnimationComplete, this.onOutgoingAnimationComplete}) : super(key: key);

  @override
  State<WidgetAnimator> createState() => _WidgetAnimatorState();
}

class _WidgetAnimatorState extends State<WidgetAnimator> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late AnimationSettings _animationSettings;

  int atRestNumberOfPlays = 0;


  Widget? childToDisplay;
  Widget? childToHold;
  WidgetTransitionEffects? outgoingTransitionToHold;
  WidgetTransitionEffects? outgoingTransitionToDisplay;

  Key? widgetKey;

  late _WidgetAnimationStatus widgetAnimationStatus;

  @override
  void initState() {

    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 0),vsync: this,);
    _animationSettings = AnimationSettings(animationController: _animationController);
    _animationSettings.opacityAnimation = Tween<double>(begin: 0, end: 0).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationSettings.scaleAnimation = Tween<double>(begin: 1, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationSettings.offsetXAnimation = Tween<double>(begin: 0, end: 0).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationSettings.offsetYAnimation = Tween<double>(begin: 0, end: 0).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationSettings.rotationAnimation = Tween<double>(begin: 0, end: 0).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationSettings.blurXAnimation = Tween<double>(begin: 0, end: 0).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationSettings.blurYAnimation = Tween<double>(begin: 0, end: 0).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationSettings.skewXAnimation = Tween<double>(begin: 0, end: 0).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationSettings.skewYAnimation = Tween<double>(begin: 0, end: 0).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));

    widgetKey = widget.child?.key ?? const ValueKey('default-widget-animator-key');
    childToDisplay = widget.child;
    outgoingTransitionToDisplay = widget.outgoingEffect;

    _addAnimationListener();
    _initIncoming();
  }



  void _addAnimationListener() {
    _animationController.addStatusListener((status) {
      if (widgetAnimationStatus == _WidgetAnimationStatus.incoming) {
        if (status == AnimationStatus.completed) {
            _initAtRest();
            if (widget.onIncomingAnimationComplete!=null && widget.child!=null) {
              widget.onIncomingAnimationComplete!(widget.child?.key);
            }
        }

      } else if (widgetAnimationStatus == _WidgetAnimationStatus.rest) {
        if (status == AnimationStatus.completed) {
          atRestNumberOfPlays++;
          int target = widget.atRestEffect?.numberOfPlays ?? 0;

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
          childToDisplay = childToHold;
          outgoingTransitionToDisplay = outgoingTransitionToHold;
          _initIncoming();
          if (widget.onOutgoingAnimationComplete!=null && widget.child!=null) {
            widget.onOutgoingAnimationComplete!(widget.child?.key);
          }
        }
      }
    });
  }

  void _initIncoming() async{
    WidgetTransitionEffects incomingEffect = widget.incomingEffect ?? WidgetTransitionEffects(opacity: 1000, duration: const Duration(milliseconds: 1));

    Duration incomingDelay = incomingEffect.delay??const Duration(milliseconds: 0);
    Duration incomingDuration = incomingEffect.duration ??  const Duration(milliseconds: 300);
    Curve incomingCurve = incomingEffect.curve ?? Curves.easeInOut;
    widgetAnimationStatus = _WidgetAnimationStatus.incoming;

    _animationController.value = 0;
    _animationController.duration = Duration(milliseconds: incomingDuration.inMilliseconds + incomingDelay.inMilliseconds);

    if (incomingEffect.builder!=null){
      _animationSettings = incomingEffect.builder!(incomingEffect, _animationController);
    }
    else if (incomingEffect.style!=WidgetTransitionEffectStyle.none){
      switch (incomingEffect.style){
        case WidgetTransitionEffectStyle.incomingOffsetAndThenScale:
          _animationSettings = AnimationIncomingTransitionOffsetAndScale().getSettings(incomingEffect, _animationController);
          break;
        case WidgetTransitionEffectStyle.incomingOffsetAndThenScaleAndStep:
          _animationSettings = AnimationIncomingTransitionOffsetAndScaleAndStep().getSettings(incomingEffect, _animationController);
          break;
        default:
          break;
      }
    }
    else {
      _animationSettings.opacityAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
        if (incomingDelay.inMilliseconds.toDouble() > 0) TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 0).chain(CurveTween(curve: Curves.ease)), weight: incomingDelay.inMilliseconds.toDouble(),),
        TweenSequenceItem<double>(tween: Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: incomingCurve)), weight: incomingDuration.inMilliseconds.toDouble()),
      ],
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));

      _animationSettings.scaleAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
        if (incomingDelay.inMilliseconds.toDouble() > 0) TweenSequenceItem<double>(
          tween: Tween<double>(begin: incomingEffect.scale ?? 0, end: incomingEffect.scale ?? 0).chain(CurveTween(curve: Curves.ease)), weight: incomingDelay.inMilliseconds.toDouble(),),
        TweenSequenceItem<double>(tween: Tween<double>(begin: incomingEffect.scale ?? 1, end: 1).chain(CurveTween(curve: incomingCurve)), weight: incomingDuration.inMilliseconds.toDouble()),
      ],
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));

      _animationSettings.offsetXAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
        if (incomingDelay.inMilliseconds.toDouble() > 0) TweenSequenceItem<double>(
          tween: Tween<double>(begin: incomingEffect.offset?.dx ?? 0, end: incomingEffect.offset?.dx ?? 0).chain(CurveTween(curve: Curves.ease)), weight: incomingDelay.inMilliseconds.toDouble(),),
        TweenSequenceItem<double>(tween: Tween<double>(begin: incomingEffect.offset?.dx ?? 0, end: 0).chain(CurveTween(curve: incomingCurve)), weight: incomingDuration.inMilliseconds.toDouble()),
      ],
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));

      _animationSettings.offsetYAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
        if (incomingDelay.inMilliseconds.toDouble() > 0) TweenSequenceItem<double>(
          tween: Tween<double>(begin: incomingEffect.offset?.dy ?? 0, end: incomingEffect.offset?.dy ?? 0).chain(CurveTween(curve: Curves.ease)), weight: incomingDelay.inMilliseconds.toDouble(),),
        TweenSequenceItem<double>(tween: Tween<double>(begin: incomingEffect.offset?.dy ?? 0, end: 0).chain(CurveTween(curve: incomingCurve)), weight: incomingDuration.inMilliseconds.toDouble()),
      ],
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));

      _animationSettings.rotationAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
        if (incomingDelay.inMilliseconds.toDouble() > 0) TweenSequenceItem<double>(
          tween: Tween<double>(begin: incomingEffect.rotation ?? 0, end: incomingEffect.rotation ?? 0).chain(CurveTween(curve: Curves.ease)), weight: incomingDelay.inMilliseconds.toDouble(),),
        TweenSequenceItem<double>(tween: Tween<double>(begin: incomingEffect.rotation ?? 0, end: 0).chain(CurveTween(curve: incomingCurve)), weight: incomingDuration.inMilliseconds.toDouble()),
      ],
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));

      _animationSettings.blurXAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
        if (incomingDelay.inMilliseconds.toDouble() > 0) TweenSequenceItem<double>(
          tween: Tween<double>(begin: incomingEffect.blur?.dx ?? 0, end: incomingEffect.blur?.dx ?? 0).chain(CurveTween(curve: Curves.ease)), weight: incomingDelay.inMilliseconds.toDouble(),),
        TweenSequenceItem<double>(tween: Tween<double>(begin: incomingEffect.blur?.dx ?? 0, end: 0).chain(CurveTween(curve: incomingCurve)), weight: incomingDuration.inMilliseconds.toDouble()),
      ],
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));

      _animationSettings.blurYAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
        if (incomingDelay.inMilliseconds.toDouble() > 0) TweenSequenceItem<double>(
          tween: Tween<double>(begin: incomingEffect.blur?.dy ?? 0, end: incomingEffect.blur?.dy ?? 0).chain(CurveTween(curve: Curves.ease)), weight: incomingDelay.inMilliseconds.toDouble(),),
        TweenSequenceItem<double>(tween: Tween<double>(begin: incomingEffect.blur?.dy ?? 0, end: 0).chain(CurveTween(curve: incomingCurve)), weight: incomingDuration.inMilliseconds.toDouble()),
      ],
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));

      _animationSettings.skewXAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
        if (incomingDelay.inMilliseconds.toDouble() > 0) TweenSequenceItem<double>(
          tween: Tween<double>(begin: incomingEffect.skew?.dx ?? 0, end: incomingEffect.skew?.dx ?? 0).chain(CurveTween(curve: Curves.ease)), weight: incomingDelay.inMilliseconds.toDouble(),),
        TweenSequenceItem<double>(tween: Tween<double>(begin: incomingEffect.skew?.dx ?? 0, end: 0).chain(CurveTween(curve: incomingCurve)), weight: incomingDuration.inMilliseconds.toDouble()),
      ],
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));


      _animationSettings.skewYAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
        if (incomingDelay.inMilliseconds.toDouble() > 0) TweenSequenceItem<double>(
          tween: Tween<double>(begin: incomingEffect.skew?.dy ?? 0, end: incomingEffect.skew?.dy ?? 0).chain(CurveTween(curve: Curves.ease)), weight: incomingDelay.inMilliseconds.toDouble(),),
        TweenSequenceItem<double>(tween: Tween<double>(begin: incomingEffect.skew?.dy ?? 0, end: 0).chain(CurveTween(curve: incomingCurve)), weight: incomingDuration.inMilliseconds.toDouble()),
      ],
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
    }

    _animationController.forward();


  }

  void _initAtRest() async {

    WidgetRestingEffects restingEffects = widget.atRestEffect ?? WidgetRestingEffects(style: WidgetRestingEffectStyle.none, delay: const Duration(days: 0), duration: const Duration(days: 1), effectStrength: 1, alignment: Alignment.center, curve: Curves.linear);

    assert(!(restingEffects.style==null&&restingEffects.builder==null), 'You must specify either a style or a builder, but neither were supplied');
    assert(!(restingEffects.style!=null&&restingEffects.builder!=null), 'You must specify either a style or a builder, but not both');

    Duration restDuration = restingEffects.duration ??  const Duration(milliseconds: 2400);
    restingEffects.effectStrength = restingEffects.effectStrength ?? 1;
    restingEffects.curve = restingEffects.curve ?? Curves.easeInOut;

    if (mounted) {
      setState(() {
        widgetAnimationStatus = _WidgetAnimationStatus.rest;
      });
    }


    _animationController.value = 0;
    _animationController.duration = restDuration;



    if (restingEffects.style!=null) {
      switch (restingEffects.style) {
        case WidgetRestingEffectStyle.pulse:
          _animationSettings = AnimationStylePulse().getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.rotate:
          _animationSettings = AnimationStyleRotate().getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.bounce:
          _animationSettings = AnimationStyleBounce().getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.slide:
          _animationSettings = AnimationStyleSlide().getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.dangle:
          _animationSettings = AnimationStyleDangle().getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.swing:
          _animationSettings = AnimationStyleSwing().getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.wave:
          _animationSettings = AnimationStyleWave().getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.size:
          _animationSettings = AnimationStyleSize().getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.fidget:
          _animationSettings = AnimationStyleFidget().getSettings(restingEffects, _animationController);
          break;
        case WidgetRestingEffectStyle.vibrate:
          _animationSettings = AnimationStyleVibrate().getSettings(restingEffects, _animationController);
          break;
        default:
          _animationSettings = AnimationStyleNone().getSettings(restingEffects, _animationController);
          break;
      }
    }
    else{
      //if we don't have a style then we should have a builder for a custom animation
      _animationSettings = restingEffects.builder!(restingEffects, _animationController);
    }

    if (restingEffects.style!=WidgetRestingEffectStyle.none) {
      _animationController.forward();
    }
  }

  void _initOutgoing() async{
    WidgetTransitionEffects outgoingEffect = outgoingTransitionToDisplay ?? WidgetTransitionEffects(opacity: 1, duration: const Duration(milliseconds: 1));
    Duration outgoingDuration = outgoingEffect.duration ??  const Duration(milliseconds: 300);
    Curve outgoingCurve = outgoingEffect.curve ?? Curves.easeInOut;
    if (mounted) {
      setState(() {
        widgetAnimationStatus = _WidgetAnimationStatus.outgoing;
      });
    }

    _animationController.duration = outgoingDuration;

    if (outgoingEffect.builder!=null){
      _animationSettings = outgoingEffect.builder!(outgoingEffect, _animationController);
    }
    else if (outgoingEffect.style!=WidgetTransitionEffectStyle.none){
      switch (outgoingEffect.style){
        case WidgetTransitionEffectStyle.outgoingOffsetAndThenScale:
          _animationSettings = AnimationOutgoingTransitionOffsetAndScale().getSettings(outgoingEffect, _animationController);
          break;
        default:
          break;
      }
    }

    else {
      _animationSettings.opacityAnimation =
          Tween<double>(begin: _animationSettings.opacityAnimation?.value, end: outgoingEffect.opacity ?? 0).animate(CurvedAnimation(parent: _animationController, curve: outgoingCurve));
      _animationSettings.scaleAnimation =
          Tween<double>(begin: _animationSettings.scaleAnimation?.value, end: outgoingEffect.scale ?? 1).animate(CurvedAnimation(parent: _animationController, curve: outgoingCurve));
      _animationSettings.offsetXAnimation =
          Tween<double>(begin: _animationSettings.offsetXAnimation?.value, end: outgoingEffect.offset?.dx ?? 0).animate(CurvedAnimation(parent: _animationController, curve: outgoingCurve));
      _animationSettings.offsetYAnimation =
          Tween<double>(begin: _animationSettings.offsetYAnimation?.value, end: outgoingEffect.offset?.dy ?? 0).animate(CurvedAnimation(parent: _animationController, curve: outgoingCurve));
      _animationSettings.rotationAnimation =
          Tween<double>(begin: _animationSettings.rotationAnimation?.value, end: outgoingEffect.rotation ?? 0).animate(CurvedAnimation(parent: _animationController, curve: outgoingCurve));
      _animationSettings.blurXAnimation =
          Tween<double>(begin: _animationSettings.blurXAnimation?.value, end: outgoingEffect.blur?.dx ?? 0).animate(CurvedAnimation(parent: _animationController, curve: outgoingCurve));
      _animationSettings.blurYAnimation =
          Tween<double>(begin: _animationSettings.blurYAnimation?.value, end: outgoingEffect.blur?.dy ?? 0).animate(CurvedAnimation(parent: _animationController, curve: outgoingCurve));
      _animationSettings.skewXAnimation =
          Tween<double>(begin: _animationSettings.skewXAnimation?.value, end: outgoingEffect.skew?.dx ?? 0).animate(CurvedAnimation(parent: _animationController, curve: outgoingCurve));
      _animationSettings.skewYAnimation =
          Tween<double>(begin: _animationSettings.skewYAnimation?.value, end: outgoingEffect.skew?.dy ?? 0).animate(CurvedAnimation(parent: _animationController, curve: outgoingCurve));
      _animationController.value = 0;
    }

    _animationController.forward();

  }



  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _widgetChanged(){
    if (mounted) {
      setState(() {
        widgetKey = widget.child?.key ?? const ValueKey('default-widget-animator-key');
        childToHold = widget.child;
        outgoingTransitionToHold = widget.outgoingEffect;
      });
    }
    _initOutgoing();
  }


  @override
  Widget build(BuildContext context) {

    Key widgetChild = widget.child?.key??const ValueKey('default-widget-animator-key');
    if ((widgetChild!=widgetKey)||(widget.child.runtimeType!=childToDisplay.runtimeType)){
      _widgetChanged();
    }

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
                skewX: _animationSettings.skewXAnimation!.value, skewY: _animationSettings.skewYAnimation!.value,
                child: _OptionalTranslate(
                  offsetX: _animationSettings.offsetXAnimation!.value,
                  offsetY: _animationSettings.offsetYAnimation!.value,
                  child: _OptionalScale(
                    scale: _animationSettings.scaleAnimation!.value,
                    child: _OptionalOpacity(
                      opacity: _animationSettings.opacityAnimation!.value,
                      child: childToDisplay??const SizedBox(),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}


class _OptionalFiltered extends StatelessWidget {
  final Widget child;
  final double blurX;
  final double blurY;
  const _OptionalFiltered({Key? key, required this.child, required this.blurX, required this.blurY}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (blurX>0||blurY>0){
      return ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blurX, sigmaY: blurY),
        child: child,
      );
    }
    else{
      return child;
    }
  }
}

class _OptionalTranslate extends StatelessWidget {
  final Widget child;
  final double offsetX;
  final double offsetY;
  const _OptionalTranslate({Key? key, required this.child, required this.offsetX, required this.offsetY}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (offsetX!=0||offsetY!=0){
      return Transform.translate(
        offset: Offset(offsetX, offsetY),
        child: child,
      );
    }
    else{
      return child;
    }
  }
}


class _OptionalSkew extends StatelessWidget {
  final Widget child;
  final double skewX;
  final double skewY;
  final Alignment? alignment;
  const _OptionalSkew({Key? key, required this.child, required this.skewX, required this.skewY, this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (skewX!=0||skewY!=0){
      return Transform(
        transform: Matrix4.skew(skewX.clamp(-2, 2), skewY.clamp(-2, 2), ),
        alignment: alignment,
        child: child,
      );
    }
    else{
      return child;
    }
  }
}



class _OptionalRotate extends StatelessWidget {
  final Widget child;
  final double angle;
  const _OptionalRotate({Key? key, required this.child, required this.angle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (angle!=0){
      return Transform.rotate(
        angle: angle,
        child: child,
      );
    }
    else{
      return child;
    }
  }
}



class _OptionalScale extends StatelessWidget {
  final Widget child;
  final double scale;
  const _OptionalScale({Key? key, required this.child, required this.scale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (scale!=1){
      return Transform.scale(
        scale: scale,
        child: child,
      );
    }
    else{
      return child;
    }
  }
}

class _OptionalOpacity extends StatelessWidget {
  final Widget child;
  final double opacity;
  const _OptionalOpacity({Key? key, required this.child, required this.opacity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (opacity!=1){
      return Opacity(
        opacity: opacity.clamp(0, 1),
        child: child,
      );
    }
    else{
      return child;
    }
  }
}




class WidgetTransitionEffects{
  final Offset? offset;
  final Offset? skew;
  final double? scale;
  final Offset? blur;
  final double? rotation;
  final double? opacity;
  final Curve? curve;
  TransitionAnimationSettingsBuilder? builder;
  final Duration? duration;
  final Duration? delay;

  final WidgetTransitionEffectStyle style;

  static Duration defaultDuration = const Duration(milliseconds: 300);


  WidgetTransitionEffects.withStyle({this.offset, this.opacity, this.scale, this.blur, this.rotation, this.curve, this.skew, this.duration, this.delay, this.builder, required this.style});

  WidgetTransitionEffects({this.offset, this.opacity, this.scale, this.blur, this.rotation, this.curve, this.skew, this.duration, this.delay, this.builder}) : style = WidgetTransitionEffectStyle.none;

  WidgetTransitionEffects.incomingOffsetThenScale({this.duration, this.delay}) : style = WidgetTransitionEffectStyle.incomingOffsetAndThenScale, rotation = 0, scale = 1, skew = const Offset(0,0), blur = const Offset(0, 0), offset = const Offset(0,0), opacity = 1, curve = Curves.linear;
  WidgetTransitionEffects.incomingOffsetThenScaleAndStep({this.duration, this.delay}) : style = WidgetTransitionEffectStyle.incomingOffsetAndThenScaleAndStep, rotation = 0, scale = 1, skew = const Offset(0,0), blur = const Offset(0, 0), offset = const Offset(0,0), opacity = 1, curve = Curves.linear;

  WidgetTransitionEffects.outgoingOffsetThenScale({this.duration, this.delay}) : style = WidgetTransitionEffectStyle.outgoingOffsetAndThenScale, rotation = 0, scale = 1, skew = const Offset(0,0), blur = const Offset(0, 0), offset = const Offset(0,0), opacity = 1, curve = Curves.linear;


  WidgetTransitionEffects.incomingScaleDown({this.offset, this.opacity, this.blur, this.rotation, this.curve, this.skew, this.delay, this.duration}) : scale = 3, style = WidgetTransitionEffectStyle.none;
  WidgetTransitionEffects.incomingScaleUp({this.offset, this.opacity, this.blur, this.rotation, this.curve, this.skew, this.delay, this.duration}) : scale = 0, style = WidgetTransitionEffectStyle.none;
  WidgetTransitionEffects.outgoingScaleDown({this.offset, this.opacity, this.blur, this.rotation, this.curve, this.skew, this.delay, this.duration}) : scale = 0, style = WidgetTransitionEffectStyle.none;
  WidgetTransitionEffects.outgoingScaleUp({this.offset, this.opacity, this.blur, this.rotation, this.curve, this.skew, this.delay, this.duration}) : scale = 3, style = WidgetTransitionEffectStyle.none;

  WidgetTransitionEffects.incomingSlideInFromLeft({this.opacity, this.rotation, this.skew, this.delay, this.scale, this.curve, this.blur, this.duration}) : offset = const Offset(-150,0), style = WidgetTransitionEffectStyle.none;
  WidgetTransitionEffects.incomingSlideInFromRight({this.opacity, this.rotation, this.skew, this.delay, this.scale, this.curve, this.blur, this.duration}) : offset = const Offset(150,0), style = WidgetTransitionEffectStyle.none;
  WidgetTransitionEffects.incomingSlideInFromTop({this.opacity, this.rotation, this.skew, this.delay, this.scale, this.curve, this.blur, this.duration}) : offset = const Offset(0,-150), style = WidgetTransitionEffectStyle.none;
  WidgetTransitionEffects.incomingSlideInFromBottom({this.opacity, this.rotation, this.skew, this.delay, this.scale, this.curve, this.blur, this.duration}) : offset = const Offset(0, 150), style = WidgetTransitionEffectStyle.none;
  WidgetTransitionEffects.outgoingSlideOutToLeft({this.opacity, this.rotation, this.skew, this.delay, this.scale, this.curve, this.blur, this.duration}) : offset = const Offset(-150,0), style = WidgetTransitionEffectStyle.none;
  WidgetTransitionEffects.outgoingSlideOutToRight({this.opacity, this.rotation, this.skew, this.delay, this.scale, this.curve, this.blur, this.duration}) : offset = const Offset(150,0), style = WidgetTransitionEffectStyle.none;
  WidgetTransitionEffects.outgoingSlideOutToTop({this.opacity, this.rotation, this.skew, this.delay, this.scale, this.curve, this.blur, this.duration}) : offset = const Offset(0,-150), style = WidgetTransitionEffectStyle.none;
  WidgetTransitionEffects.outgoingSlideOutToBottom({this.opacity, this.rotation, this.skew, this.delay, this.scale, this.curve, this.blur, this.duration}) : offset = const Offset(0, 150), style = WidgetTransitionEffectStyle.none;



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
  int get hashCode => offset.hashCode ^ builder.hashCode ^ scale.hashCode ^ duration.hashCode ^ delay.hashCode ^ skew.hashCode ^ opacity.hashCode^ blur.hashCode^ rotation.hashCode ^ curve.hashCode;
}




class WidgetRestingEffects{
  WidgetRestingEffectStyle? style;
  AtRestAnimationSettingsBuilder? builder;
  Duration? duration;
  Curve? curve;
  int? numberOfPlays;
  Alignment? alignment;
  double? effectStrength;
  Duration? delay;


  WidgetRestingEffects({this.style, this.builder, this.duration, this.alignment, this.curve, this.numberOfPlays, this.effectStrength, this.delay});

  WidgetRestingEffects.wave({this.builder, this.duration, this.alignment, this.curve, this.numberOfPlays, this.effectStrength, this.delay}) : style = WidgetRestingEffectStyle.wave;
  WidgetRestingEffects.pulse({this.builder, this.duration, this.alignment, this.curve, this.numberOfPlays, this.effectStrength, this.delay}) : style = WidgetRestingEffectStyle.pulse;
  WidgetRestingEffects.rotate({this.builder, this.duration, this.alignment, this.curve, this.numberOfPlays, this.effectStrength, this.delay}) : style = WidgetRestingEffectStyle.rotate;
  WidgetRestingEffects.bounce({this.builder, this.duration, this.alignment, this.curve, this.numberOfPlays, this.effectStrength, this.delay}) : style = WidgetRestingEffectStyle.bounce;
  WidgetRestingEffects.slide({this.builder, this.duration, this.alignment, this.curve, this.numberOfPlays, this.effectStrength, this.delay}) : style = WidgetRestingEffectStyle.slide;
  WidgetRestingEffects.swing({this.builder, this.duration, this.alignment, this.curve, this.numberOfPlays, this.effectStrength, this.delay}) : style = WidgetRestingEffectStyle.swing;
  WidgetRestingEffects.size({this.builder, this.duration, this.alignment, this.curve, this.numberOfPlays, this.effectStrength, this.delay}) : style = WidgetRestingEffectStyle.size;
  WidgetRestingEffects.fidget({this.builder, this.duration, this.alignment, this.curve, this.numberOfPlays, this.effectStrength, this.delay}) : style = WidgetRestingEffectStyle.fidget;
  WidgetRestingEffects.dangle({this.builder, this.duration, this.alignment, this.curve, this.numberOfPlays, this.effectStrength, this.delay}) : style = WidgetRestingEffectStyle.dangle;
  WidgetRestingEffects.vibrate({this.builder, this.duration, this.alignment, this.curve, this.numberOfPlays, this.effectStrength, this.delay}) : style = WidgetRestingEffectStyle.vibrate;
  WidgetRestingEffects.none({this.builder, this.duration, this.alignment, this.curve, this.numberOfPlays, this.effectStrength, this.delay}) : style = WidgetRestingEffectStyle.none;



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
  int get hashCode => style.hashCode ^ builder.hashCode^ duration.hashCode ^ alignment.hashCode ^ curve.hashCode ^ numberOfPlays.hashCode ^ effectStrength.hashCode ^ delay.hashCode;
}




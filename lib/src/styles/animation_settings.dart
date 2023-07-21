import 'package:flutter/material.dart';

/// [AnimationSettings] is used to store the settings that drive all the animations, these are mostly [Animation] objects that tweens are set on
/// they are initialised with default sensible options
class AnimationSettings {
  Animation<double>? opacityAnimation;
  Animation<double>? scaleAnimation;
  Animation<double>? offsetXAnimation;
  Animation<double>? offsetYAnimation;
  Animation<double>? blurXAnimation;
  Animation<double>? blurYAnimation;
  Animation<double>? rotationAnimation;
  Animation<double>? skewXAnimation;
  Animation<double>? skewYAnimation;
  Alignment? skewAlignment;
  Alignment? scaleAlignment;

  AnimationSettings(
      {required AnimationController animationController,
      this.opacityAnimation,
      this.scaleAnimation,
      this.offsetXAnimation,
      this.offsetYAnimation,
      this.blurXAnimation,
      this.blurYAnimation,
      this.rotationAnimation,
      this.scaleAlignment,
      this.skewAlignment,
      this.skewXAnimation,
      this.skewYAnimation}) {
    opacityAnimation = Tween<double>(begin: 1, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
    scaleAnimation = Tween<double>(begin: 1, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
    offsetXAnimation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
    offsetYAnimation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
    rotationAnimation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
    blurXAnimation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
    blurYAnimation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
    skewXAnimation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
    skewYAnimation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));
    skewAlignment = Alignment.center;
    scaleAlignment = Alignment.center;
  }
}

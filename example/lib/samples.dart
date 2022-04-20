import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';


/// [Samples] provides some simple examples of all 4 main classes [WidgetAnimator], [WidgetAnimatorSequence], [TextAnimator] and [TextAnimatorSequence]
class Samples extends StatelessWidget {
  const Samples({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return const Samples();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          brightness: Brightness.dark,
          materialTapTargetSize: MaterialTapTargetSize.padded,
    ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Samples'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                WidgetAnimator(
                  child: Text('WidgetAnimator', style: GoogleFonts.lato(textStyle: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: -2, fontSize: 28))),
                  incomingEffect: WidgetTransitionEffects.incomingScaleDown(duration: const Duration(milliseconds: 600)),
                ),
                const SizedBox(
                  height: 10,
                ),
                WidgetAnimator(
                  child: ElevatedButton(

                      onPressed: () {
                        Navigator.of(context).push(SamplesIncoming.route());
                      },
                      child: const Text('Incoming animations')),
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 200)),
                ),
                WidgetAnimator(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(SamplesAtRest.route());
                      },
                      child: const Text('At rest animations')),
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 400)),
                ),
                WidgetAnimator(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(SamplesOutgoing.route());
                      },
                      child: const Text('Outgoing animations')),
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 600)),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextAnimator('TextAnimator',
                    initialDelay: const Duration(milliseconds: 800),
                    style: GoogleFonts.lato(textStyle: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: -2, fontSize: 28)),
                    incomingEffect: WidgetTransitionEffects.incomingScaleDown(duration: const Duration(milliseconds: 600))),
                const SizedBox(
                  height: 10,
                ),
                WidgetAnimator(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(SamplesText.route());
                      },
                      child: const Text('Text animations')),
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 1000)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextAnimator('Sequence animators',
                    initialDelay: const Duration(milliseconds: 1200),
                    style: GoogleFonts.lato(textStyle: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: -2, fontSize: 28)),
                    incomingEffect: WidgetTransitionEffects.incomingScaleDown(duration: const Duration(milliseconds: 600))),
                const SizedBox(
                  height: 10,
                ),
                WidgetAnimator(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(_WidgetSequence.route());
                      },
                      child: const Text('WidgetAnimatorSequence')),
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 1400)),
                ),
                WidgetAnimator(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(_TextSequence.route());
                      },
                      child: const Text('TextAnimatorSequence')),
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 1600)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextAnimator('Just for fun',
                    initialDelay: const Duration(milliseconds: 1800),
                    style: GoogleFonts.lato(textStyle: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: -2, fontSize: 28)),
                    incomingEffect: WidgetTransitionEffects.incomingScaleDown(duration: const Duration(milliseconds: 600))),
                const SizedBox(
                  height: 10,
                ),
                WidgetAnimator(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(_Fun.route());
                      },
                      child: const Text('Breathing')),
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 2000)),
                ),
                WidgetAnimator(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(_Fun2.route());
                      },
                      child: const Text('Demo')),
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 2000)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SamplesIncoming extends StatefulWidget {
  const SamplesIncoming({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return const SamplesIncoming();
    });
  }

  @override
  State<SamplesIncoming> createState() => _SamplesIncomingState();
}

class _SamplesIncomingState extends State<SamplesIncoming> {
  int currentPage = 0;

  List<Widget> widgetList = [
    Center(
      key: const ValueKey('1'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingScaleDown(delay: const Duration(milliseconds: 500)),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.red,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetTransitionEffects.incomingScaleDown'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('2'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingScaleUp(delay: const Duration(milliseconds: 500)),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetTransitionEffects.incomingScaleUp'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('3'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 500)),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.green,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetTransitionEffects.incomingSlideInFromLeft'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('4'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(delay: const Duration(milliseconds: 500)),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.cyan,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetTransitionEffects.incomingSlideInFromTop'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('5'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(delay: const Duration(milliseconds: 500)),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.orange,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetTransitionEffects.incomingSlideInFromRight'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('6'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 500)),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.deepPurple,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetTransitionEffects.incomingSlideInFromBottom'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('6b'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), curve: Curves.bounceOut),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.deepPurple.withOpacity(0.5),
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetTransitionEffects.incomingSlideInFromBottom with custom curve and slower speed'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('7'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), blur: const Offset(20, 0)),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.red.withOpacity(0.5),
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Blur X'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('8'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), blur: const Offset(0, 30)),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.green.withOpacity(0.5),
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Blur Y'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('9'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), blur: const Offset(1.5, 1.5)),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue.withOpacity(0.5),
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Blur X and Y'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('10'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), skew: const Offset(0.4, 0)),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.green,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Skew X'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('11'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), skew: const Offset(0, 0.4)),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.cyan,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Skew Y'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('12'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), skew: const Offset(0.4, 0.4)),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.orange,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Skew X and Y'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('13'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), rotation: math.pi / 4),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.purple,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Rotate anti-clockwise'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('14'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), rotation: -math.pi / 3),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.red,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Rotate clockwise'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('15'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(
            delay: const Duration(milliseconds: 500),
            duration: const Duration(milliseconds: 1000),
            scale: 0.5,
            offset: const Offset(150, -130),
            rotation: -math.pi / 6,
            blur: const Offset(3, 3),
            skew: const Offset(0.3, 0.3),
            opacity: 0.8),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Combination of scale, blue, offset, rotation and skew'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('16'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingOffsetThenScale(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000)),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.green,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetTransitionEffects.incomingOffsetThenScale'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('17'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingOffsetThenScaleAndStep(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000)),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.deepPurple,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetTransitionEffects.incomingOffsetThenScaleAndStep'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('18'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(
            delay: const Duration(milliseconds: 500),
            duration: const Duration(milliseconds: 1000),
            builder: (effects, animationController) {
              ///custom builders always need to return an [AnimationSettings] object, so create one first and then
              ///set the properties on it
              ///For this one opacity, x axis offset and scale are all manipulated using the tween sequence chain
              ///If you want the 'delay' and 'duration' to work
              ///this is a good example of how to use them, firstly set the weight of the first tween to the delay
              ///then set any other [Tween] to be a proportion of the duration e.g 30% of the duration set the
              ///weight to duration * 0.3
              AnimationSettings _animationSettings = AnimationSettings(animationController: animationController);

              double delay = (effects.delay?.inMilliseconds ?? 0).toDouble();
              double duration = (effects.duration?.inMilliseconds ?? 300).toDouble();

              _animationSettings.opacityAnimation = TweenSequence<double>(
                <TweenSequenceItem<double>>[
                  if (delay > 0)
                    TweenSequenceItem<double>(
                      tween: Tween<double>(begin: 0, end: 0).chain(CurveTween(curve: Curves.linear)),
                      weight: delay,
                    ),
                  TweenSequenceItem<double>(
                    tween: Tween<double>(begin: 0, end: 0.7).chain(CurveTween(curve: Curves.easeInOut)),
                    weight: duration * 0.7,
                  ),
                  TweenSequenceItem<double>(
                    tween: Tween<double>(begin: 0.7, end: 1).chain(CurveTween(curve: Curves.linear)),
                    weight: duration * 0.15,
                  ),
                  TweenSequenceItem<double>(
                    tween: Tween<double>(begin: 1, end: 1).chain(CurveTween(curve: Curves.linear)),
                    weight: duration * 0.15,
                  ),
                ],
              ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));

              _animationSettings.offsetXAnimation = TweenSequence<double>(
                <TweenSequenceItem<double>>[
                  if (delay > 0)
                    TweenSequenceItem<double>(
                      tween: Tween<double>(begin: 0, end: 0).chain(CurveTween(curve: Curves.linear)),
                      weight: delay,
                    ),
                  TweenSequenceItem<double>(
                    tween: Tween<double>(begin: 100, end: 0).chain(CurveTween(curve: Curves.easeIn)),
                    weight: duration * 0.7,
                  ),
                  TweenSequenceItem<double>(
                    tween: Tween<double>(begin: 0, end: 0).chain(CurveTween(curve: Curves.linear)),
                    weight: duration * 0.3,
                  ),
                  TweenSequenceItem<double>(
                    tween: Tween<double>(begin: 0, end: 0).chain(CurveTween(curve: Curves.linear)),
                    weight: duration * 0.15,
                  ),
                ],
              ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));

              _animationSettings.scaleAnimation = TweenSequence<double>(
                <TweenSequenceItem<double>>[
                  if (delay > 0)
                    TweenSequenceItem<double>(
                      tween: Tween<double>(begin: 0, end: 0).chain(CurveTween(curve: Curves.linear)),
                      weight: delay,
                    ),
                  TweenSequenceItem<double>(
                    tween: Tween<double>(begin: 0.5, end: 0.9).chain(CurveTween(curve: Curves.linear)),
                    weight: duration * 0.7,
                  ),
                  TweenSequenceItem<double>(
                    tween: Tween<double>(begin: 0.9, end: 0.9).chain(CurveTween(curve: Curves.linear)),
                    weight: duration * 0.3,
                  ),
                  TweenSequenceItem<double>(
                    tween: Tween<double>(begin: 0.9, end: 1).chain(CurveTween(curve: Curves.easeInOut)),
                    weight: duration * 0.15,
                  ),
                ],
              ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
              return _animationSettings;
            }),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.pink,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetTransitionEffects custom builder'),
          )),
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          brightness: Brightness.dark
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Incoming Samples'),
        ),
        body: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      currentPage == widgetList.length - 1 ? currentPage = 0 : currentPage = currentPage + 1;
                    });
                  }
                },
                child: Center(
                  child: AnimatedSwitcher(duration: const Duration(milliseconds: 100), child: widgetList[currentPage]),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WidgetAnimator(
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 600), duration: const Duration(milliseconds: 600), curve: Curves.easeOut),
                  child: OutlinedButton(
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            currentPage == 0 ? currentPage = widgetList.length - 1 : currentPage = currentPage - 1;
                          });
                        }
                      },
                      child: const Text('Previous')),
                ),
                WidgetAnimator(
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 750), duration: const Duration(milliseconds: 600), curve: Curves.easeOut),
                  child: OutlinedButton(
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            currentPage == widgetList.length - 1 ? currentPage = 0 : currentPage = currentPage + 1;
                          });
                        }
                      },
                      child: const Text('Next')),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class SamplesOutgoing extends StatefulWidget {
  const SamplesOutgoing({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return const SamplesOutgoing();
    });
  }

  @override
  State<SamplesOutgoing> createState() => _SamplesOutgoingState();
}

class _SamplesOutgoingState extends State<SamplesOutgoing> {
  int currentPage = 0;

  List<Widget> widgetList = [];

  @override
  void initState() {
    super.initState();

    widgetList = const [
      _OutgoingScaleDown(),
      _OutgoingScaleUp(),
      _OutgoingSlideOutLeft(),
      _OutgoingSlideOutRight(),
      _OutgoingSlideOutTop(),
      _OutgoingSlideOutBottom(),
      _OutgoingSlideOutBottomCustomCurve(),
      _OutgoingRotationClockwise(),
      _OutgoingRotationAntiClockwise(),
      _OutgoingSkewX(),
      _OutgoingSkewY(),
      _OutgoingSkewXY(),
      _OutgoingBlurX(),
      _OutgoingBlurY(),
      _OutgoingBlurXY(),
      _OutgoingCombination(),
      _OutgoingOffsetThenScale(),
      _OutgoingCustomBuilder()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          brightness: Brightness.dark
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Outgoing Samples'),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text('Tap square to start outgoing animation'),
            const Expanded(
              child: SizedBox(),
            ),
            IndexedStack(
              index: currentPage,
              children: widgetList,
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WidgetAnimator(
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(duration: const Duration(milliseconds: 600), curve: Curves.easeOut),
                  child: OutlinedButton(
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            currentPage == 0 ? currentPage = widgetList.length - 1 : currentPage = currentPage - 1;
                          });
                        }
                      },
                      child: const Text('Previous')),
                ),
                WidgetAnimator(
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 150), duration: const Duration(milliseconds: 600), curve: Curves.easeOut),
                  child: OutlinedButton(
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            currentPage == widgetList.length - 1 ? currentPage = 0 : currentPage = currentPage + 1;
                          });
                        }
                      },
                      child: const Text('Next')),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _OutgoingScaleDown extends StatefulWidget {
  const _OutgoingScaleDown({Key? key}) : super(key: key);

  @override
  State<_OutgoingScaleDown> createState() => _OutgoingScaleDownState();
}

class _OutgoingScaleDownState extends State<_OutgoingScaleDown> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects.outgoingScaleDown(),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  pressed = false;
                });
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.deepPurple,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('WidgetTransitionEffects.outgoingScaleDown'),
                        ))))));
  }
}

class _OutgoingScaleUp extends StatefulWidget {
  const _OutgoingScaleUp({Key? key}) : super(key: key);

  @override
  State<_OutgoingScaleUp> createState() => _OutgoingScaleUpState();
}

class _OutgoingScaleUpState extends State<_OutgoingScaleUp> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  pressed = false;
                });
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.red,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('WidgetTransitionEffects.outgoingScaleUp'),
                        ))))));
  }
}

class _OutgoingSlideOutLeft extends StatefulWidget {
  const _OutgoingSlideOutLeft({Key? key}) : super(key: key);

  @override
  State<_OutgoingSlideOutLeft> createState() => _OutgoingSlideOutLeftState();
}

class _OutgoingSlideOutLeftState extends State<_OutgoingSlideOutLeft> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToLeft(),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  pressed = false;
                });
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.green,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('WidgetTransitionEffects.outgoingSlideOutToLeft'),
                        ))))));
  }
}

class _OutgoingSlideOutRight extends StatefulWidget {
  const _OutgoingSlideOutRight({Key? key}) : super(key: key);

  @override
  State<_OutgoingSlideOutRight> createState() => _OutgoingSlideOutRightState();
}

class _OutgoingSlideOutRightState extends State<_OutgoingSlideOutRight> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToRight(),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                if (mounted) {
                  setState(() {
                    pressed = false;
                  });
                }
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.blue,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('WidgetTransitionEffects.outgoingSlideOutToRight'),
                        ))))));
  }
}

class _OutgoingSlideOutTop extends StatefulWidget {
  const _OutgoingSlideOutTop({Key? key}) : super(key: key);

  @override
  State<_OutgoingSlideOutTop> createState() => _OutgoingSlideOutTopState();
}

class _OutgoingSlideOutTopState extends State<_OutgoingSlideOutTop> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToTop(),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                if (mounted) {
                  setState(() {
                    pressed = false;
                  });
                }
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.cyan,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('WidgetTransitionEffects.outgoingSlideOutToTop'),
                        ))))));
  }
}

class _OutgoingSlideOutBottom extends StatefulWidget {
  const _OutgoingSlideOutBottom({Key? key}) : super(key: key);

  @override
  State<_OutgoingSlideOutBottom> createState() => _OutgoingSlideOutBottomState();
}

class _OutgoingSlideOutBottomState extends State<_OutgoingSlideOutBottom> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                if (mounted) {
                  setState(() {
                    pressed = false;
                  });
                }
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.redAccent,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('WidgetTransitionEffects.outgoingSlideOutToBottom'),
                        ))))));
  }
}

class _OutgoingSlideOutBottomCustomCurve extends StatefulWidget {
  const _OutgoingSlideOutBottomCustomCurve({Key? key}) : super(key: key);

  @override
  State<_OutgoingSlideOutBottomCustomCurve> createState() => _OutgoingSlideOutBottomCustomCurveState();
}

class _OutgoingSlideOutBottomCustomCurveState extends State<_OutgoingSlideOutBottomCustomCurve> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(curve: Curves.elasticIn, duration: const Duration(milliseconds: 1500)),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                if (mounted) {
                  setState(() {
                    pressed = false;
                  });
                }
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.deepPurple.withOpacity(0.5),
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('WidgetTransitionEffects.outgoingSlideOutToBottom, custom curve'),
                        ))))));
  }
}

class _OutgoingRotationClockwise extends StatefulWidget {
  const _OutgoingRotationClockwise({Key? key}) : super(key: key);

  @override
  State<_OutgoingRotationClockwise> createState() => _OutgoingRotationClockwiseState();
}

class _OutgoingRotationClockwiseState extends State<_OutgoingRotationClockwise> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects(rotation: math.pi / 3),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  pressed = false;
                });
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.deepOrange,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Rotation clockwise'),
                        ))))));
  }
}

class _OutgoingRotationAntiClockwise extends StatefulWidget {
  const _OutgoingRotationAntiClockwise({Key? key}) : super(key: key);

  @override
  State<_OutgoingRotationAntiClockwise> createState() => _OutgoingRotationAntiClockwiseState();
}

class _OutgoingRotationAntiClockwiseState extends State<_OutgoingRotationAntiClockwise> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects(rotation: -math.pi / 3),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  pressed = false;
                });
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.deepOrangeAccent,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Rotation AntiClockwise'),
                        ))))));
  }
}

class _OutgoingSkewX extends StatefulWidget {
  const _OutgoingSkewX({Key? key}) : super(key: key);

  @override
  State<_OutgoingSkewX> createState() => _OutgoingSkewXState();
}

class _OutgoingSkewXState extends State<_OutgoingSkewX> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects(skew: const Offset(0.3, 0)),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  pressed = false;
                });
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.red,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Skew X'),
                        ))))));
  }
}

class _OutgoingSkewY extends StatefulWidget {
  const _OutgoingSkewY({Key? key}) : super(key: key);

  @override
  State<_OutgoingSkewY> createState() => _OutgoingSkewYState();
}

class _OutgoingSkewYState extends State<_OutgoingSkewY> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects(skew: const Offset(0, 0.3)),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  pressed = false;
                });
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.green,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Skew Y'),
                        ))))));
  }
}

class _OutgoingSkewXY extends StatefulWidget {
  const _OutgoingSkewXY({Key? key}) : super(key: key);

  @override
  State<_OutgoingSkewXY> createState() => _OutgoingSkewXYState();
}

class _OutgoingSkewXYState extends State<_OutgoingSkewXY> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects(skew: const Offset(0.3, 0.3)),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  pressed = false;
                });
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.blue,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Skew X and Y'),
                        ))))));
  }
}

class _OutgoingBlurX extends StatefulWidget {
  const _OutgoingBlurX({Key? key}) : super(key: key);

  @override
  State<_OutgoingBlurX> createState() => _OutgoingBlurXState();
}

class _OutgoingBlurXState extends State<_OutgoingBlurX> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects(blur: const Offset(5, 0)),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  pressed = false;
                });
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.red,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Blur X'),
                        ))))));
  }
}

class _OutgoingBlurY extends StatefulWidget {
  const _OutgoingBlurY({Key? key}) : super(key: key);

  @override
  State<_OutgoingBlurY> createState() => _OutgoingBlurYState();
}

class _OutgoingBlurYState extends State<_OutgoingBlurY> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects(blur: const Offset(0, 10)),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  pressed = false;
                });
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.green,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Blur Y'),
                        ))))));
  }
}

class _OutgoingBlurXY extends StatefulWidget {
  const _OutgoingBlurXY({Key? key}) : super(key: key);

  @override
  State<_OutgoingBlurXY> createState() => _OutgoingBlurXYState();
}

class _OutgoingBlurXYState extends State<_OutgoingBlurXY> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects(blur: const Offset(2, 2)),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  pressed = false;
                });
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.blue,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Blur X and Y'),
                        ))))));
  }
}

class _OutgoingCombination extends StatefulWidget {
  const _OutgoingCombination({Key? key}) : super(key: key);

  @override
  State<_OutgoingCombination> createState() => _OutgoingCombinationState();
}

class _OutgoingCombinationState extends State<_OutgoingCombination> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects(rotation: math.pi / 5, blur: const Offset(2, 2), skew: const Offset(0.3, 0.2), offset: const Offset(30, 40), scale: 0.5),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  pressed = false;
                });
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.pink,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Combination'),
                        ))))));
  }
}

class _OutgoingOffsetThenScale extends StatefulWidget {
  const _OutgoingOffsetThenScale({Key? key}) : super(key: key);

  @override
  State<_OutgoingOffsetThenScale> createState() => _OutgoingOffsetThenScaleState();
}

class _OutgoingOffsetThenScaleState extends State<_OutgoingOffsetThenScale> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects.outgoingOffsetThenScale(duration: const Duration(milliseconds: 500), delay: const Duration(milliseconds: 0)),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  pressed = false;
                });
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.amber,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('WidgetTransitionEffects.outgoingOffsetThenScale'),
                        ))))));
  }
}

class _OutgoingCustomBuilder extends StatefulWidget {
  const _OutgoingCustomBuilder({Key? key}) : super(key: key);

  @override
  State<_OutgoingCustomBuilder> createState() => _OutgoingCustomBuilderState();
}

class _OutgoingCustomBuilderState extends State<_OutgoingCustomBuilder> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }
        },
        child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 0),
                builder: (effects, animationController) {
                  AnimationSettings _animationSettings = AnimationSettings(animationController: animationController);

                  double delay = (effects.delay?.inMilliseconds ?? 0).toDouble();
                  double duration = (effects.duration?.inMilliseconds ?? 300).toDouble();

                  _animationSettings.opacityAnimation = TweenSequence<double>(
                    <TweenSequenceItem<double>>[
                      if (delay > 0)
                        TweenSequenceItem<double>(
                          tween: Tween<double>(begin: 0, end: 0).chain(CurveTween(curve: Curves.linear)),
                          weight: delay,
                        ),
                      TweenSequenceItem<double>(
                        tween: Tween<double>(begin: 1, end: 0.7).chain(CurveTween(curve: Curves.easeInOut)),
                        weight: duration * 0.7,
                      ),
                      TweenSequenceItem<double>(
                        tween: Tween<double>(begin: 0.7, end: 0).chain(CurveTween(curve: Curves.linear)),
                        weight: duration * 0.3,
                      ),
                    ],
                  ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));

                  _animationSettings.offsetYAnimation = TweenSequence<double>(
                    <TweenSequenceItem<double>>[
                      if (delay > 0)
                        TweenSequenceItem<double>(
                          tween: Tween<double>(begin: 0, end: 0).chain(CurveTween(curve: Curves.linear)),
                          weight: delay,
                        ),
                      TweenSequenceItem<double>(
                        tween: Tween<double>(begin: 0, end: 0).chain(CurveTween(curve: Curves.easeIn)),
                        weight: duration * 0.7,
                      ),
                      TweenSequenceItem<double>(
                        tween: Tween<double>(begin: 0, end: 50).chain(CurveTween(curve: Curves.easeOut)),
                        weight: duration * 0.3,
                      ),
                    ],
                  ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));

                  _animationSettings.scaleAnimation = TweenSequence<double>(
                    <TweenSequenceItem<double>>[
                      if (delay > 0)
                        TweenSequenceItem<double>(
                          tween: Tween<double>(begin: 0, end: 0).chain(CurveTween(curve: Curves.easeInOut)),
                          weight: delay,
                        ),
                      TweenSequenceItem<double>(
                        tween: Tween<double>(begin: 1, end: 0.8).chain(CurveTween(curve: Curves.fastOutSlowIn)),
                        weight: duration * 0.7,
                      ),
                      TweenSequenceItem<double>(
                        tween: Tween<double>(begin: 0.8, end: 4).chain(CurveTween(curve: Curves.ease)),
                        weight: duration * 0.3,
                      ),
                    ],
                  ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));
                  return _animationSettings;
                }),
            onOutgoingAnimationComplete: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              if (mounted) {
                setState(() {
                  pressed = false;
                });
              }
            },
            child: pressed
                ? const SizedBox()
                : Center(
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.deepOrange,
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('WidgetTransitionEffects custom builder - jump drive to hyperspace'),
                        ))))));
  }
}

class SamplesAtRest extends StatefulWidget {
  const SamplesAtRest({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return const SamplesAtRest();
    });
  }

  @override
  State<SamplesAtRest> createState() => _SamplesAtRestState();
}

class _SamplesAtRestState extends State<SamplesAtRest> {
  int currentPage = 0;

  List<Widget> widgetList = [
    Center(
      key: const ValueKey('1'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.dangle(),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.red,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetRestingEffects.dangle'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('1a'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.dangle(numberOfPlays: 3, effectStrength: 0.5, duration: const Duration(milliseconds: 750)),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.redAccent,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetRestingEffects.dangle, repeat 3 times, half effect strength, faster'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('2'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.fidget(),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetRestingEffects.fidget'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('3'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.pulse(),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.green,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetRestingEffects.pulse'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('3a'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.pulse(effectStrength: 0.6),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.lightGreen,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetRestingEffects.pulse - less intense'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('4'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.swing(),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.orange,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetRestingEffects.swing'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('5'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.rotate(curve: Curves.linear),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.purple,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetRestingEffects.rotate'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('6'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.size(),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.lightBlue,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetRestingEffects.size'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('7'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.slide(),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.cyan,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetRestingEffects.slide'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('8'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.wave(),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.red,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetRestingEffects.wave'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('8b'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WidgetAnimator(
            atRestEffect: WidgetRestingEffects.wave(effectStrength: 6),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
              child: const Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
              )),
            ),
          ),
          WidgetAnimator(
            atRestEffect: WidgetRestingEffects.wave(effectStrength: 2),
            child: Container(
              width: 120,
              height: 120,
              color: Colors.green,
              child: const Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('WidgetRestingEffects.wave variations'),
              )),
            ),
          ),
          WidgetAnimator(
            atRestEffect: WidgetRestingEffects.wave(effectStrength: 16, duration: const Duration(milliseconds: 3000)),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blueAccent,
              child: const Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
              )),
            ),
          ),
        ],
      ),
    ),
    Center(
      key: const ValueKey('9'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.bounce(),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.green,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetRestingEffects.bounce'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('10'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.vibrate(),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetRestingEffects.vibrate'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('11'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.vibrate(duration: const Duration(milliseconds: 120), effectStrength: 1.3),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blueAccent,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetRestingEffects.vibrate with custom values'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('12'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects(
          builder: (WidgetRestingEffects effects, AnimationController animationController) {
            AnimationSettings _animationSettings = AnimationSettings(animationController: animationController);
            double strength = 30.0;
            strength = (strength * effects.effectStrength!).clamp(-1000, 1000);
            _animationSettings.offsetYAnimation = TweenSequence<double>(
              <TweenSequenceItem<double>>[
                TweenSequenceItem<double>(
                  tween: Tween<double>(begin: 0, end: strength).chain(CurveTween(curve: Curves.ease)),
                  weight: 25.0,
                ),
                TweenSequenceItem<double>(
                  tween: Tween<double>(begin: strength, end: 0).chain(CurveTween(curve: Curves.elasticIn)),
                  weight: 75.0,
                ),
              ],
            ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));
            _animationSettings.scaleAnimation = TweenSequence<double>(
              <TweenSequenceItem<double>>[
                TweenSequenceItem<double>(
                  tween: Tween<double>(begin: 1, end: 1.2).chain(CurveTween(curve: Curves.ease)),
                  weight: 60.0,
                ),
                TweenSequenceItem<double>(
                  tween: Tween<double>(begin: 1.2, end: 1).chain(CurveTween(curve: Curves.ease)),
                  weight: 40.0,
                ),
              ],
            ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));
            _animationSettings.rotationAnimation = TweenSequence<double>(
              <TweenSequenceItem<double>>[
                TweenSequenceItem<double>(
                  tween: Tween<double>(begin: 0, end: math.pi / 17).chain(CurveTween(curve: Curves.easeIn)),
                  weight: 50.0,
                ),
                TweenSequenceItem<double>(
                  tween: Tween<double>(begin: math.pi / 17, end: 0).chain(CurveTween(curve: Curves.bounceOut)),
                  weight: 50.0,
                ),
              ],
            ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
            _animationSettings.opacityAnimation = TweenSequence<double>(
              <TweenSequenceItem<double>>[
                TweenSequenceItem<double>(
                  tween: Tween<double>(begin: 1, end: 0.5).chain(CurveTween(curve: Curves.ease)),
                  weight: 20.0,
                ),
                TweenSequenceItem<double>(
                  tween: Tween<double>(begin: 0.5, end: 1).chain(CurveTween(curve: Curves.ease)),
                  weight: 10.0,
                ),
                TweenSequenceItem<double>(
                  tween: Tween<double>(begin: 1, end: 1).chain(CurveTween(curve: Curves.ease)),
                  weight: 30.0,
                )
              ],
            ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));
            return _animationSettings;
          },
        ),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.deepPurple,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetRestingEffects with custom builder'),
          )),
        ),
      ),
    ),
    Center(
      key: const ValueKey('13'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects(
          duration: const Duration(seconds: 3),
          builder: (WidgetRestingEffects effects, AnimationController animationController) {
            AnimationSettings _animationSettings = AnimationSettings(animationController: animationController);
            _animationSettings.offsetYAnimation = TweenSequence<double>(
              <TweenSequenceItem<double>>[
                TweenSequenceItem<double>(
                  tween: Tween<double>(begin: 0, end: 150).chain(CurveTween(curve: Curves.easeInOut)),
                  weight: 33.0,
                ),
                TweenSequenceItem<double>(
                  tween: Tween<double>(begin: 150, end: 150).chain(CurveTween(curve: Curves.easeInOut)),
                  weight: 33.0,
                ),
                TweenSequenceItem<double>(
                  tween: Tween<double>(begin: 150, end: 0).chain(CurveTween(curve: Curves.easeInOut)),
                  weight: 33.0,
                ),
              ],
            ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));
            _animationSettings.offsetXAnimation = TweenSequence<double>(
              <TweenSequenceItem<double>>[
                TweenSequenceItem<double>(
                  tween: Tween<double>(begin: 0, end: 80).chain(CurveTween(curve: Curves.easeInOut)),
                  weight: 33.0,
                ),
                TweenSequenceItem<double>(
                  tween: Tween<double>(begin: 80, end: -80).chain(CurveTween(curve: Curves.easeInOut)),
                  weight: 33.0,
                ),
                TweenSequenceItem<double>(
                  tween: Tween<double>(begin: -80, end: 0).chain(CurveTween(curve: Curves.easeInOut)),
                  weight: 33.0,
                ),
              ],
            ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));
            return _animationSettings;
          },
        ),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.amber,
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('WidgetRestingEffects with custom builder'),
          )),
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          brightness: Brightness.dark
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('At rest Samples'),
        ),
        body: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      currentPage == widgetList.length - 1 ? currentPage = 0 : currentPage = currentPage + 1;
                    });
                  }
                },
                child: Center(
                  child: AnimatedSwitcher(duration: const Duration(milliseconds: 100), child: widgetList[currentPage]),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WidgetAnimator(
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 600), duration: const Duration(milliseconds: 600), curve: Curves.easeOut),
                  child: OutlinedButton(
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            currentPage == 0 ? currentPage = widgetList.length - 1 : currentPage = currentPage - 1;
                          });
                        }
                      },
                      child: const Text('Previous')),
                ),
                WidgetAnimator(
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 750), duration: const Duration(milliseconds: 600), curve: Curves.easeOut),
                  child: OutlinedButton(
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            currentPage == widgetList.length - 1 ? currentPage = 0 : currentPage = currentPage + 1;
                          });
                        }
                      },
                      child: const Text('Next')),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class SamplesText extends StatefulWidget {
  const SamplesText({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return const SamplesText();
    });
  }

  @override
  State<SamplesText> createState() => _SamplesTextState();
}

class _SampleTextSettings {
  String text;
  WidgetTransitionEffects incomingEffect;
  WidgetTransitionEffects outgoingEffect;
  WidgetRestingEffects atRestEffect;
  int maxLines;
  TextAlign textAlign;
  TextStyle style;
  Duration initialDelay;
  Duration characterDelay;
  Duration spaceDelay;

  _SampleTextSettings(
      {required this.text,
      required this.incomingEffect,
      required this.outgoingEffect,
      required this.atRestEffect,
      required this.maxLines,
      required this.textAlign,
      required this.style,
      required this.initialDelay,
      required this.characterDelay,
      required this.spaceDelay});
}

class _SamplesTextState extends State<SamplesText> {
  int currentPage = 0;

  final List<_SampleTextSettings> _settingsList = [];

  @override
  void initState() {
    super.initState();
    _settingsList.add(_SampleTextSettings(
      text: 'Sample one',
      incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
      outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
      atRestEffect: WidgetRestingEffects.none(),
      style: GoogleFonts.lato(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: -4, fontSize: 48)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 100),
      characterDelay: const Duration(milliseconds: 100),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample two',
      incomingEffect: WidgetTransitionEffects.incomingScaleUp(),
      outgoingEffect: WidgetTransitionEffects.outgoingScaleDown(),
      atRestEffect: WidgetRestingEffects.none(),
      style: GoogleFonts.monteCarlo(textStyle: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0, fontSize: 48)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 200),
      characterDelay: const Duration(milliseconds: 85),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample three',
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(),
      outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToLeft(),
      atRestEffect: WidgetRestingEffects.none(),
      style: GoogleFonts.abel(textStyle: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0, fontSize: 48)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 200),
      characterDelay: const Duration(milliseconds: 85),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample four',
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(),
      outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(),
      atRestEffect: WidgetRestingEffects.none(),
      style: GoogleFonts.abrilFatface(textStyle: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0, fontSize: 48)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 200),
      characterDelay: const Duration(milliseconds: 85),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Five',
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(),
      outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(),
      atRestEffect: WidgetRestingEffects.none(),
      style: GoogleFonts.roboto(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: -5, fontSize: 60)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 300),
      characterDelay: const Duration(milliseconds: 0),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Six',
      incomingEffect: WidgetTransitionEffects(blur: const Offset(10, 0), duration: const Duration(milliseconds: 1200)),
      outgoingEffect: WidgetTransitionEffects(blur: const Offset(0, 10)),
      atRestEffect: WidgetRestingEffects.none(),
      style: GoogleFonts.readexPro(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0, fontSize: 50)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 600),
      characterDelay: const Duration(milliseconds: 0),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Seven',
      incomingEffect: WidgetTransitionEffects(blur: const Offset(10, 10), duration: const Duration(milliseconds: 1200)),
      outgoingEffect: WidgetTransitionEffects(blur: const Offset(10, 10)),
      atRestEffect: WidgetRestingEffects.none(),
      style: GoogleFonts.ramaraja(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0, fontSize: 50)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 600),
      characterDelay: const Duration(milliseconds: 50),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Eight',
      incomingEffect: WidgetTransitionEffects(rotation: math.pi / 3),
      outgoingEffect: WidgetTransitionEffects(rotation: -math.pi / 2.5),
      atRestEffect: WidgetRestingEffects.none(),
      style: GoogleFonts.shipporiMincho(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0, fontSize: 50)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 600),
      characterDelay: const Duration(milliseconds: 80),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Nine',
      incomingEffect: WidgetTransitionEffects(rotation: math.pi / 4, curve: Curves.easeOut, duration: const Duration(milliseconds: 900)),
      outgoingEffect: WidgetTransitionEffects(rotation: -math.pi / 7.5, curve: Curves.easeIn, duration: const Duration(milliseconds: 900)),
      atRestEffect: WidgetRestingEffects.none(),
      style: GoogleFonts.convergence(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0, fontSize: 50)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 600),
      characterDelay: const Duration(milliseconds: 0),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Ten',
      incomingEffect: WidgetTransitionEffects(skew: const Offset(0.3, 0), curve: Curves.easeOut, duration: const Duration(milliseconds: 900)),
      outgoingEffect: WidgetTransitionEffects(skew: const Offset(-1, 0), curve: Curves.easeIn, duration: const Duration(milliseconds: 900)),
      atRestEffect: WidgetRestingEffects.none(),
      style: GoogleFonts.cutive(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0, fontSize: 50)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 600),
      characterDelay: const Duration(milliseconds: 120),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Eleven',
      incomingEffect: WidgetTransitionEffects(offset: const Offset(-60, 0), blur: const Offset(10, 0), curve: Curves.easeInOut, duration: const Duration(milliseconds: 400)),
      outgoingEffect: WidgetTransitionEffects(offset: const Offset(60, 0), blur: const Offset(10, 0), curve: Curves.easeIn, duration: const Duration(milliseconds: 400)),
      atRestEffect: WidgetRestingEffects.none(),
      style: GoogleFonts.bentham(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0, fontSize: 50)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 300),
      characterDelay: const Duration(milliseconds: 60),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Twelve',
      incomingEffect: WidgetTransitionEffects(offset: const Offset(0, 80), blur: const Offset(0, 20), curve: Curves.easeInOut, duration: const Duration(milliseconds: 300)),
      outgoingEffect: WidgetTransitionEffects(offset: const Offset(0, 80), blur: const Offset(0, 20), curve: Curves.easeIn, duration: const Duration(milliseconds: 300)),
      atRestEffect: WidgetRestingEffects.none(),
      style: GoogleFonts.prozaLibre(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0, fontSize: 50)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 60),
      characterDelay: const Duration(milliseconds: 60),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Thirteen',
      incomingEffect: WidgetTransitionEffects(offset: const Offset(20, 20), scale: 0.5, rotation: math.pi / 10, curve: Curves.easeInOut, duration: const Duration(milliseconds: 300)),
      outgoingEffect: WidgetTransitionEffects(offset: const Offset(60, 60), scale: 0.5, rotation: -math.pi / 10, curve: Curves.easeIn, duration: const Duration(milliseconds: 300)),
      atRestEffect: WidgetRestingEffects.none(),
      style: GoogleFonts.farro(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0, fontSize: 50)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 260),
      characterDelay: const Duration(milliseconds: 0),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Fourteen',
      incomingEffect: WidgetTransitionEffects(),
      outgoingEffect: WidgetTransitionEffects(),
      atRestEffect: WidgetRestingEffects.bounce(),
      style: GoogleFonts.calistoga(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0, fontSize: 50)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 400),
      characterDelay: const Duration(milliseconds: 00),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Fifteen',
      incomingEffect: WidgetTransitionEffects(),
      outgoingEffect: WidgetTransitionEffects(),
      atRestEffect: WidgetRestingEffects.bounce(),
      style: GoogleFonts.caladea(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0, fontSize: 50)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 100),
      characterDelay: const Duration(milliseconds: 100),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Sixteen',
      incomingEffect: WidgetTransitionEffects(),
      outgoingEffect: WidgetTransitionEffects(),
      atRestEffect: WidgetRestingEffects.vibrate(effectStrength: 0.3),
      style: GoogleFonts.baloo2(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0, fontSize: 50)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 100),
      characterDelay: const Duration(milliseconds: 20),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Seventeen',
      incomingEffect: WidgetTransitionEffects(),
      outgoingEffect: WidgetTransitionEffects(),
      atRestEffect: WidgetRestingEffects.wave(effectStrength: 2),
      style: GoogleFonts.atma(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0, fontSize: 40)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 60),
      characterDelay: const Duration(milliseconds: 60),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Eighteen',
      incomingEffect: WidgetTransitionEffects(),
      outgoingEffect: WidgetTransitionEffects(),
      atRestEffect: WidgetRestingEffects.size(),
      style: GoogleFonts.atma(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 40)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 80),
      characterDelay: const Duration(milliseconds: 80),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Nineteen',
      incomingEffect: WidgetTransitionEffects(),
      outgoingEffect: WidgetTransitionEffects(),
      atRestEffect: WidgetRestingEffects.size(effectStrength: 1.2),
      style: GoogleFonts.scopeOne(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 40)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 400),
      characterDelay: const Duration(milliseconds: 0),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Twenty',
      incomingEffect: WidgetTransitionEffects(),
      outgoingEffect: WidgetTransitionEffects(),
      atRestEffect: WidgetRestingEffects.rotate(),
      style: GoogleFonts.inder(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 40)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 400),
      characterDelay: const Duration(milliseconds: 20),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Twenty One',
      incomingEffect: WidgetTransitionEffects(),
      outgoingEffect: WidgetTransitionEffects(),
      atRestEffect: WidgetRestingEffects.swing(),
      style: GoogleFonts.reggaeOne(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 40)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 0),
      characterDelay: const Duration(milliseconds: 35),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Twenty Two',
      incomingEffect: WidgetTransitionEffects(),
      outgoingEffect: WidgetTransitionEffects(),
      atRestEffect: WidgetRestingEffects.swing(effectStrength: 2),
      style: GoogleFonts.italiana(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 40)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 400),
      characterDelay: const Duration(milliseconds: 0),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Twenty Three',
      incomingEffect: WidgetTransitionEffects(),
      outgoingEffect: WidgetTransitionEffects(),
      atRestEffect: WidgetRestingEffects.pulse(effectStrength: 0.7),
      style: GoogleFonts.vastShadow(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 40)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 200),
      characterDelay: const Duration(milliseconds: 100),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Twenty Four',
      incomingEffect: WidgetTransitionEffects(),
      outgoingEffect: WidgetTransitionEffects(),
      atRestEffect: WidgetRestingEffects.fidget(),
      style: GoogleFonts.craftyGirls(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 40)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 200),
      characterDelay: const Duration(milliseconds: 100),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Twenty Five',
      incomingEffect: WidgetTransitionEffects(),
      outgoingEffect: WidgetTransitionEffects(),
      atRestEffect: WidgetRestingEffects.dangle(effectStrength: 2),
      style: GoogleFonts.montserrat(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 40)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 200),
      characterDelay: const Duration(milliseconds: 150),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Twenty Six',
      incomingEffect: WidgetTransitionEffects(),
      outgoingEffect: WidgetTransitionEffects(),
      atRestEffect: WidgetRestingEffects.slide(effectStrength: 2),
      style: GoogleFonts.poppins(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0, fontSize: 40)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 0),
      spaceDelay: const Duration(milliseconds: 0),
      characterDelay: const Duration(milliseconds: 0),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Twenty Seven',
      incomingEffect: WidgetTransitionEffects.incomingOffsetThenScale(duration: const Duration(milliseconds: 600)),
      outgoingEffect: WidgetTransitionEffects.outgoingOffsetThenScale(duration: const Duration(milliseconds: 600)),
      atRestEffect: WidgetRestingEffects.none(),
      style: GoogleFonts.raleway(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 40)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 50),
      spaceDelay: const Duration(milliseconds: 65),
      characterDelay: const Duration(milliseconds: 65),
      maxLines: 3,
    ));

    _settingsList.add(_SampleTextSettings(
      text: 'Sample Twenty Eight',
      incomingEffect: WidgetTransitionEffects.incomingOffsetThenScaleAndStep(duration: const Duration(milliseconds: 600)),
      outgoingEffect: WidgetTransitionEffects.outgoingOffsetThenScale(duration: const Duration(milliseconds: 600)),
      atRestEffect: WidgetRestingEffects.none(),
      style: GoogleFonts.sanchez(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: -2, fontSize: 56)),
      textAlign: TextAlign.center,
      initialDelay: const Duration(milliseconds: 50),
      spaceDelay: const Duration(milliseconds: 65),
      characterDelay: const Duration(milliseconds: 65),
      maxLines: 3,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          brightness: Brightness.dark
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text Samples'),
        ),
        body: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      currentPage == _settingsList.length - 1 ? currentPage = 0 : currentPage = currentPage + 1;
                    });
                  }
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextAnimator(_settingsList[currentPage].text,
                        incomingEffect: _settingsList[currentPage].incomingEffect,
                        outgoingEffect: _settingsList[currentPage].outgoingEffect,
                        atRestEffect: _settingsList[currentPage].atRestEffect,
                        style: _settingsList[currentPage].style,
                        textAlign: _settingsList[currentPage].textAlign,
                        initialDelay: _settingsList[currentPage].initialDelay,
                        spaceDelay: _settingsList[currentPage].spaceDelay,
                        characterDelay: _settingsList[currentPage].characterDelay,
                        maxLines: _settingsList[currentPage].maxLines),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WidgetAnimator(
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 600), duration: const Duration(milliseconds: 600), curve: Curves.easeOut),
                  child: OutlinedButton(
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            currentPage == 0 ? currentPage = _settingsList.length - 1 : currentPage = currentPage - 1;
                          });
                        }
                      },
                      child: const Text('Previous')),
                ),
                WidgetAnimator(
                  incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 750), duration: const Duration(milliseconds: 600), curve: Curves.easeOut),
                  child: OutlinedButton(
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            currentPage == _settingsList.length - 1 ? currentPage = 0 : currentPage = currentPage + 1;
                          });
                        }
                      },
                      child: const Text('Next')),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}






class _WidgetSequence extends StatefulWidget {
  const _WidgetSequence({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return const _WidgetSequence();
    });
  }

  @override
  State<_WidgetSequence> createState() => _WidgetSequenceState();
}


class _WidgetSequenceState extends State<_WidgetSequence> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          brightness: Brightness.dark
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Widget sequence'),
        ),
        body: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Tap on widget to move onto the next item, can be set to loop back to the start or not. Automatically proceeding to the next widget is optional too.', textAlign: TextAlign.center,),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: _SequenceSampleWidgets(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _SequenceSampleWidgets extends StatelessWidget {
  const _SequenceSampleWidgets({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return WidgetAnimatorSequence(
      children: [
        WidgetAnimator(
            key: const ValueKey('one'),
            incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
            outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
            child: Container(width: 200,height: 200,color: Colors.red,child: Align(alignment: Alignment.centerLeft,child: Text('Red',style: GoogleFonts.sanchez(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: -2, fontSize: 56)),)))),
        WidgetAnimator(
            key: const ValueKey('two'),
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(),
            outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(),
            child: Container(width: 200,height: 200,color: Colors.green,child: Align(alignment: Alignment.centerLeft,child: Text('Green',style: GoogleFonts.sanchez(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: -2, fontSize: 56)),)))),
        WidgetAnimator(
            key: const ValueKey('two'),
            incomingEffect: WidgetTransitionEffects(blur: const Offset(2,2), duration: const Duration(milliseconds: 600)),
            atRestEffect: WidgetRestingEffects.slide(),
            outgoingEffect: WidgetTransitionEffects(blur: const Offset(2,2), duration: const Duration(milliseconds: 600)),
            child: Container(width: 200,height: 200,color: Colors.blue,child: Align(alignment: Alignment.centerLeft,child: Text('Blue',style: GoogleFonts.sanchez(textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: -2, fontSize: 56)),))))
      ],
      tapToProceed: true,
      loop: true,
      transitionTime: const Duration(seconds: 4),
    );
  }
}




class _TextSequence extends StatefulWidget {
  const _TextSequence({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return const _TextSequence();
    });
  }

  @override
  State<_TextSequence> createState() => _TextSequenceState();
}


class _TextSequenceState extends State<_TextSequence> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          brightness: Brightness.dark
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text sequence'),
        ),
        body: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Tap on text to move onto the next item, can be set to loop back to the start or not. Automatically proceeding to the next text is optional too.', textAlign: TextAlign.center,),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: _SequenceSampleText(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}



class _SequenceSampleText extends StatelessWidget {
  const _SequenceSampleText({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return TextAnimatorSequence(
      children: [
        TextAnimator('Red',
            incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
            atRestEffect: WidgetRestingEffects.bounce(),
            outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
            style: GoogleFonts.sanchez(textStyle: const TextStyle(fontWeight: FontWeight.w900, color: Colors.red, letterSpacing: -2, fontSize: 64))),
        TextAnimator('Green',
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(),
            atRestEffect: WidgetRestingEffects.fidget(),
            outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(),
            style: GoogleFonts.sanchez(textStyle: const TextStyle(fontWeight: FontWeight.w900, color: Colors.green, letterSpacing: -2, fontSize: 64))),
        TextAnimator('Blue',
            incomingEffect: WidgetTransitionEffects(blur: const Offset(2, 2), duration: const Duration(milliseconds: 600)),
            atRestEffect: WidgetRestingEffects.wave(),
            outgoingEffect: WidgetTransitionEffects(blur: const Offset(2, 2), duration: const Duration(milliseconds: 600)),
            style: GoogleFonts.sanchez(textStyle: const TextStyle(fontWeight: FontWeight.w900, color: Colors.blue, letterSpacing: -2, fontSize: 64))),
      ],
      tapToProceed: true,
      loop: true,
      transitionTime: const Duration(seconds: 4),
    );
  }
}



class _Fun extends StatefulWidget {
  const _Fun({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return const _Fun();
    });
  }

  @override
  State<_Fun> createState() => _FunState();
}

class _FunState extends State<_Fun> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          brightness: Brightness.dark
      ),
      child: WillPopScope(
        onWillPop: ()async{
          return true;
        },
        child: Scaffold(
            body: Container(decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.grey, Colors.blueGrey, Colors.blue], stops: [0.1, 0.3, 0.8])),
                child: Stack(
                  // fit: StackFit.expand,
                  children: [
                    Positioned(
                        top: 70,
                        left: 20,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: WidgetAnimator(
                              incomingEffect: WidgetTransitionEffects(duration: const Duration(milliseconds: 800), offset: const Offset(0, 100), scale: 0.6, opacity: 0.1, curve: Curves.bounceOut),
                              atRestEffect: WidgetRestingEffects.rotate(duration: const Duration(seconds: 30), curve: Curves.linear),
                              child: Image.asset(
                                'assets/sun.png',
                                width: 130,
                                height: 130,
                              )),
                        )),
                    Positioned(
                        top: 85,
                        left: 35,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: WidgetAnimator(
                              incomingEffect: WidgetTransitionEffects(duration: const Duration(milliseconds: 800), offset: const Offset(0, 100), scale: 0.6, opacity: 0.1, curve: Curves.bounceOut),
                              atRestEffect: WidgetRestingEffects.size(duration: const Duration(seconds: 10), effectStrength: 0.5, curve: Curves.easeInOut),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle
                                ),
                                width: 100,
                                height: 100,
                              )),
                        )),
                    Positioned(
                        top: 50,
                        left: -150,
                        child: WidgetAnimatorSequence(
                          transitionTime: const Duration(seconds: 3),
                          loop: true,
                          children: [
                            WidgetAnimator(
                                incomingEffect: WidgetTransitionEffects(curve: Curves.linear, delay: const Duration(seconds: 4), duration: const Duration(seconds: 36), offset: const Offset(600, 0), opacity: 1),
                                child: Image.asset(
                                  'assets/cloud1.png',
                                  key: const ValueKey('cloud1'),
                                  width: 130,
                                  height: 90,
                                )),
                            WidgetAnimator(
                                incomingEffect: WidgetTransitionEffects(curve: Curves.linear, delay: const Duration(seconds: 4), duration: const Duration(seconds: 40), offset: const Offset(600, 0), opacity: 1),
                                child: Image.asset(
                                  'assets/cloud2.png',
                                  key: const ValueKey('cloud2'),
                                  width: 130,
                                  height: 90,
                                )),
                          ],
                        )),
                    Center(
                      child: TextAnimatorSequence(
                        transitionTime: const Duration(seconds: 4),
                        loop: true,
                        children: [
                          TextAnimator(
                            'Breath in...',
                            incomingEffect: WidgetTransitionEffects.incomingOffsetThenScale(),
                            outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
                            atRestEffect: WidgetRestingEffects.size(effectStrength: 1.3, duration: const Duration(seconds: 12), curve: Curves.linear),
                            characterDelay: const Duration(milliseconds: 120),
                            spaceDelay: const Duration(milliseconds: 120),
                            style: GoogleFonts.lato(fontSize: 64, color: Colors.white54, fontWeight: FontWeight.w900),
                          ),
                          TextAnimator(
                            'Breath out...',
                            incomingEffect: WidgetTransitionEffects.incomingScaleDown(delay: const Duration(milliseconds: 600)),
                            outgoingEffect: WidgetTransitionEffects(offset: const Offset(-150,0), opacity: 0, scale: 0.3),
                            atRestEffect: WidgetRestingEffects.size(effectStrength: 0.3, duration: const Duration(seconds: 12), curve: Curves.linear),
                            characterDelay: const Duration(milliseconds: 0),
                            spaceDelay: const Duration(milliseconds: 400),
                            style: GoogleFonts.lato(fontSize: 64, color: Colors.white54, fontWeight: FontWeight.w900, letterSpacing: -4),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 95,
                        right: -140,
                        child: WidgetAnimatorSequence(
                          transitionTime: const Duration(seconds: 1),
                          loop: true,
                          children: [
                            WidgetAnimator(
                                incomingEffect: WidgetTransitionEffects(curve: Curves.linear, delay: const Duration(milliseconds: 1), duration: const Duration(seconds: 35), offset: const Offset(-600, 0), opacity: 1),
                                child: Image.asset(
                                  'assets/cloud3.png',
                                  key: const ValueKey('cloud1'),
                                  width: 160,
                                  height: 110,
                                )),
                            WidgetAnimator(
                                incomingEffect: WidgetTransitionEffects(curve: Curves.linear, delay: const Duration(seconds: 3), duration: const Duration(seconds: 40), offset: const Offset(-600, 0), opacity: 1),
                                child: Image.asset(
                                  'assets/cloud2.png',
                                  key: const ValueKey('cloud2'),
                                  width: 140,
                                  height: 95,
                                )),
                          ],
                        )),
                    Positioned(
                        bottom: 195,
                        right: -150,
                        child: WidgetAnimatorSequence(
                          transitionTime: const Duration(seconds: 1),
                          loop: true,
                          children: [
                            WidgetAnimator(
                                incomingEffect: WidgetTransitionEffects(curve: Curves.linear, delay: const Duration(seconds: 1), duration: const Duration(seconds: 75), offset: const Offset(-600, 0), opacity: 1),
                                child: Image.asset(
                                  'assets/cloud2.png',
                                  key: const ValueKey('cloud1'),
                                  width: 160,
                                  height: 110,
                                )),
                            WidgetAnimator(
                                incomingEffect: WidgetTransitionEffects(curve: Curves.linear, delay: const Duration(seconds: 10), duration: const Duration(seconds: 60), offset: const Offset(-600, 0), opacity: 1),
                                child: Image.asset(
                                  'assets/cloud1.png',
                                  key: const ValueKey('cloud2'),
                                  width: 140,
                                  height: 95,
                                )),
                          ],
                        ))


                  ],

                ))),
      ),
    );
  }
}



class _Fun2 extends StatefulWidget {
  const _Fun2({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return const _Fun2();
    });
  }

  @override
  State<_Fun2> createState() => _Fun2State();
}

class _Fun2State extends State<_Fun2> {


  @override
  Widget build(BuildContext context) {

    return Theme(
      data: ThemeData(
          brightness: Brightness.dark
      ),
      child: WillPopScope(
        onWillPop: ()async{
          return true;
        },
        child: Scaffold(
          appBar: AppBar(),
            body: Center(child: WidgetAnimator(
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 500)),
              //atRestEffect: WidgetRestingEffects.swing(),
              child: SizedBox(
                width: 390,
                height: 390,
                child: Stack(
                  children: [
                    Container(color: const Color(0xffc86490),),
                      Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    child: WidgetAnimator(
                                        incomingEffect: WidgetTransitionEffects(blur: const Offset(0, 4), offset: const Offset(0, -250), delay: const Duration(milliseconds: 500), curve: Curves.decelerate),
                                        outgoingEffect: WidgetTransitionEffects(blur: const Offset(0, 4), offset: const Offset(0, -250), delay: const Duration(milliseconds: 500), curve: Curves.easeIn),
                                        child: Container(
                                          key: const ValueKey('b'),
                                          height: 195,
                                          color: const Color(0xff94bbe9),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(child: Container()),
                                                TextAnimator('widget', initialDelay: const Duration(milliseconds: 1000),
                                                    spaceDelay: const Duration(milliseconds: 300),
                                                    characterDelay: const Duration(milliseconds: 0),
                                                    incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(),
                                                    style:  GoogleFonts.lato(textStyle: const TextStyle(height: 0.8, fontWeight: FontWeight.w900, letterSpacing: -2, fontSize: 56, ))),
                                                TextAnimator('and text', initialDelay: const Duration(milliseconds: 1200),
                                                  spaceDelay: const Duration(milliseconds: 0),
                                                  characterDelay: const Duration(milliseconds: 180),
                                                  incomingEffect: WidgetTransitionEffects(rotation: math.pi/3, scale: 2.5),
                                                  style: GoogleFonts.lato(textStyle: const TextStyle(height: 0.8, fontWeight: FontWeight.w900, letterSpacing: -2, fontSize: 48)), ),
                                                TextAnimator('animator',
                                                    spaceDelay: const Duration(milliseconds: 0),
                                                    characterDelay: const Duration(milliseconds: 180),
                                                    incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(),
                                                    atRestEffect: WidgetRestingEffects.pulse(effectStrength: 0.8),
                                                    initialDelay: const Duration(milliseconds: 1900),
                                                    style: GoogleFonts.lato(textStyle: const TextStyle(height: 0.9, fontWeight: FontWeight.w900, letterSpacing: -2, fontSize: 44))),
                                              ],
                                            ),
                                          ),
                                        ))),
                                Expanded(
                                    child: WidgetAnimator(
                                        incomingEffect: WidgetTransitionEffects(blur: const Offset(0, 4), offset: const Offset(0, -250), delay: const Duration(milliseconds: 700), curve: Curves.decelerate),
                                        outgoingEffect: WidgetTransitionEffects(blur: const Offset(0, 4), offset: const Offset(0, -250), delay: const Duration(milliseconds: 700), curve: Curves.easeIn),
                                        child: Container(
                                            height: 195,
                                            key: const ValueKey('d'), color: const Color(0xffb4b6de),
                                            child: WidgetAnimator(
                                                incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(duration: const Duration(seconds: 1), delay: const Duration(milliseconds: 2750), curve: Curves.bounceOut),
                                                atRestEffect: WidgetRestingEffects.rotate(effectStrength: 1, curve: Curves.linear),
                                                child: const Icon(Icons.sports_baseball, color: Color(0x668563ad),size: 48))))),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    child: WidgetAnimator(
                                        incomingEffect: WidgetTransitionEffects(blur: const Offset(0, 4), offset: const Offset(0, 250), delay: const Duration(milliseconds: 1100), curve: Curves.decelerate),
                                        outgoingEffect: WidgetTransitionEffects(blur: const Offset(0, 4), offset: const Offset(0, 250), delay: const Duration(milliseconds: 1100), curve: Curves.easeIn),
                                        child: Container(
                                            height: 195,
                                            key: const ValueKey('z'), color: const Color(0xffadd599),
                                            child: WidgetAnimator(
                                                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(duration: const Duration(seconds: 2), delay: const Duration(milliseconds: 4750), curve: Curves.elasticOut),
                                                atRestEffect: WidgetRestingEffects(
                                                        effectStrength: 0.5,
                                                        duration: const Duration(milliseconds: 500),
                                                        curve: Curves.easeInOut,
                                                        builder: (WidgetRestingEffects effects, AnimationController animationController) {
                                                          AnimationSettings _animationSettings = AnimationSettings(animationController: animationController);

                                                          double rotationAmount = 18;
                                                          rotationAmount = (-rotationAmount*(effects.effectStrength!)).clamp(-300, 300);

                                                          _animationSettings.offsetYAnimation = TweenSequence<double>(
                                                            <TweenSequenceItem<double>>[
                                                              TweenSequenceItem<double>(
                                                                tween: Tween<double>(begin: 0, end: 6)
                                                                    .chain(CurveTween(curve: Curves.easeInOut)),
                                                                weight: 50.0,
                                                              ),
                                                              TweenSequenceItem<double>(
                                                                tween: Tween<double>(begin: 6, end: 0)
                                                                    .chain(CurveTween(curve: Curves.bounceOut)),
                                                                weight: 50.0,
                                                              ),
                                                            ],
                                                          ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));


                                                          _animationSettings.rotationAnimation = TweenSequence<double>(
                                                            <TweenSequenceItem<double>>[
                                                              TweenSequenceItem<double>(tween: Tween<double>(begin: 0, end: 0).chain(CurveTween(curve: Curves.linear)),weight: 65.0,),
                                                              TweenSequenceItem<double>(tween: Tween<double>(begin: 0, end: math.pi/rotationAmount).chain(CurveTween(curve: Curves.easeInOut)),weight: 25.0,),
                                                              TweenSequenceItem<double>(tween: Tween<double>(begin: math.pi/rotationAmount, end: -math.pi/rotationAmount).chain(CurveTween(curve: Curves.easeInOut)),weight: 50.0,),
                                                              TweenSequenceItem<double>(tween: Tween<double>(begin: -math.pi/rotationAmount, end: 0).chain(CurveTween(curve: Curves.easeInOut)),weight: 25.0,),
                                                            ],
                                                          ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));

                                                          return _animationSettings;

                                                        }),
                                                child: const Icon(Icons.ring_volume, color: Color(0x66758b6b),size: 48))

                                        ))),
                                Expanded(
                                    child: WidgetAnimator(
                                        incomingEffect: WidgetTransitionEffects(blur: const Offset(4, 0), offset: const Offset(250, 0), delay: const Duration(milliseconds: 900), curve: Curves.decelerate),
                                        outgoingEffect: WidgetTransitionEffects(blur: const Offset(4, 0), offset: const Offset(250, 0), delay: const Duration(milliseconds: 900), curve: Curves.easeIn),
                                        child: Container(key: const ValueKey('h'),
                                            height: 195,
                                            child: WidgetAnimator(
                                                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(duration: const Duration(seconds: 3), delay: const Duration(seconds: 2)),
                                                atRestEffect: WidgetRestingEffects.size(effectStrength: 1),
                                                child: const Icon(Icons.airplanemode_active, color: const Color(0xffd67cbf),size: 48)),
                                            color: const Color(0xffeeaeca)))),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),)

        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

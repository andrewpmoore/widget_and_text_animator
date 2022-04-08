import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class Samples extends StatelessWidget {
  const Samples({Key? key}) : super(key: key);

  static Route<dynamic> route() {

    return MaterialPageRoute(builder: (BuildContext context) {
      return const Samples();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Samples'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              WidgetAnimator(child: ElevatedButton(onPressed: () {
                Navigator.of(context).push(SamplesIncoming.route());
              }, child: const Text('Incoming animations')), incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 300)),),
              WidgetAnimator(child: ElevatedButton(onPressed: () {
                Navigator.of(context).push(SamplesAtRest.route());
              }, child: const Text('At rest animations')), incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 600)),),
              WidgetAnimator(child: ElevatedButton(onPressed: () {
                Navigator.of(context).push(SamplesOutgoing.route());
              }, child: const Text('Outgoing animations')), incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 900)),),
            ],
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
      child: Container(width: 200, height: 200, color: Colors.red, child: const Center(child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('WidgetTransitionEffects.incomingScaleDown'),
      )), ),
    ),
  ),
    Center(
      key: const ValueKey('2'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingScaleUp(delay: const Duration(milliseconds: 500)),
        child: Container(width: 200, height: 200, color: Colors.blue, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.incomingScaleUp'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('3'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 500)),
        child: Container(width: 200, height: 200, color: Colors.green, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.incomingSlideInFromLeft'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('4'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(delay: const Duration(milliseconds: 500)),
        child: Container(width: 200, height: 200, color: Colors.cyan, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.incomingSlideInFromTop'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('5'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(delay: const Duration(milliseconds: 500)),
        child: Container(width: 200, height: 200, color: Colors.orange, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.incomingSlideInFromRight'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('6'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 500)),
        child: Container(width: 200, height: 200, color: Colors.deepPurple, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.incomingSlideInFromBottom'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('6b'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), curve: Curves.bounceOut),
        child: Container(width: 200, height: 200, color: Colors.deepPurple.withOpacity(0.5), child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.incomingSlideInFromBottom with custom curve and slower speed'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('7'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), blur: const Offset(20, 0)),
        child: Container(width: 200, height: 200, color: Colors.red.withOpacity(0.5), child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Blur X'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('8'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), blur: const Offset(0, 30)),
        child: Container(width: 200, height: 200, color: Colors.green.withOpacity(0.5), child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Blur Y'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('9'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), blur: const Offset(1.5, 1.5)),
        child: Container(width: 200, height: 200, color: Colors.blue.withOpacity(0.5), child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Blur X and Y'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('10'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), skew: const Offset(0.4, 0)),
        child: Container(width: 200, height: 200, color: Colors.green, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Skew X'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('11'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), skew: const Offset(0, 0.4)),
        child: Container(width: 200, height: 200, color: Colors.cyan, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Skew Y'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('12'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), skew: const Offset(0.4, 0.4)),
        child: Container(width: 200, height: 200, color: Colors.orange, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Skew X and Y'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('13'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), rotation: math.pi/4),
        child: Container(width: 200, height: 200, color: Colors.purple, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Rotate anti-clockwise'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('14'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), rotation: -math.pi/3),
        child: Container(width: 200, height: 200, color: Colors.red, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Rotate clockwise'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('15'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), scale: 0.5, offset: const Offset(150,-130), rotation: -math.pi/6, blur: const Offset(3,3), skew: const Offset(0.3, 0.3), opacity: 0.8),
        child: Container(width: 200, height: 200, color: Colors.blue, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Combination of scale, blue, offset, rotation and skew'),
        )), ),
      ),
    )

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Incoming Samples'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  currentPage==widgetList.length-1 ? currentPage = 0 : currentPage = currentPage + 1;
                });
              },
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  child: widgetList[currentPage]
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 600), duration: const Duration(milliseconds: 600),curve: Curves.easeOut),
                child: OutlinedButton(onPressed: (){
                  setState(() {
                    currentPage== 0 ? currentPage = widgetList.length-1 : currentPage = currentPage - 1;
                  });
                }, child: const Text('Previous')),
              ),
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 750), duration: const Duration(milliseconds: 600), curve: Curves.easeOut),
                child: OutlinedButton(onPressed: (){
                  setState(() {
                    currentPage==widgetList.length-1 ? currentPage = 0 : currentPage = currentPage + 1;
                  });
                }, child: const Text('Next')),
              ),
            ],),
          const SizedBox(height: 20,),
        ],
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outgoing Samples'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          const Text('Tap square to start outgoing animation'),
          const Expanded(child: SizedBox(),),
          IndexedStack(
            index: currentPage,
            children: widgetList,
          ),
          const Expanded(child: SizedBox(),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(duration: const Duration(milliseconds: 600),curve: Curves.easeOut),
                child: OutlinedButton(onPressed: (){
                  setState(() {
                    currentPage== 0 ? currentPage = widgetList.length-1 : currentPage = currentPage - 1;
                  });
                }, child: const Text('Previous')),
              ),
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 150), duration: const Duration(milliseconds: 600),curve: Curves.easeOut),
                child: OutlinedButton(onPressed: (){
                  setState(() {
                    currentPage==widgetList.length-1 ? currentPage = 0 : currentPage = currentPage + 1;
                  });
                }, child: const Text('Next')),
              ),
            ],),
          const SizedBox(height: 20,),
        ],
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects.outgoingScaleDown(),
            onOutgoingAnimationComplete: (_) async{
              await Future.delayed(const Duration(seconds: 1));
              setState(() {
                pressed = false;
              });
            },
            child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.deepPurple, child: const Center(child: Padding(
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.red, child: const Center(child: Padding(
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToLeft(),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.green, child: const Center(child: Padding(
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToRight(),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.blue, child: const Center(child: Padding(
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToTop(),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.cyan, child: const Center(child: Padding(
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.redAccent, child: const Center(child: Padding(
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(curve: Curves.elasticIn, duration: const Duration(milliseconds: 1500)),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.deepPurple.withOpacity(0.5), child: const Center(child: Padding(
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects(rotation: math.pi/3),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.deepOrange, child: const Center(child: Padding(
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects(rotation: -math.pi/3),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.deepOrangeAccent, child: const Center(child: Padding(
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects(skew: const Offset(0.3,0)),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.red, child: const Center(child: Padding(
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects(skew: const Offset(0,0.3)),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.green, child: const Center(child: Padding(
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects(skew: const Offset(0.3,0.3)),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.blue, child: const Center(child: Padding(
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects(blur: const Offset(5,0)),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.red, child: const Center(child: Padding(
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects(blur: const Offset(0,10)),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.green, child: const Center(child: Padding(
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects(blur: const Offset(2,2)),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.blue, child: const Center(child: Padding(
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
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects(rotation: math.pi/5, blur: const Offset(2,2), skew: const Offset(0.3, 0.2), offset: const Offset(30,40), scale: 0.5),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.pink, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Combination'),
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
        child: Container(width: 200, height: 200, color: Colors.red, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetRestingEffects.dangle'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('1a'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.dangle(numberOfPlays: 3, effectStrength: 0.5, duration: Duration(milliseconds: 750)),
        child: Container(width: 200, height: 200, color: Colors.redAccent, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetRestingEffects.dangle, repeat 3 times, half effect strength, faster'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('2'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.fidget(),
        child: Container(width: 200, height: 200, color: Colors.blue, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetRestingEffects.fidget'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('3'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.pulse(),
        child: Container(width: 200, height: 200, color: Colors.green, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetRestingEffects.pulse'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('3a'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.pulse(effectStrength: 0.6),
        child: Container(width: 200, height: 200, color: Colors.lightGreen, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetRestingEffects.pulse - less intense'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('4'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.swing(),
        child: Container(width: 200, height: 200, color: Colors.orange, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetRestingEffects.swing'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('5'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.rotate(curve: Curves.linear),
        child: Container(width: 200, height: 200, color: Colors.purple, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetRestingEffects.rotate'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('6'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.size(),
        child: Container(width: 200, height: 200, color: Colors.lightBlue, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetRestingEffects.size'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('7'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.slide(),
        child: Container(width: 200, height: 200, color: Colors.cyan, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetRestingEffects.slide'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('8'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.wave(),
        child: Container(width: 200, height: 200, color: Colors.red, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetRestingEffects.wave'),
        )), ),
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
            child: Container(width: 100, height: 100, color: Colors.red, child: const Center(child: Padding(
              padding: EdgeInsets.all(8.0),
            )), ),
          ),
          WidgetAnimator(
            atRestEffect: WidgetRestingEffects.wave(effectStrength: 2),
            child: Container(width: 120, height: 120, color: Colors.green, child: const Center(child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('WidgetRestingEffects.wave variations'),
            )), ),
          ),
          WidgetAnimator(
            atRestEffect: WidgetRestingEffects.wave(effectStrength: 16, duration: Duration(milliseconds: 3000)),
            child: Container(width: 100, height: 100, color: Colors.blueAccent, child: const Center(child: Padding(
              padding: EdgeInsets.all(8.0),
            )), ),
          ),
        ],
      ),
    ),
    Center(
      key: const ValueKey('9'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.bounce(),
        child: Container(width: 200, height: 200, color: Colors.green, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetRestingEffects.bounce'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('10'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.vibrate(),
        child: Container(width: 200, height: 200, color: Colors.blue, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetRestingEffects.vibrate'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('11'),
      child: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.vibrate(duration: Duration(milliseconds: 120), effectStrength: 1.3),
        child: Container(width: 200, height: 200, color: Colors.blueAccent, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetRestingEffects.vibrate with custom values'),
        )), ),
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
                TweenSequenceItem<double>(tween: Tween<double>(begin: 0, end: 150).chain(CurveTween(curve: Curves.easeInOut)),weight: 33.0,),
                TweenSequenceItem<double>(tween: Tween<double>(begin: 150, end: 150).chain(CurveTween(curve: Curves.easeInOut)),weight: 33.0,),
                TweenSequenceItem<double>(tween: Tween<double>(begin: 150, end: 0).chain(CurveTween(curve: Curves.easeInOut)),weight: 33.0,),
              ],
            ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));
            _animationSettings.offsetXAnimation = TweenSequence<double>(
              <TweenSequenceItem<double>>[
                TweenSequenceItem<double>(tween: Tween<double>(begin: 0, end: 80).chain(CurveTween(curve: Curves.easeInOut)),weight: 33.0,),
                TweenSequenceItem<double>(tween: Tween<double>(begin: 80, end: -80).chain(CurveTween(curve: Curves.easeInOut)),weight: 33.0,),
                TweenSequenceItem<double>(tween: Tween<double>(begin: -80, end: 0).chain(CurveTween(curve: Curves.easeInOut)),weight: 33.0,),
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
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('At rest Samples'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  currentPage==widgetList.length-1 ? currentPage = 0 : currentPage = currentPage + 1;
                });
              },
              child: Center(
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: widgetList[currentPage]
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 600), duration: const Duration(milliseconds: 600),curve: Curves.easeOut),
                child: OutlinedButton(onPressed: (){
                  setState(() {
                    currentPage== 0 ? currentPage = widgetList.length-1 : currentPage = currentPage - 1;
                  });
                }, child: const Text('Previous')),
              ),
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 750), duration: const Duration(milliseconds: 600), curve: Curves.easeOut),
                child: OutlinedButton(onPressed: (){
                  setState(() {
                    currentPage==widgetList.length-1 ? currentPage = 0 : currentPage = currentPage + 1;
                  });
                }, child: const Text('Next')),
              ),
            ],),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}

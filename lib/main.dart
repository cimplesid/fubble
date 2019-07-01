import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fubble/bubble.dart';
import 'package:fubble/model_logic.dart';
import 'package:fubble/setting.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fubble',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Bubbles(),
    );
  }
}

class Bubbles extends StatefulWidget {
  final double bubbleCount;
  final double maxBubbleSize;
  final double speed;
  final Color color;
  final double canvasWidth;
  final double canvasHeight;
  final String animation;
  final String gesture;

  Bubbles(
      {this.bubbleCount,
      this.maxBubbleSize,
      this.speed,
      this.color,
      this.canvasWidth,
      this.canvasHeight,
      this.animation,
      this.gesture});
  @override
  State<StatefulWidget> createState() {
    return _BubblesState();
  }
}

class _BubblesState extends State<Bubbles> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  List<Bubble> listOfBubbles;
  Offset offset = Offset(0, 0);
  List<Color> color = [
    Colors.red,
    Colors.blue,
    Colors.cyan,
    Colors.amber,
    Colors.pink,
    Colors.purple,
    Colors.teal,
    Colors.blueAccent,
    Colors.brown,
    Colors.green,
    Colors.indigo
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            RenderBox object = context.findRenderObject();
            Offset _localPosition =
                object.globalToLocal(details.globalPosition);
            listOfBubbles.forEach((bubble) {
              bubble.onDraw(_localPosition, bubble, context,
                  widget.gesture == null ? "Default" : widget.gesture);
            });
            offset = _localPosition;
          });
        },
        onPanEnd: (DragEndDetails details) => offset = Offset(0, 0),
        child: CustomPaint(
            painter: BubblePainter(
                bubbles: listOfBubbles, controller: animationController),
            size: Size(
              widget.canvasWidth == null
                  ? MediaQuery.of(context).size.width
                  : widget.canvasWidth,
              widget.canvasHeight == null
                  ? MediaQuery.of(context).size.height
                  : widget.canvasHeight,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.gesture),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Setting()));
        },
        backgroundColor: Colors.deepOrange,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    listOfBubbles = List();
    double i = widget.bubbleCount == null ? 200 : widget.bubbleCount;
    while (i > 0) {
      listOfBubbles.add(Bubble(
          widget.color == null ? color[Random().nextInt(10)] : widget.color,
          widget.maxBubbleSize == null ? 20 : widget.maxBubbleSize,
          widget.speed == null ? 0.2 : widget.speed));
      i--;
    }
    animationController = new AnimationController(
        duration: const Duration(minutes: 1000), vsync: this);
    animationController.addListener(() {
      changeBubblePosition();
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void changeBubblePosition() {
    listOfBubbles.forEach((bubble) => bubble.changeThePosition(
        widget.animation == null ? "Default" : widget.animation));
    setState(() {});
  }
}

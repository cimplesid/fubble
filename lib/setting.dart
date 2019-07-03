import 'package:flutter/material.dart';
import 'package:fubble/main.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  double bubbleCount = 200;
  double maxBubbleSize = 20;
  double speed = 1;
  Color color;
  double canvasWidth;
  double canvasHeight;
  String animation;
  String gesture;

  static const colors = <Color>[
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.blueGrey
  ];
  static const gestur = ['Default', 'CenterBlast', 'Dart', 'Attract', 'Eraser'];
  static const bubble = [
    'Default',
    'WallBreaker',
    'OnWeed',
    'Goodnbad',
    'Battle',
    'Rain'
  ];

  List<DropdownMenuItem<String>> animationList = bubble.map((b) {
    return DropdownMenuItem<String>(
      value: b,
      child: Text(
        b,
        style: TextStyle(color: Colors.black),
      ),
    );
  }).toList();
  final List<DropdownMenuItem<String>> gestureList = gestur.map((animation) {
    return DropdownMenuItem<String>(
      value: animation,
      child: Text(
        animation,
        style: TextStyle(color: Colors.black),
      ),
    );
  }).toList();
  final List<DropdownMenuItem<Color>> colorsList = colors.map((colr) {
    return DropdownMenuItem<Color>(
      value: colr,
      child: Text(
        colr.toString().padRight(5),
        style: TextStyle(color: colr),
      ),
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings_backup_restore),
            onPressed: () {
              setState(() {
                bubbleCount = 200;
                maxBubbleSize = 20;
                speed = 1;
                color = null;
                canvasWidth = null;
                canvasHeight = null;
              });
            },
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Bubbles(
                        bubbleCount: bubbleCount,
                        maxBubbleSize: maxBubbleSize,
                        speed: speed,
                        canvasWidth: MediaQuery.of(context).size.width,
                        canvasHeight: MediaQuery.of(context).size.height,
                      ))),
        ),
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              elevation: 2,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Number of bubbles',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      activeColor: Colors.indigoAccent,
                      min: 10.0,
                      divisions: 1040,
                      label: '${bubbleCount.round()}',
                      max: 1050.0,
                      onChanged: (value) {
                        setState(() => bubbleCount = value);
                      },
                      value: bubbleCount,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Card(
              elevation: 2,
              child: Column(
                children: <Widget>[
                  Text(
                    'Bubble Size',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    activeColor: Colors.indigoAccent,
                    min: 8.0,
                    divisions: 1040,
                    label: '${maxBubbleSize.round()}',
                    max: 50.0,
                    onChanged: (value) {
                      setState(() => maxBubbleSize = value);
                    },
                    value: maxBubbleSize,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Card(
              elevation: 2,
              child: Column(
                children: <Widget>[
                  Text(
                    'Bubble Speed',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    activeColor: Colors.indigoAccent,
                    min: 1.0,
                    divisions: 140,
                    label: '${speed.round()}',
                    max: 23.0,
                    onChanged: (value) {
                      setState(() => speed = value);
                    },
                    value: speed,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Card(
              elevation: 2,
              child: Column(
                children: <Widget>[
                  Text(
                    'Canvas width',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    activeColor: Colors.indigoAccent,
                    min: 120.0,
                    // label: '${canvasWidth}',
                    max: MediaQuery.of(context).size.width,
                    onChanged: (value) {
                      setState(() => canvasWidth = value);
                    },
                    value: canvasWidth == null
                        ? MediaQuery.of(context).size.width
                        : canvasWidth,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Card(
              elevation: 2,
              child: Column(
                children: <Widget>[
                  Text(
                    'Canvas Height',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    activeColor: Colors.indigoAccent,
                    min: 120.0,
                    max: MediaQuery.of(context).size.height,
                    onChanged: (value) {
                      setState(() => canvasHeight = value);
                    },
                    value: canvasHeight == null
                        ? MediaQuery.of(context).size.height
                        : canvasHeight,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Card(
              elevation: 2,
              child: Column(
                children: <Widget>[
                  Text(
                    'Bubble color',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9, right: 9),
                    child: DropdownButton(
                      underline: Container(),
                      value: color,
                      hint: Text('Choose custom bubble color'),
                      onChanged: (value) {
                        setState(() {
                          color = value;
                        });
                      },
                      items: this.colorsList,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 2,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Bubble animation',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 9, right: 9),
                        child: DropdownButton(
                          underline: Container(),
                          value: animation,
                          hint: Text('Default'),
                          onChanged: (value) {
                            setState(() {
                              animation = value;
                            });
                          },
                          items: this.animationList,
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'On Draw Effect',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 9, right: 9),
                        child: DropdownButton(
                          underline: Container(),
                          value: gesture,
                          hint: Text('Default'),
                          onChanged: (value) {
                            setState(() {
                              gesture = value;
                            });
                          },
                          items: this.gestureList,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Bubbles(
                                bubbleCount: bubbleCount,
                                maxBubbleSize: maxBubbleSize,
                                speed: speed,
                                color: color,
                                animation: animation,
                                gesture: gesture,
                                canvasWidth: canvasWidth,
                                canvasHeight: canvasHeight,
                              )));
                },
                child: Text(
                  'Save Settings',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
              ),
              decoration: BoxDecoration(shape: BoxShape.circle),
            ),
            Text(
              'Fubble v1.0',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

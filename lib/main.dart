import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_images_slider/flutter_images_slider.dart';

void main() => runApp(MyApp());

final List<String> imgList = [
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_1400297-1431017_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/1/images/m_2_773060-803780_z2y4b9%40cachet.dk_P2_day1.png?raw=true',
];

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return new MaterialApp(
//      title: 'Flutter Demo',
//      theme: new ThemeData(
//        primarySwatch: Colors.blue,
//      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int last = 0;
  int _current = 0;

  bool _value1 = false;
  bool _value2 = false;

  bool af = false;
  bool nsr = false;
  bool noise = false;
  bool other = false;

  Map<int, String> mapOfLabels = Map();

  // bool list = [false, false, false];

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);

  void _value2Changed(bool value) => setState(() => _value2 = value);

  @override
  void initState() {
    super.initState();

    print("length" + imgList.length.toString());

    for (int i = 0; i < imgList.length; i++) mapOfLabels[i] = "null";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(widget.title),
//      ),
      body: Stack(children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0),
            child: ImagesSlider(
              items: map<Widget>(imgList, (index, i) {
                // print(index);
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(i), fit: BoxFit.cover)),
                );
              }),
              // autoPlay: true,
              viewportFraction: 1.0,
              aspectRatio: 2.0,
              distortion: false,
              align: IndicatorAlign.bottom,
              indicatorWidth: 5,
              updateCallback: (index) {
                setState(() {
                  _current = index;
                  print("index= " + index.toString());

                  ///print(last);

                  ///
//                  if (index > last) {
//                    if (nsr == true) mapOfLabels[last] = "nsr";
//
//                    if (other == true) mapOfLabels[last] = "other";
//
//                    if (af == true) mapOfLabels[last] = "af";
//
//                    if (noise == true) mapOfLabels[last] = 'noise';
//
//                    af = false;
//                    nsr = false;
//                    noise = false;
//                    other = false;
//                  } else {
                  String label = mapOfLabels[index];
                  print("came inside else with lable = " + label);

                  switch (label) {
                    case "af":
                      {
                        af = true;
                        noise = false;
                        other = false;
                        nsr = false;
                        print("came inside switch af");
                      }
                      break;

                    case "noise":
                      {
                        //statements;

                        noise = true;
                        af = false;

                        other = false;
                        nsr = false;
                        print("came inside switch noise");
                      }
                      break;

                    case "other":
                      {
                        other = true;
                        af = false;
                        noise = false;

                        nsr = false;
                        print("came inside switch other");
                      }
                      break;

                    case "nsr":
                      {
                        //statements;
                        nsr = true;
                        noise = false;
                        other = false;
                        af = false;
                        print("came inside switch nsr");
                      }
                      break;

                    case "null":
                      {
                        af = false;
                        noise = false;
                        other = false;
                        nsr = false;
                      }
                      break;
                  }

                  // if (index > index) print(imgList[index]);
                });
              },
            )), // new Checkbox(value: _value1, onChanged: _value1Changed),
        //  new Checkbox(value: _value1, onChanged: _value1Changed),

        Container(
          padding: EdgeInsets.only(left: 2, top: 40),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Checkbox(
                    value: other,
                    onChanged: (bool newValue) {
                      setState(() {
                        print(_current);
                        other = newValue;

                        if (other == true) {
                          mapOfLabels[_current] = "other";

                          af = false;
                          nsr = false;
                          noise = false;
                        }
                      });
                    },
                  ),
                  Text("other"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: nsr,
                      onChanged: (bool newValue) {
                        setState(() {
                          nsr = newValue;
                          if (nsr == true) {
                            mapOfLabels[_current] = "nsr";
                            af = false;
                            other = false;
                            noise = false;
                          }
                        });
                      },
                    ),
                    Text("NSR"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: noise,
                      onChanged: (bool newValue) {
                        setState(() {
                          noise = newValue;
                          if (noise == true) {
                            mapOfLabels[_current] = "noise";
                            af = false;
                            other = false;
                            nsr = false;
                          }
                        });
                      },
                    ),
                    Text("Noise"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: af,
                      onChanged: (bool newValue) {
                        setState(() {
                          af = newValue;
                          if (af == true) {
                            mapOfLabels[_current] = "af";
                            noise = false;
                            other = false;
                            nsr = false;
                          }
                        });
                      },
                    ),
                    Text("AF"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('Save'),
        icon: Icon(Icons.save),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }
}

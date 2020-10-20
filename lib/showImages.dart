import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_images_slider/flutter_images_slider.dart';
import 'package:csv/csv.dart';

import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flash/flash.dart';
import 'package:uuid/uuid.dart';

import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:adaptive_dialog/adaptive_dialog.dart';

import 'main.dart';

List<String> imgList = [
  'https://github.com/devhci/af_images/blob/master/P2/z2y4b9%40cachet.dk/10/images/on_8_25607613-25638333_z2y4b9%40cachet.dk_P2_day10.png?raw=true'
];

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class ShowImages extends StatefulWidget {
  ShowImages({Key key, @required this.patientId}) : super(key: key);
  final String patientId;

  @override
  _ShowImagesState createState() => new _ShowImagesState();
}

class _ShowImagesState extends State<ShowImages> {
  //String root_name = "dr_kamal";
  String root_name = "helena_dk";

  bool isButtonenable = true;
  int startIndex = 0;

  int last = 0;
  int _current = 0;

  int total = 0;
  String patinetId;

  var info;
  var url = null;

  bool _value1 = false;
  bool _value2 = false;

  bool af = false;
  bool nsr = false;
  bool noise = false;
  bool PVC = false;
  bool flutter = false;
  bool other = false;
  bool sa = false;
  String patient;

  Map<int, String> mapOfLabels = Map();

  // bool list = [false, false, false];

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);

  void _value2Changed(bool value) => setState(() => _value2 = value);

  @override
  void initState() {
    super.initState();

    //widget.patientId;
    this.patinetId = widget.patientId.toString();
    print("PatientId= " + widget.patientId.toString());

    _sharedPref();

//    Future.delayed(Duration.zero, () {
//      setState(() {
//        patient = ModalRoute.of(context).settings.arguments;
//      });
//      print(patient);
//      //readCSV(patient);
//    });

    //loadAsset();
    readCSV(patinetId);

    print("length" + imgList.length.toString());

    //for (int i = 0; i < imgList.length; i++) mapOfLabels[i] = "null";
  }

  _sharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get("uuid") == null) prefs.setString("uuid", root_name);

    if (prefs.get(patinetId) == null) {
      prefs.setInt(patinetId, 0);
      setState(() {
        startIndex = prefs.get(patinetId);
        //_current = startIndex;
        //index=_current;
      });
    } else
      setState(() {
        startIndex = prefs.get(patinetId);
        //_current = startIndex;
        //index=_current;
      });
  }

  readCSV(String patient_id) async {
    StorageReference storageReference;
    String uuid;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.get("uuid") != null) uuid = prefs.get("uuid");

    storageReference = FirebaseStorage.instance
        .ref()
        .child("$uuid/patients/$patient_id" + ".csv");

    //storageReference.getData(100000);
    try {
      url = await storageReference.getDownloadURL();

      setState(() {
        if (url == null) {
          showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel:
                  MaterialLocalizations.of(context).modalBarrierDismissLabel,
              barrierColor: Colors.black45,
              transitionDuration: const Duration(milliseconds: 200),
              pageBuilder: (BuildContext buildContext, Animation animation,
                  Animation secondaryAnimation) {
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 10,
                    height: MediaQuery.of(context).size.height - 80,
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: Column(
                      children: [
                        RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ));
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: const Color(0xFF1BC0C5),
                        )
                      ],
                    ),
                  ),
                );
              });
        }
      });

      // print(url);
      await downloadFile(url, patient_id + ".csv");
    } catch (e) {
      print("Patient does not exists");
      print(url);

//      Future.delayed(Duration.zero, () {
//
//      })

    }

    //print(storageReference.getDownloadURL());

//    print("printing {7,0}" + myCSV[7][0].toString());
//
//    for (int i = 0; i < myCSV.rowsCount; i++)
//      for (int j = 0; j < myCSV.columnCount; j++) print(myCSV[i][j]);
  }

  Future<File> downloadFile(String url, String filename) async {
    var httpClient = http.Client();
    var request = new http.Request('GET', Uri.parse(url));
    var response = httpClient.send(request);
    String dir = (await getApplicationDocumentsDirectory()).path;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<List<int>> chunks = new List();
    int downloaded = 0;

    response.asStream().listen((http.StreamedResponse r) {
      r.stream.listen((List<int> chunk) {
        // Display percentage of completion
        debugPrint('downloadPercentage: ${downloaded / r.contentLength * 100}');

        chunks.add(chunk);
        downloaded += chunk.length;
      }, onDone: () async {
        // Display percentage of completion
        debugPrint('downloadPercentage: ${downloaded / r.contentLength * 100}');

        // Save the file
        File file = new File('$dir/$filename');
        final Uint8List bytes = Uint8List(r.contentLength);
        int offset = 0;
        for (List<int> chunk in chunks) {
          bytes.setRange(offset, offset + chunk.length, chunk);
          offset += chunk.length;
        }

        await file.writeAsBytes(bytes);

        final input = file.openRead();
        final fields = await input
            .transform(utf8.decoder)
            .transform(new CsvToListConverter())
            .toList();

        print(fields.length);
        setState(() {
          total = fields.length;
        });

        imgList.removeAt(
            0); //Remove First default element which is just from avaoiding device by zero index error

        for (int i = 0; i < fields.length; i++) {
          imgList.add(fields[i].elementAt(0));
          mapOfLabels[i] = fields[i].elementAt(2);
          print(fields[i].elementAt(0) + " " + fields[i].elementAt(2));
        }

        setState(() {
          mapOfLabels = mapOfLabels;
          imgList = imgList;
        });

        return file;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
//    imgList = null;
//    mapOfLabels = null;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return WillPopScope(
      onWillPop: () {
        print("back button pressed");
        return Future.value(false); // if true allow back else block it
      },
      child: new Scaffold(
//      appBar: new AppBar(
//        title: new Text("Hello"),
//        backgroundColor: Colors.transparent,
//      ),
        body: Stack(children: [
          Padding(
              padding: EdgeInsets.only(top: 0, left: 0, right: 0),
              child: InteractiveViewer(
                child: ImagesSlider(
                  items: map<Widget>(imgList, (index, i) {
                    print("Index here " + index.toString());
                    return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(i), fit: BoxFit.scaleDown)),
                    );
                  }),
                  // autoPlay: true,
                  viewportFraction: 1.3,
                  //realPage: ,
                  aspectRatio: 1,
                  distortion: false,
                  initialPage: startIndex,
                  align: IndicatorAlign.bottom,
                  indicatorWidth: 10,

                  updateCallback: (index) {
                    print("Index inside callback " + index.toString());
                    setState(() {
                      var str = imgList[index];
                      var s = str.split("/images/")[1].split("_")[0];

                      switch (s) {
                        case "m":
                          {
                            info = "Random sample between an onset and offset";
                          }
                          break;
                        case "on":
                          {
                            info = "AF Onset";
                          }
                          break;

                        case "off":
                          {
                            info = "AF Offset";
                          }
                          break;
                      }

                      print(imgList[index]);

                      _current = index;
                      print("index= " + index.toString());

                      String label = mapOfLabels[index];
                      print("came inside else with lable = " + label);

                      switch (label) {
                        case "af":
                          {
                            af = true;
                            noise = false;
                            PVC = false;
                            nsr = false;
                            flutter = false;
                            other = false;
                            sa = false;
                            print("came inside switch af");
                          }
                          break;

                        case "noise":
                          {
                            //statements;

                            noise = true;
                            af = false;

                            PVC = false;
                            nsr = false;
                            flutter = false;
                            other = false;
                            sa = false;
                            print("came inside switch noise");
                          }
                          break;

                        case "PVC":
                          {
                            PVC = true;
                            af = false;
                            noise = false;

                            nsr = false;
                            flutter = false;
                            other = false;
                            sa = false;
                            print("came inside switch PVC");
                          }
                          break;

                        case "nsr":
                          {
                            //statements;
                            nsr = true;
                            noise = false;
                            PVC = false;
                            af = false;
                            flutter = false;
                            other = false;
                            sa = false;
                            print("came inside switch nsr");
                          }
                          break;

                        case "flutter":
                          {
                            //statements;
                            flutter = true;
                            nsr = false;
                            noise = false;
                            PVC = false;
                            af = false;
                            other = false;
                            sa = false;

                            print("came inside switch flutter");
                          }
                          break;

                        case "other":
                          {
                            //statements;
                            other = true;
                            flutter = false;
                            nsr = false;
                            noise = false;
                            PVC = false;
                            af = false;
                            sa = false;

                            print("came inside switch other");
                          }
                          break;

                        case "sa":
                          {
                            //statements;
                            sa = true;
                            other = false;
                            flutter = false;
                            nsr = false;
                            noise = false;
                            PVC = false;
                            af = false;

                            print("came inside switch SA");
                          }
                          break;

                        case "null":
                          {
                            af = false;
                            noise = false;
                            PVC = false;
                            nsr = false;
                            flutter = false;
                            other = false;
                            sa = false;
                          }
                          break;
                      }

                      // if (index > index) print(imgList[index]);
                    });
                  },
                ),
              )), // new Checkbox(value: _value1, onChanged: _value1Changed),
          //  new Checkbox(value: _value1, onChanged: _value1Changed),

          Container(
            padding: EdgeInsets.only(left: 2, top: 5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: other,
                        onChanged: (bool newValue) {
                          setState(() {
                            other = newValue;
                            if (other == true) {
                              mapOfLabels[_current] = "other";
                              noise = false;
                              PVC = false;
                              nsr = false;
                              af = false;
                              flutter = false;
                              sa = false;
                            } else
                              mapOfLabels[_current] = "null";
                          });
                        },
                      ),
                      Text("Other"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: sa,
                        onChanged: (bool newValue) {
                          setState(() {
                            sa = newValue;
                            if (sa == true) {
                              mapOfLabels[_current] = "sa";
                              noise = false;
                              PVC = false;
                              nsr = false;
                              af = false;
                              flutter = false;
                              other = false;
                            } else
                              mapOfLabels[_current] = "null";
                          });
                        },
                      ),
                      Text("SA"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: PVC,
                        onChanged: (bool newValue) {
                          setState(() {
                            print(_current);
                            PVC = newValue;

                            if (PVC == true) {
                              mapOfLabels[_current] = "PVC";

                              af = false;
                              nsr = false;
                              noise = false;
                              flutter = false;
                              other = false;
                              sa = false;
                            } else
                              mapOfLabels[_current] = "null";
                          });
                        },
                      ),
                      Text("PVC"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
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
                              PVC = false;
                              noise = false;
                              flutter = false;
                              other = false;
                              sa = false;
                            } else
                              mapOfLabels[_current] = "null";
                          });
                        },
                      ),
                      Text("NSR"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
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
                              PVC = false;
                              nsr = false;
                              flutter = false;
                              other = false;
                              sa = false;
                            } else
                              mapOfLabels[_current] = "null";
                          });
                        },
                      ),
                      Text("Noise"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
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
                              PVC = false;
                              nsr = false;
                              flutter = false;
                              other = false;
                              sa = false;
                            } else
                              mapOfLabels[_current] = "null";
                          });
                        },
                      ),
                      Text("AF"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: flutter,
                        onChanged: (bool newValue) {
                          setState(() {
                            flutter = newValue;
                            if (flutter == true) {
                              mapOfLabels[_current] = "flutter";
                              noise = false;
                              PVC = false;
                              nsr = false;
                              af = false;
                              other = false;
                              sa = false;
                            } else
                              mapOfLabels[_current] = "null";
                          });
                        },
                      ),
                      Text("A-Flutter"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //mainAxisAlignment: alin,
                children: [
                  Text(
                      "Index= ${_current + 1}/$total , Last saved at = $startIndex ",
                      style: TextStyle(height: 5, fontSize: 15))
                ],
              ),
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: isButtonenable
              ? () {
                  // Add your onPressed code here!

                  print(mapOfLabels);

                  makeCSVfromlables(
                      mapOfLabels, imgList, widget.patientId.toString());
                }
              : null,
          label: Text('Save'),
          icon: Icon(Icons.save),
          backgroundColor: isButtonenable ? Colors.green : Colors.white70,
        ),
      ),
    );
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  makeCSVfromlables(Map<int, String> mapofLabels, List<String> imgList,
      String patientId) async {
    var fileName = 'labels.csv';

    setState(() {
      isButtonenable = false;
    });

    Directory tempDir = await getTemporaryDirectory();
    final File file = File("${tempDir.path}/$fileName");

    List<List<dynamic>> outer = List();
    for (int i = 0; i < mapofLabels.length; i++) {
      var str = imgList[i];
      List<dynamic> yourListOfLists = [
        imgList[i],
        str.split("/images/")[1].split('?')[0],
        mapOfLabels[i]
      ];
      outer.add(yourListOfLists);
    }

    String csv = const ListToCsvConverter().convert(outer);
    // print(csv);

    File result = await file.writeAsString('$csv');

    if (result == null) {
      print("Writing to file failed");
    } else {
      print("Successfully writing to file");

      print(" path of the created file" + result.path);
      //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.")

    }

    _uploadFile(result, patientId);
    print(csv);
  }

  void _showCenterFlash({
    FlashPosition position,
    FlashStyle style,
    Alignment alignment,
  }) {
    showFlash(
      context: context,
      duration: Duration(seconds: 2),
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: Colors.green,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: Colors.blue,
          position: position,
          style: style,
          alignment: alignment,
          enableDrag: false,
          onTap: () => controller.dismiss(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.white),
              child: Text(
                'File has been Saved',
              ),
            ),
          ),
        );
      },
    ).then((_) {
      if (_ != null) {
        _showMessage(_.toString());
      }
    });
  }

  void _showMessage(String message) {
    if (!mounted) return;
    showFlash(
        context: context,
        duration: Duration(seconds: 3),
        builder: (_, controller) {
          return Flash(
            controller: controller,
            position: FlashPosition.top,
            style: FlashStyle.grounded,
            child: FlashBar(
              icon: Icon(
                Icons.face,
                size: 36.0,
                color: Colors.black,
              ),
              message: Text(message),
            ),
          );
        });
  }

  Future<void> _uploadFile(File file, String patient) async {
    StorageReference storageReference;
    String uuid;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.get("uuid") != null) uuid = prefs.get("uuid");

    //uuid = uuid + "--" + DateTime.now().toUtc().toString();

    String day = DateTime.now().day.toString() +
        "-" +
        DateTime.now().month.toString() +
        "-" +
        DateTime.now().year.toString();

    storageReference = FirebaseStorage.instance
        .ref()
        .child("$uuid/patients/$patient" + ".csv");

    //storageReference.getData(100000);

    storageReference.getDownloadURL();

    final StorageUploadTask uploadTask = storageReference.putFile(file);

    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");

    if (downloadUrl != null) {
      setState(() {
        isButtonenable = true;
        prefs.setInt(patinetId, _current + 1);

        startIndex = _current + 1;
      });
      _showCenterFlash(alignment: Alignment.center);
      file.delete();
      //CircularProgressIndicator()
    }
  }
}

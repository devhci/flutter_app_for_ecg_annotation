import 'package:flutter/material.dart';

import 'P1.dart';
//import 'package:swipe_listview_selection/list_item_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    SystemChrome.setPreferredOrientations([
//      DeviceOrientation.landscapeLeft,
//      DeviceOrientation.landscapeRight,
//    ]);

    return new MaterialApp(
//      title: 'Flutter Demo',
//      theme: new ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: new MyHomePage(title: 'Flutter Demo Home Page'),

        home: new Home());
  }
}

class Home extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  List<ListItem<String>> list;
  @override
  void initState() {
    super.initState();
    populateData();
  }

  void populateData() {
    list = [];
    for (int i = 0; i < 20; i++) list.add(ListItem<String>("P $i"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patients"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: _getListItemTile,
      ),
    );
  }

  Widget _getListItemTile(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        print(index);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      },
//      onDoubleTap: () {
//        setState(() {
//          list[index].isSelected = true;
//          print(index);
//        });
//      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        color: list[index].isSelected ? Colors.red[100] : Colors.white,
        child: ListTile(
          title: Text(list[index].data),
        ),
      ),
    );
  }
}

class ListItem<T> {
  bool isSelected = false; //Selection property to highlight or not
  T data; //Data of the user
  ListItem(this.data); //Constructor to assign the data
}

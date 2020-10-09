import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'showImages.dart';

void main() => runApp(MyApp());

final dummySnapshot = [
  {"name": "P1", "images": 15},
  {"name": "P2", "images": 15},
  {"name": "P3", "images": 15},
  {"name": "P4", "images": 15},
  {"name": "P5", "images": 15},
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eCGAnnotation',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patients List')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('patients').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.numberOfImages.toString()),
          onTap: () => onTapNavigate(record.name),
        ),
      ),
    );
  }

  onTapNavigate(String name) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowImages(patientId: name),
          settings: RouteSettings(name: name),
        ));
  }
}

class Record {
  final String name;
  final int numberOfImages;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['images'] != null),
        name = map['name'],
        numberOfImages = map['images'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$numberOfImages>";
}

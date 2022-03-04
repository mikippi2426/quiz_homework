import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecordListScreen extends StatefulWidget {


  @override
  _RecordListScreenState createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<RecordListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "記録を見る",
            style: TextStyle(fontFamily: "miki"),
          ),
          centerTitle: true,
          backgroundColor: Colors.brown,
        ),
        body:
          Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/wood-pattern.jpg"),
              fit: BoxFit.cover,
            )),
        ),
      ),
    );
  }
}

import 'package:db_assets_folder_sample/main.dart';
import 'package:flutter/material.dart';

import 'package:db_assets_folder_sample/db/database.dart';

class RecordListScreen extends StatefulWidget {


  @override
  _RecordListScreenState createState() => _RecordListScreenState();
}


class _RecordListScreenState extends State<RecordListScreen> {
  List<Record> _recordList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllRecords();
  }

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
          child: _recordListWidget(),
        ),
      ),
    );
  }


  void _getAllRecords() async {
    _recordList = await database.allRecords;
    setState(() {});
  }

  Widget _recordListWidget() {
    return ListView.builder(itemCount: _recordList.length,
        itemBuilder: (context, int position) => _recordItem(position));
  }

  Widget _recordItem(int position) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            Text("${_recordList[position].id}"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${_recordList[position].date}"),
            ),
          ],
        ),
        subtitle:

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${_recordList[position].numberOfQuestion}" + "問"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${_recordList[position].numberOfCorrect}" + "問"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${_recordList[position].correctRate}" + "％"),
            ),
          ],
        ),

      ),
    );
  }
}

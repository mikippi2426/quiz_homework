import 'dart:math';

import 'package:db_assets_folder_sample/db/database.dart';
import 'package:db_assets_folder_sample/main.dart';
import 'package:db_assets_folder_sample/screens/record_list_screen.dart';
import 'package:db_assets_folder_sample/screens/test_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //背景画像の変更
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/wood-pattern.jpg'),
                fit: BoxFit.cover,
              )),
          child: Center(
            child: Column(
              children: [
                Text(
                  "シンプル",
                  style: TextStyle(fontSize: 90,fontFamily: "miki"),
                ),
                Text(
                  "クイズ",
                  style: TextStyle(fontSize: 90,fontFamily: "miki"),
                ),
                Expanded(
                    child: Image.asset(
                        "assets/images/castle.png")),
                Divider(
                  height: 30.0,
                  color: Colors.white,
                  indent: 8.0,
                  endIndent: 8.0,
                  thickness: 1.0,
                ),

                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: ()=>_startTestScreen(context),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.brown)
                    ),
                    child: Text(
                      "クイズをする",
                      style: TextStyle(fontSize: 22, color: Colors.deepOrangeAccent),
                    ),
                  ),
                ),
                //TODO radioボタン もしくは switchボタン
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: ()=>_startRecordListScreen(context),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.brown)
                    ),
                    child: Text(
                      "記録を見る",
                      style: TextStyle(fontSize: 22, color: Colors.white),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _startTestScreen(BuildContext context) {
    Navigator.push(
      context,MaterialPageRoute(builder: (context)=>TestScreen())
    );
  }

  _startRecordListScreen(BuildContext context) {
    Navigator.push(
      context,MaterialPageRoute(builder: (context)=>RecordListScreen())
    );
  }
}


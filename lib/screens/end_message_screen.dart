import 'package:db_assets_folder_sample/db/database.dart';
import 'package:db_assets_folder_sample/main.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class EndMessageScreen extends StatefulWidget {
  final int numberOfQuestions;
  final int numberOfCorrect;
  final int CorrectRate;
  final int numberOfId;
  var now = DateTime.now();

  EndMessageScreen(
      {required this.numberOfQuestions,
      required this.numberOfCorrect,
      required this.CorrectRate,
        required this.numberOfId,
      });

  @override
  _EndMessageScreenState createState() => _EndMessageScreenState();
}

class _EndMessageScreenState extends State<EndMessageScreen> {
  int numberOfId=0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => _backToHomeScreen(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "終了！",
              style: TextStyle(fontFamily: "miki"),
            ),
            centerTitle: true,
            backgroundColor: Colors.brown,
          ),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/wood-pattern.jpg'),
              fit: BoxFit.cover,
            )),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:16.0),
                    child: Text("お疲れさまでした。", style: TextStyle(fontSize: 28.0)),
                  ),
                  Text("今回のあなたの記録は、", style: TextStyle(fontSize: 28.0)),
                  Padding(
                    padding: const EdgeInsets.only(top:60,left:30),
                    child: Row(
                      children: [
                        Text("問題数：", style: TextStyle(fontSize: 50.0)),
                        Text(
                          widget.numberOfQuestions.toString(),
                          style: TextStyle(fontSize: 48.0),
                        ),
                        Text("問", style: TextStyle(fontSize: 50.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:40,left:30),
                    child: Row(
                      children: [
                        Text("正答数：", style: TextStyle(fontSize: 50.0)),
                        Text(widget.numberOfCorrect.toString(),
                            style: TextStyle(fontSize: 48.0)),
                        Text("問", style: TextStyle(fontSize: 50.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:40,left: 30),
                    child: Row(
                      children: [
                        Text("正答率：", style: TextStyle(fontSize: 50.0)),
                        Text(widget.CorrectRate.toString(),
                            style: TextStyle(fontSize: 48.0)),
                        Text("％", style: TextStyle(fontSize: 50.0)),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left:250,top:70),
                  child: Text("でした！", style: TextStyle(fontSize: 28.0)),
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _backToHomeScreen() async{

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    var now = DateTime.now();
    var record = Record(
      id: numberOfId,
      date: now.toString(),
      numberOfQuestion: widget.numberOfQuestions,
      correctRate: widget.CorrectRate,
      numberOfCorrect: widget.numberOfCorrect,
    );
    database.insertRecord(record);
    setState(() {

    });
    }



    }


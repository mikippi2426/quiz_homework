import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:db_assets_folder_sample/db/database.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int numberOfRemainig = 0;
  int numberOfCorrect = 0;
  int CorrectRate = 0;

  bool isCorrectIncorrectImageEnabled = true;

  bool isCorrect = true;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "テストをする",
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
          child: Stack(
            children: [
              Column(
                children: [
                  //スコア表示部分
                  _scorePart(),
                  //問題表示部分
                  _questionPart(),
                  //選択肢ボタン1
                  _answerChoiceButtonPart(),
                ],
              ),
              //〇・☓画像
              _correctIncorrectImage(),
            ],

          ),
        ),
      ),
    );
  }

  //スコア表示部分
  _scorePart() {
    return Container(
      height: 50.0,
      color: Colors.teal,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Table(
          children: [
            TableRow(children: [
              Center(
                  child: Text(
                    "残り問題数",
                    style: TextStyle(fontSize: 16.0),
                  )),
              Center(child: Text("正解数", style: TextStyle(fontSize: 16.0))),
              Center(
                  child: Text(
                    "正答率",
                    style: TextStyle(fontSize: 16.0),
                  )),
            ]),
            TableRow(children: [
              Center(
                  child: Text(
                    numberOfRemainig.toString(),
                    style: TextStyle(fontSize: 19.0),
                  )),
              Center(
                  child: Text(
                    numberOfCorrect.toString(),
                    style: TextStyle(fontSize: 19.0),
                  )),
              Center(
                  child: Text(
                    CorrectRate.toString(),
                    style: TextStyle(fontSize: 19.0),
                  )),
            ])
          ],
        ),
      ),
    );
  }

  //TODO 問題文
  Widget _questionPart() {
    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.black54,
      child: Column(
        children: [
          Text(
            "問題",
            style: TextStyle(fontSize: 36.0),
          ),
          Text(""),
        ],
      ),
    );
  }

  //選択肢部分
  _answerChoiceButtonPart() {
    return Table(
      children: [
        TableRow(children: [
          _answerChoiceButton1(),
          _answerChoiceButton2(),
        ]),
        TableRow(children: [
          _answerChoiceButton3(),
          _answerChoiceButton4(),
        ]),
      ],
    );
  }

  _answerChoiceButton1() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        onPressed: null,
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size.fromHeight(130)),
          backgroundColor: MaterialStateProperty.all(Colors.teal),
        ),
        child: Text("選択肢1",
            style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }

  Widget _answerChoiceButton2() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
          onPressed: null,
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size.fromHeight(130)),
            backgroundColor: MaterialStateProperty.all(Colors.teal),
          ),
          child: Text("選択肢2",
            style: TextStyle(fontSize: 24, color: Colors.white),
          )),
    );
  }

  _answerChoiceButton3() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
          onPressed: null,
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size.fromHeight(130)),
            backgroundColor: MaterialStateProperty.all(Colors.teal),
          ),
          child: Text("選択肢3",
              style: TextStyle(fontSize: 24, color: Colors.white))),
    );
  }

  _answerChoiceButton4() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
          onPressed: null,
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size.fromHeight(130)),
            backgroundColor: MaterialStateProperty.all(Colors.teal),
          ),
          child: Text("選択肢4",
              style: TextStyle(fontSize: 24, color: Colors.white))),
    );
  }

  _correctIncorrectImage() {
    if (isCorrectIncorrectImageEnabled) {
      if (isCorrect){
        return Center(child: Image.asset("assets/images/correct.png"));
      }return Center(child: Image.asset("assets/images/incorrect.png"));
    }else{
      return Container();
    }
  }
}

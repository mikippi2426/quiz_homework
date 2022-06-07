import 'dart:async';

import 'package:flutter/material.dart';
import 'package:db_assets_folder_sample/db/database.dart';

import '../main.dart';

import 'end_message_screen.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int numberOfQuestions = 10;
  int numberOfRemainig = 0;
  int numberOfCorrect = 0;
  int correctRate = 0;
  String _textQuestion = "";
  bool isCorrectIncorrectImageEnabled = false;
  bool isCorrect = false;
  List textQuestion = [];
  List<Question> _testDataList = [];
  int _index = 0; //今何問目
  late Question _currentQuestion;
  int numberOfId = 1;

  @override
  void initState() {
    super.initState();
    isCorrectIncorrectImageEnabled = false;
    isCorrect = false;
    numberOfCorrect = 0;
    correctRate = 0;
    numberOfRemainig = numberOfQuestions;
    _getTestData();
  }

  void _getTestData() async {
    _testDataList = await database.allQuestions;
    _testDataList.shuffle();
    _currentQuestion = _testDataList[_index];
    isCorrectIncorrectImageEnabled = false;
    setState(() {
      _textQuestion = _currentQuestion.question;
      textQuestion = [
        _currentQuestion.answer,
        _currentQuestion.choice1,
        _currentQuestion.choice2,
        _currentQuestion.choice3
      ];
      textQuestion.shuffle();
    });
  }

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
                  Expanded(child: _questionPart()),
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
      height: 60.0,
      color: Colors.teal,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Table(
          children: [
            TableRow(children: [
              tableRowText(rowText: "残り問題数".toString(), rowFontSize: 16.0),
              tableRowText(rowText: "正答数".toString(), rowFontSize: 16.0),
              tableRowText(rowText: "正答率".toString(), rowFontSize: 16.0),
            ]),
            TableRow(children: [
              tableRowText(
                  rowText: numberOfRemainig.toString(), rowFontSize: 19.0),
              tableRowText(
                  rowText: numberOfCorrect.toString(), rowFontSize: 19.0),
              tableRowText(rowText: correctRate.toString(), rowFontSize: 19.0),
            ])
          ],
        ),
      ),
    );
  }

  //〇・☓画像
  _correctIncorrectImage() {
    if (isCorrectIncorrectImageEnabled) {
      if (isCorrect) {
        return Center(child: Image.asset("assets/images/correct.png"));
      }
      return Center(child: Image.asset("assets/images/incorrect.png"));
    } else {
      return Container();
    }
  }

  // 問題文
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
          Padding(
            padding: const EdgeInsets.only(top: 28.0, left: 12.0, right: 8.0),
            child: Text(
              _textQuestion,
              style: TextStyle(fontSize: 36.0),
            ),
          ),
        ],
      ),
    );
  }

  //選択肢部分
  _answerChoiceButtonPart() {
    return Table(
      children: [
        TableRow(children: [
          _answerChoiceButton(textQuestion[0]),
          _answerChoiceButton(textQuestion[1]),
        ]),
        TableRow(children: [
          _answerChoiceButton(textQuestion[2]),
          _answerChoiceButton(textQuestion[3]),
        ]),
      ],
    );
  }

  //選択肢
  _answerChoiceButton(String textQuestion) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        onPressed: () => answerCheck(textQuestion),
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size.fromHeight(130)),
          backgroundColor: MaterialStateProperty.all(Colors.teal),
        ),
        child: Text(textQuestion,
            style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }

  //答え合わせ
  answerCheck(String textQuestion) {
    isCorrectIncorrectImageEnabled = true;
    numberOfRemainig -= 1;
    if (textQuestion == _currentQuestion.answer) {
      isCorrect = true;
      numberOfCorrect += 1;
    } else {
      isCorrect = false;
    }
    correctRate =
        (numberOfCorrect / (numberOfQuestions - numberOfRemainig) * 100)
            .toInt();
    setState(() {});
    Timer(Duration(seconds: 1), () => showAnswer());
    setState(() {});
  }

  showAnswer() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Container(
                width: 50,
                height: 50,
                child: isCorrect == true
                    ? Image.asset("assets/images/correct.png")
                    : Image.asset("assets/images/incorrect.png")),
            Column(
              children: [
                isCorrect == true ? Text("正解です") : Text("不正解です"),
                Text(_currentQuestion.answer),
              ],
            ),
          ],
        ),
        content: Column(
          children: [
            Text("～解説～"),
            Text(_currentQuestion.explanation),
          ],
        ),
        actions: [
          Center(
              child:
                  TextButton(onPressed: _nextQuestion, child: Text("次の問題に進む")))
        ],
      ),
    );
  }

  _nextQuestion() {
    if (numberOfRemainig == 0) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => EndMessageScreen(
                    numberOfQuestions: numberOfQuestions,
                    numberOfCorrect: numberOfCorrect,
                    correctRate: correctRate,
                    numberOfId: numberOfId,
                  )));
    } else {
      _getTestData();
      Navigator.pop(context);
    }
  }

  tableRowText({required String rowText, required double rowFontSize}) {
    return Center(
        child: Text(
      rowText,
      style: TextStyle(fontSize: rowFontSize),
    ));
  }
}

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:db_assets_folder_sample/db/database.dart';

import '../main.dart';
import 'dart:math' as math;

import 'end_message_screen.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int numberOfQuestions = 10;
  int numberOfRemainig = 0;
  int numberOfCorrect = 0;
  int CorrectRate = 0;
  String _textQuestion = "問題文が表示されるよ";
  String _textAnswerChoice1 = "選択肢1";
  String _textAnswerChoice2 = "選択肢2";
  String _textAnswerChoice3 = "選択肢3";
  String _textAnswerChoice4 = "選択肢4";
  bool isCorrectIncorrectImageEnabled = false;

  bool isCorrect = false;


  List<Question> _testDataList = [];
  int _index = 0; //今何問目
  late Question _currentQuestion;

  int numberOfId=1;

  @override
  void initState() {
    super.initState();
    isCorrectIncorrectImageEnabled = false;
    isCorrect = false;
    numberOfCorrect = 0;
    CorrectRate = 0;
    numberOfRemainig = numberOfQuestions;
    _getTestData();
  }

  void _getTestData() async {
    _testDataList = await database.allQuestions;
    _testDataList.shuffle();
    _currentQuestion = _testDataList[_index];
    print(_testDataList.toString());
    isCorrectIncorrectImageEnabled = false;
    setState(() {
      _textQuestion = _currentQuestion.question;
      var textQuestion = [
        _currentQuestion.answer,
        _currentQuestion.choice1,
        _currentQuestion.choice2,
        _currentQuestion.choice3
      ];
      textQuestion.shuffle();
      _textAnswerChoice1 = textQuestion[0];
      _textAnswerChoice2 = textQuestion[1];
      _textAnswerChoice3 = textQuestion[2];
      _textAnswerChoice4 = textQuestion[3];
      //print(textQuestion[0]);
      //print(textQuestion[1]);
      //print(textQuestion[2]);
      //print(textQuestion[3]);
    });
  }
  void _getRecordData() async {
    _testDataList = await database.allQuestions;
    _testDataList.shuffle();
    _currentQuestion = _testDataList[_index];
    print(_testDataList.toString());
    isCorrectIncorrectImageEnabled = false;
    setState(() {
      _textQuestion = _currentQuestion.question;
      var textQuestion = [
        _currentQuestion.answer,
        _currentQuestion.choice1,
        _currentQuestion.choice2,
        _currentQuestion.choice3
      ];
      textQuestion.shuffle();
      _textAnswerChoice1 = textQuestion[0];
      _textAnswerChoice2 = textQuestion[1];
      _textAnswerChoice3 = textQuestion[2];
      _textAnswerChoice4 = textQuestion[3];
      //print(textQuestion[0]);
      //print(textQuestion[1]);
      //print(textQuestion[2]);
      //print(textQuestion[3]);
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

  //選択肢1
  _answerChoiceButton1() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        onPressed: () => answerCheck1(),
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size.fromHeight(130)),
          backgroundColor: MaterialStateProperty.all(Colors.teal),
        ),
        child: Text(_textAnswerChoice1,
            style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }

  //答え合わせ1
  answerCheck1() {
    isCorrectIncorrectImageEnabled = true;
    numberOfRemainig -= 1;
    if (_textAnswerChoice1 == _currentQuestion.answer) {
      isCorrect = true;
      numberOfCorrect += 1;
    } else {
      isCorrect = false;
    }
    CorrectRate =
        (numberOfCorrect / (numberOfQuestions - numberOfRemainig) * 100)
            .toInt();
    setState(() {});
    Timer(Duration(seconds: 1), () => showAnswer());
    setState(() {});
  }

  Widget _answerChoiceButton2() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
          onPressed: () => answerCheck2(),
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size.fromHeight(130)),
            backgroundColor: MaterialStateProperty.all(Colors.teal),
          ),
          child: Text(
            _textAnswerChoice2,
            style: TextStyle(fontSize: 24, color: Colors.white),
          )),
    );
  }

  //答え合わせ2
  answerCheck2() {
    isCorrectIncorrectImageEnabled = true;
    numberOfRemainig -= 1;
    if (_textAnswerChoice2 == _currentQuestion.answer) {
      isCorrect = true;
      numberOfCorrect += 1;
    } else {
      isCorrect = false;
    }
    CorrectRate =
        (numberOfCorrect / (numberOfQuestions - numberOfRemainig) * 100)
            .toInt();
    setState(() {});
    Timer(Duration(seconds: 1), () => showAnswer());
    setState(() {});
  }

  _answerChoiceButton3() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
          onPressed: () => answerCheck3(),
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size.fromHeight(130)),
            backgroundColor: MaterialStateProperty.all(Colors.teal),
          ),
          child: Text(_textAnswerChoice3,
              style: TextStyle(fontSize: 24, color: Colors.white))),
    );
  }

  //答え合わせ3
  answerCheck3() {
    isCorrectIncorrectImageEnabled = true;
    numberOfRemainig -= 1;
    if (_textAnswerChoice3 == _currentQuestion.answer) {
      isCorrect = true;
      numberOfCorrect += 1;
    } else {
      isCorrect = false;
    }
    CorrectRate =
        (numberOfCorrect / (numberOfQuestions - numberOfRemainig) * 100)
            .toInt();
    setState(() {});
    Timer(Duration(seconds: 1), () => showAnswer());
    setState(() {});
  }

  _answerChoiceButton4() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
          onPressed: () => answerCheck4(),
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size.fromHeight(130)),
            backgroundColor: MaterialStateProperty.all(Colors.teal),
          ),
          child: Text(_textAnswerChoice4,
              style: TextStyle(fontSize: 24, color: Colors.white))),
    );
  }

  //答え合わせ4
  answerCheck4() {
    isCorrectIncorrectImageEnabled = true;
    numberOfRemainig -= 1;
    if (_textAnswerChoice4 == _currentQuestion.answer) {
      isCorrect = true;
      numberOfCorrect += 1;
    } else {
      isCorrect = false;
    }
    CorrectRate =
        (numberOfCorrect / (numberOfQuestions - numberOfRemainig) * 100)
            .toInt();
    setState(() {});
    Timer(Duration(seconds: 1), () => showAnswer());
    setState(() {});
  }

  showAnswer() {
    if (isCorrect == true) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Row(
            children: [
              Container(
                  width: 50,
                  height: 50,
                  child: Image.asset("assets/images/correct.png")),
              Column(
                children: [
                  Text("正解です"),
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
                child: TextButton(
                    onPressed: _NextQuestion, child: Text("次の問題に進む")))
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Row(
            children: [
              Container(
                  width: 50,
                  height: 50,
                  child: Image.asset("assets/images/incorrect.png")),
              Column(
                children: [
                  Text("不正解です"),
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
                child: TextButton(
                    onPressed: _NextQuestion, child: Text("次の問題に進む")))
          ],
        ),
      );
    }
  }

  _NextQuestion() {
    if (numberOfRemainig == 0) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => EndMessageScreen(
                  numberOfQuestions: numberOfQuestions,
                  numberOfCorrect: numberOfCorrect,
                  CorrectRate: CorrectRate,
                  numberOfId: numberOfId,
              )));
    } else {
      _getTestData();
      Navigator.pop(context);

    }
  }



  }


import 'package:calculator/bottons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final myTextStyle = TextStyle(fontSize: 50, color: Colors.blue);
  final List<String> buttons = [
    'AC', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Expanded(
              child: Container(
            color: Colors.black,
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(userQuestion,style: TextStyle(fontSize: 30,color: Colors.white),),),
                Container(
                  padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer,style: TextStyle(fontSize: 30,color: Colors.white)),),
              ],
            ),
          )),
          Container(
            color: Colors.black,
            child: Center(
                child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: buttons.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return MyBotton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion = '';
                        userAnswer = '';
                      });
                    },
                    bottonText: buttons[index],
                    color: Colors.black45,
                    textColor: Colors.green,
                  );

                  //Delete Button
                } else if (index == 1) {
                  return MyBotton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion = userQuestion.substring(0, userQuestion.length-1);
                      });
                    },
                    bottonText: buttons[index],
                    color: Colors.black45,
                    textColor: Colors.red,
                  );
                }

                // Equal Button
                else if (index == buttons.length-1) {
                  return MyBotton(
                    buttonTapped: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                    bottonText: buttons[index],
                    color: Colors.black45,
                    textColor: Colors.blue,
                  );
                }
                else if (index == buttons.length-2) {
                  return MyBotton(
                    buttonTapped: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                    bottonText: buttons[index],
                    color: Colors.black45,
                    textColor: Colors.blue,
                  );
                }
                // Rest of the Buttons
                else {
                  return MyBotton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion += buttons[index];
                      });
                    },
                    bottonText: buttons[index],
                    color: isOperator(buttons[index])
                        ? Colors.black45
                        : Colors.black45,
                    textColor:
                        isOperator(buttons[index]) ? Colors.blue : Colors.white,
                  );
                }
              },
            )),
          ),
        ]));
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion  = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}

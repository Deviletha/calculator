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

  final myTextStyle = TextStyle(fontSize: 30, color: Colors.teal[900]);
  final List<String> buttons = [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.tealAccent[100],
        body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Expanded(
              child: Container(
            color: Colors.tealAccent[50],
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(userQuestion,style: TextStyle(fontSize: 20),),),
                Container(
                  padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer,style: TextStyle(fontSize: 20)),),
              ],
            ),
          )),
          Container(
            color: Colors.tealAccent[100],
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
                      });
                    },
                    bottonText: buttons[index],
                    color: Colors.green,
                    textColor: Colors.white,
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
                    color: Colors.red,
                    textColor: Colors.white,
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
                    color: Colors.teal,
                    textColor: Colors.teal[50],
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
                    color: Colors.white,
                    textColor: Colors.teal,
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
                        ? Colors.teal
                        : Colors.teal[50],
                    textColor:
                        isOperator(buttons[index]) ? Colors.white : Colors.teal,
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

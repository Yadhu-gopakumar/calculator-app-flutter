import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = "0";
  String output = "0";
  String expression = "";
  double outputfontsize = 30;
  double inputfontsize = 60;
  Color inputfontclr = Colors.white;
  Color outputfontclr = Colors.grey;

  tapped(String buttontext) {
    setState(() {
      if (buttontext == "AC") {
        outputfontsize = 30;
        inputfontsize = 60;
        inputfontclr = Colors.white;
        outputfontclr = Colors.grey;

        input = "0";
        output = "0";
      } else if (buttontext == "=") {
        outputfontsize = 60;
        inputfontsize = 30;
        inputfontclr = Colors.grey;
        outputfontclr = Colors.white;
        expression = input;
        expression = expression.replaceAll("x", "*");
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          output = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          output = "Error";
        }
      } else if (buttontext == "<-") {
        outputfontsize = 30;
        inputfontsize = 60;
        inputfontclr = Colors.white;
        outputfontclr = Colors.grey;
        input = input.substring(0, input.length - 1);
        if (input == "") {
          input = "0";
        }
      } else {
        outputfontsize = 30;
        inputfontsize = 60;
        inputfontclr = Colors.white;
        outputfontclr = Colors.grey;
        if (input == "0") {
          input = buttontext;
        } else {
          input = input + buttontext;
        }
      }
    });
  }

  buildbutton(
    String buttonText,
    Color textcolor,
    Color buttoncolor,
    bool islong,
  ) {
    return TextButton(
      onPressed: () => tapped(buttonText),
      child: Container(
        decoration: BoxDecoration(
          color: buttoncolor,
          borderRadius: BorderRadius.circular(20),
        ),
        width: 74,
        height: islong ? 132 : 60,
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 30,
              color: textcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Calculator",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 40.0),
            child: FlutterLogo(
              size: 20,
              textColor: Colors.blue,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //output screen
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                //input output screen
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        input,
                        style: TextStyle(
                          color: inputfontclr,
                          fontSize: inputfontsize,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          output,
                          style: TextStyle(
                            color: outputfontclr,
                            fontSize: outputfontsize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //buttons
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildbutton("AC", Colors.orange, Colors.grey, false),
                  buildbutton("7", Colors.white, Colors.grey, false),
                  buildbutton("4", Colors.white, Colors.grey, false),
                  buildbutton("1", Colors.white, Colors.grey, false),
                  buildbutton("%", Colors.white, Colors.grey, false),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildbutton("<-", Colors.orange, Colors.grey, false),
                  buildbutton("8", Colors.white, Colors.grey, false),
                  buildbutton("5", Colors.white, Colors.grey, false),
                  buildbutton("2", Colors.white, Colors.grey, false),
                  buildbutton("0", Colors.white, Colors.grey, false),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildbutton("/", Colors.orange, Colors.grey, false),
                  buildbutton("9", Colors.white, Colors.grey, false),
                  buildbutton("6", Colors.white, Colors.grey, false),
                  buildbutton("3", Colors.white, Colors.grey, false),
                  buildbutton(".", Colors.white, Colors.grey, false),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildbutton("x", Colors.orange, Colors.grey, false),
                  buildbutton("-", Colors.white, Colors.grey, false),
                  buildbutton("+", Colors.white, Colors.grey, false),
                  buildbutton("=", Colors.white, Colors.orange, true),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

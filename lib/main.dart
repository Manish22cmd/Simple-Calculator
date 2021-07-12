import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  //const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  //const MyCalculator({Key? key}) : super(key: key);

  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String equationBar = "0";
  String resultBar = "0";
  String expression = "";
  double equationBarFontSize = 32;
  double resultBarFontSize = 38;

  buttonPressedAction(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equationBar = "0";
        resultBar = "0";
        equationBarFontSize = 32;
        resultBarFontSize = 38;
      } else if (buttonText == "⌫") {
        equationBar = equationBar.substring(0, equationBar.length - 1);
        equationBarFontSize = 38;
        resultBarFontSize = 32;
        // what if the equation is empty, then
        if (equationBar == "") {
          equationBar = "0";
        }
      } else if (buttonText == "=") {
        equationBarFontSize = 32;
        resultBarFontSize = 38;

        expression = equationBar;

        /*Parser p = Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();
        resultBar = '${exp.evaluate(EvaluationType.REAL, cm)}';
         */
        expression = expression.replaceAll("÷", "/");
        expression = expression.replaceAll("×", "*");
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          resultBar = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          resultBar = "Wrong Input";
        }
      } else if (buttonText == "%") {
        double result = int.parse(equationBar) / 100;
        resultBar = result.toString();
      } else {
        if (equationBar == "0") {
          equationBar = buttonText;
        } else {
          equationBar = equationBar + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: OutlineButton(
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressedAction(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Calculator",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equationBar,
              style: TextStyle(
                  fontSize: equationBarFontSize, fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              resultBar,
              style: TextStyle(
                  fontWeight: FontWeight.normal, fontSize: resultBarFontSize),
            ),
          ),
          // now, we have to divide the screen in two parts 50/50
          // and second we need to divide the keyboard from the bottom
          // for that we will be using Row widget
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        // call the buildButton() method
                        buildButton("AC", 1, Colors.orange.shade400),
                        buildButton("⌫", 1, Colors.orange.shade400),
                        buildButton("%", 1, Colors.orange.shade400),
                      ],
                    ),
                    TableRow(
                      children: [
                        // call the buildButton() method
                        buildButton("7", 1, Colors.grey.shade500),
                        buildButton("8", 1, Colors.grey.shade500),
                        buildButton("9", 1, Colors.grey.shade500),
                      ],
                    ),
                    TableRow(
                      children: [
                        // call the buildButton() method
                        buildButton("4", 1, Colors.grey.shade500),
                        buildButton("5", 1, Colors.grey.shade500),
                        buildButton("6", 1, Colors.grey.shade500),
                      ],
                    ),
                    TableRow(
                      children: [
                        // call the buildButton() method
                        buildButton("1", 1, Colors.grey.shade500),
                        buildButton("2", 1, Colors.grey.shade500),
                        buildButton("3", 1, Colors.grey.shade500),
                      ],
                    ),
                    TableRow(
                      children: [
                        // call the buildButton() method
                        buildButton(".", 1, Colors.grey.shade500),
                        buildButton("0", 1, Colors.grey.shade500),
                        buildButton("00", 1, Colors.grey.shade500),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("÷", 1, Colors.orange.shade400),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.orange.shade400),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1, Colors.orange.shade400),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("+", 1, Colors.orange.shade400),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 1, Colors.orange.shade400),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _input = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _input = '';
      } else if (buttonText == '=') {
        try {
          _input = _evaluateExpression();
        } catch (e) {
          _input = 'Error';
        }
      } else if (buttonText == 'DEL') {
        // Menghapus karakter terakhir
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
        }
      } else {
        _input += buttonText;
      }
    });
  }

  String _evaluateExpression() {
    Parser parser = Parser();
    Expression expression = parser.parse(_input);
    ContextModel contextModel = ContextModel();
    double result = expression.evaluate(EvaluationType.REAL, contextModel);
    return result.toString();
  }

  Widget _buildButton(String buttonText, Color textColor, Color bgColor) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
        ),
        child: TextButton(
          onPressed: () {
            _onButtonPressed(buttonText);
          },
          style: TextButton.styleFrom(
            primary: textColor,
            padding: EdgeInsets.all(20.0),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24,
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
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _input,
                style: TextStyle(fontSize: 36),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('7', Colors.black, Colors.white),
                        _buildButton('8', Colors.black, Colors.white),
                        _buildButton('9', Colors.black, Colors.white),
                        _buildButton('/', Colors.white, Colors.orange),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('4', Colors.black, Colors.white),
                        _buildButton('5', Colors.black, Colors.white),
                        _buildButton('6', Colors.black, Colors.white),
                        _buildButton('*', Colors.white, Colors.orange),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('1', Colors.black, Colors.white),
                        _buildButton('2', Colors.black, Colors.white),
                        _buildButton('3', Colors.black, Colors.white),
                        _buildButton('-', Colors.white, Colors.orange),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('.', Colors.black, Colors.white),
                        _buildButton('0', Colors.black, Colors.white),
                        _buildButton('DEL', Colors.black, Colors.white),
                        _buildButton('+', Colors.white, Colors.orange),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildButton('C', Colors.white, Colors.grey),
                        _buildButton('=', Colors.white, Colors.orange),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/styles.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double displayValue = 0;

  List<String> toCalculate = [];

  bool equalsPressed = false;
  bool autoEquals = false;

  void addValue(String value) {
    // check if last value is ".", "%" or the las number is a decimal (includes ".")
    if (toCalculate.length >= 24) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Maximo de caracteres alcanzado',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          duration: const Duration(milliseconds: 1500),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'OK',
            backgroundColor: Colors.red[700],
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
      return;
    }
    List<String> notAllowed = ['.', '%', '+', '-', '×', '÷'];
    if (toCalculate.isNotEmpty) {
      for (int i = toCalculate.length - 1; i >= 0; i--) {
        if (toCalculate[i] == '.') {
          if (value == '.') {
            return;
          }
          break;
        }
        if (toCalculate[i] == '%') {
          if (value == '%') {
            return;
          }
          break;
        }
        // if (i >= toCalculate.length - 1) {
        //   if (toCalculate[i] == '+' ||
        //       toCalculate[i] == '-' ||
        //       toCalculate[i] == '×' ||
        //       toCalculate[i] == '÷') {
        //     if (notAllowed.contains(value)) {
        //       return;
        //     }
        //     break;
        //   }
        // }
        // v2

        if (i >= toCalculate.length - 1) {
          if (notAllowed.contains(toCalculate[i])) {
            if (notAllowed.contains(value)) {
              return;
            }
            break;
          }
        }
        // if (toCalculate[i] == '+' ||
        //     toCalculate[i] == '-' ||
        //     toCalculate[i] == '×' ||
        //     toCalculate[i] == '÷') {
        //   if (value == '.') {
        //     return;
        //   }
        //   if (value == '%') {
        //     return;
        //   }
        //   break;
        // }

        // if (toCalculate[i] == '+' ||
        //     toCalculate[i] == '-' ||
        //     toCalculate[i] == '×' ||
        //     toCalculate[i] == '÷') {
        //   break;
        // }
        if (i == 0) {
          if (toCalculate[i] == '0' && value == '0') {
            return;
          }
          if (toCalculate[i] == '0' && value != '.') {
            toCalculate.removeAt(i);
          }
        }
      }
    } else {
      if (notAllowed.contains(value)) {
        return;
      }
    }
    toCalculate.add(value);
    setState(() {});
    if (equalsPressed == false) {
      autoEquals = true;
      calculate();
    }
  }

  void eraseLastValue() {
    if (toCalculate.isNotEmpty) {
      toCalculate.removeLast();
      setState(() {
        toCalculate = toCalculate;
      });
      if (equalsPressed == false) {
        calculate();
      }
    }
    setState(() {
      toCalculate = toCalculate;
    });
  }

  void clearAll() {
    if (toCalculate.isNotEmpty) {
      toCalculate.clear();
      setState(() {
        toCalculate = toCalculate;
      });
      if (equalsPressed == false) {
        calculate();
      }
    } else {
      equalsPressed = false;
      displayValue = 0;
    }
    setState(() {
      toCalculate = toCalculate;
    });
  }

  void calculate() {
    String expression = toCalculate.join('');

    if (expression == "") {
      setState(() {
        displayValue = 0;
      });
      return;
    }

    //
    expression = expression.replaceAll('×', '*');
    expression = expression.replaceAll('÷', '/');

    Parser p = Parser();
    // Expression exp = p.parse(expression);

    try {
      Expression exp = p.parse(expression);
      double result = exp.evaluate(EvaluationType.REAL, ContextModel());

      displayValue = result;
    } catch (e) {
      if (equalsPressed == true) {
        displayValue = double.nan;
      }
    }

    // double result = exp.evaluate(EvaluationType.REAL, ContextModel());

    // displayValue = result;

    setState(() {});

    return;

    //

    // for (int i = 0; i < expression.length; i++) {
    //   if (expression[i] == '+' ||
    //       expression[i] == '-' ||
    //       expression[i] == '*' ||
    //       expression[i] == '/' ||
    //       expression[i] == '%') {
    //     String left = expression.substring(0, i);
    //     String right = expression.substring(i + 1);
    //     double leftValue = double.parse(left);
    //     double rightValue = 0.0;

    //     if (expression[i] == '+' ||
    //         expression[i] == '-' ||
    //         expression[i] == '*' ||
    //         expression[i] == '/') {
    //       for (int j = i + 1; j < expression.length; j++) {
    //         if (expression[j] == '+' ||
    //             expression[j] == '-' ||
    //             expression[j] == '*' ||
    //             expression[j] == '/') {
    //           right = expression.substring(i + 1, j);
    //           rightValue = double.parse(right);
    //           break;
    //         }
    //         if (expression[j] == '%') {
    //           right = expression.substring(i + 1, j);
    //           rightValue = double.parse(right) / 100;
    //           break;
    //         }
    //         // if (expression[j] == '√') {
    //         //   right = expression.substring(i + 1, j);
    //         //   rightValue = double.parse(right);
    //         //   rightValue = sqrt(rightValue);
    //         //   break;
    //         // }
    //         if (j == expression.length - 1) {
    //           right = expression.substring(i + 1);
    //           rightValue = double.parse(right);
    //         }
    //       }
    //     }

    //     // if (expression[i] == '%') {
    //     //   // update the value to be a percentage (divide by 100)
    //     //   rightValue = rightValue / 100;
    //     //   expression = leftValue.toString() + expression.substring(i + 1);
    //     // }
    //     bool expressionCheck() {
    //       if (i >= expression.length) {
    //         return true;
    //       }
    //       return false;
    //     }

    //     if (expressionCheck() == true) {
    //       break;
    //     }
    //     if (expression[i] == '+') {
    //       displayValue = leftValue + rightValue;
    //       expression = displayValue.toString() + expression.substring(i + 1);
    //     }
    //     if (expressionCheck() == true) {
    //       break;
    //     }
    //     if (expression[i] == '-') {
    //       displayValue = leftValue - rightValue;
    //       expression = displayValue.toString() + expression.substring(i + 1);
    //     }
    //     if (expressionCheck() == true) {
    //       break;
    //     }
    //     if (expression[i] == '*') {
    //       displayValue = leftValue * rightValue;
    //       expression = displayValue.toString() + expression.substring(i + 1);
    //     }
    //     if (expressionCheck() == true) {
    //       break;
    //     }
    //     if (expression[i] == '/') {
    //       displayValue = leftValue / rightValue;
    //       expression = displayValue.toString() + expression.substring(i + 1);
    //     }
    //   }
    // }

    // setState(() {});
  }

  String displayText() {
    if (displayValue.isNaN) {
      equalsPressed = false;
      return 'Error';
    }
    if (displayValue.toString().endsWith('.0')) {
      return displayValue.toStringAsFixed(0);
    }
    for (int i = 0; i < displayValue.toString().length; i++) {
      String decimals = '';
      int lastNonZero = 0;
      if (displayValue.toString()[i] == '.') {
        decimals = displayValue.toString().substring(i + 1);
        for (int j = decimals.length - 1; j >= 0; j--) {
          if (decimals[j] != '0') {
            lastNonZero = j;
            break;
          }
        }
        if (lastNonZero == 0) {
          return displayValue.toStringAsFixed(0);
        } else {
          return displayValue.toStringAsFixed(lastNonZero + 1);
        }
      }
    }
    return displayValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input Display
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(right: 16, left: 16, top: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: MyStyles.displayBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  toCalculate.join(''),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Divider(
              height: 16,
              color: Colors.grey[900],
              thickness: 0,
              indent: 16,
              endIndent: 16,
            ),
            // Display
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: MyStyles.displayBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  displayText(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 48,
                    color: autoEquals ? Colors.grey[400] : Colors.white,
                  ),
                ),
              ),
            ),
            // Buttons
            // Row 1
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(
                  right: 16,
                  left: 16,
                  bottom: 4,
                ),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: buildOperatorButton('%'),
                    ),
                    const SizedBox(width: 8),
                    // Expanded(
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       addValue('√');
                    //     },
                    //     style: MyStyles.buttonStyle(context),
                    //     child: Text('√', style: MyStyles.buttonTextStyle),
                    //   ),
                    // ),
                    // const SizedBox(width: 8),
                    Expanded(
                      child: buildClearButton(),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: buildBackspaceButton(),
                    ),
                  ],
                ),
              ),
            ),
            // Row 2
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 4,
                  right: 16,
                  left: 16,
                  bottom: 4,
                ),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: buildButton('7'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: buildButton('8'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: buildButton('9'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: buildOperatorButton('÷'),
                    ),
                  ],
                ),
              ),
            ),
            // Row 3
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 4,
                  right: 16,
                  left: 16,
                  bottom: 4,
                ),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: buildButton('4'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: buildButton('5'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: buildButton('6'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: buildOperatorButton('×'),
                    ),
                  ],
                ),
              ),
            ),
            // Row 4
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 4,
                  right: 16,
                  left: 16,
                  bottom: 4,
                ),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: buildButton('1'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: buildButton('2'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: buildButton('3'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: buildOperatorButton('-'),
                    ),
                  ],
                ),
              ),
            ),
            // Row 5
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 4,
                  right: 16,
                  left: 16,
                  bottom: 4,
                ),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: buildButton('0'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: buildButton('.'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: buildResultButton(),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: buildOperatorButton('+'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String value) {
    return ElevatedButton(
      onPressed: () {
        addValue(value);
      },
      style: MyStyles.buttonStyle(context),
      child: Text(
        value,
        style: MyStyles.buttonTextStyle,
      ),
    );
  }

  Widget buildOperatorButton(String value) {
    return ElevatedButton(
      onPressed: () {
        addValue(value);
      },
      style: MyStyles.operatorButtonStyle(context),
      child: Text(
        value,
        style: MyStyles.operatorTextStyle(context),
      ),
    );
  }

  Widget buildClearButton() {
    return ElevatedButton(
      onPressed: () {
        clearAll();
      },
      style: MyStyles.clearButtonStyle(context),
      child: Text(
        'C',
        style: MyStyles.clearButtonTextStyle,
      ),
    );
  }

  Widget buildBackspaceButton() {
    return ElevatedButton(
      onPressed: () {
        eraseLastValue();
      },
      style: MyStyles.backspaceButtonStyle(context),
      child: MyStyles.backspaceIcon,
    );
  }

  Widget buildResultButton() {
    return ElevatedButton(
      onPressed: () {
        equalsPressed = true;
        autoEquals = false;
        calculate();
      },
      style: MyStyles.resultButtonStyle(context),
      child: Text(
        '=',
        style: MyStyles.buttonTextStyle,
      ),
    );
  }
}

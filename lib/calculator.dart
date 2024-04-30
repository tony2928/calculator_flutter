import 'package:calculator/styles.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double displayValue = 0;

  List<String> toCalculate = [];

  void addValue(String value) {
    setState(() {
      toCalculate.add(value);
    });
  }

  void eraseLastValue() {
    if (toCalculate.isNotEmpty) {
      toCalculate.removeLast();
    }
    setState(() {});
  }

  void clearAll() {
    if (toCalculate.isNotEmpty) {
      toCalculate.clear();
    } else {
      displayValue = 0;
    }
    setState(() {});
  }

  void calculate() {
    displayValue = 0;
    String expression = toCalculate.join('');
    expression = expression.replaceAll('×', '*');
    expression = expression.replaceAll('÷', '/');

    for (int i = 0; i < expression.length; i++) {
      if (expression[i] == '+' ||
          expression[i] == '-' ||
          expression[i] == '*' ||
          expression[i] == '/' ||
          expression[i] == '%') {
        String left = expression.substring(0, i);
        String right = expression.substring(i + 1);
        double leftValue = double.parse(left);
        double rightValue = 0.0;

        if (expression[i] == '+' ||
            expression[i] == '-' ||
            expression[i] == '*' ||
            expression[i] == '/') {
          for (int j = i + 1; j < expression.length; j++) {
            if (expression[j] == '+' ||
                expression[j] == '-' ||
                expression[j] == '*' ||
                expression[j] == '/') {
              right = expression.substring(i + 1, j);
              rightValue = double.parse(right);
              break;
            }
            if (expression[j] == '%') {
              right = expression.substring(i + 1, j);
              rightValue = double.parse(right) / 100;
              break;
            }
            // if (expression[j] == '√') {
            //   right = expression.substring(i + 1, j);
            //   rightValue = double.parse(right);
            //   rightValue = sqrt(rightValue);
            //   break;
            // }
            if (j == expression.length - 1) {
              right = expression.substring(i + 1);
              rightValue = double.parse(right);
            }
          }
        }

        // if (expression[i] == '%') {
        //   // update the value to be a percentage (divide by 100)
        //   rightValue = rightValue / 100;
        //   expression = leftValue.toString() + expression.substring(i + 1);
        // }
        if (expression[i] == '+') {
          displayValue = leftValue + rightValue;
          expression = displayValue.toString() + expression.substring(i + 1);
        }
        if (expression[i] == '-') {
          displayValue = leftValue - rightValue;
          expression = displayValue.toString() + expression.substring(i + 1);
        }
        if (expression[i] == '*') {
          displayValue = leftValue * rightValue;
          expression = displayValue.toString() + expression.substring(i + 1);
        }
        if (expression[i] == '/') {
          displayValue = leftValue / rightValue;
          expression = displayValue.toString() + expression.substring(i + 1);
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                displayValue.toString(),
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 48,
                  color: Colors.white,
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
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('%');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '%',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
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
                    child: ElevatedButton(
                      onPressed: () {
                        clearAll();
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        'C',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        eraseLastValue();
                      },
                      style: MyStyles.buttonStyle(context),
                      // child: Text(
                      //   '⌫',
                      //   style: MyStyles.buttonTextStyle,
                      // ),
                      child: const Icon(
                        Icons.backspace_rounded,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
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
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('7');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '7',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('8');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '8',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('9');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '9',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('÷');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '÷',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
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
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('4');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '4',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('5');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '5',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('6');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '6',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('×');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '×',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
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
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('1');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '1',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('2');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '2',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('3');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '3',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('-');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '-',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
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
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('0');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '0',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('.');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '.',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        calculate();
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '=',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        addValue('+');
                      },
                      style: MyStyles.buttonStyle(context),
                      child: Text(
                        '+',
                        style: MyStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

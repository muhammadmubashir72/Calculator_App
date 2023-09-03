import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  var input = "";
  var result = "0";
  List<String> buttonList = [
    "AC",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    "Del",
    "0",
    ".",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 233, 199, 7),
        appBar: AppBar(
          title: const Text("Calculator"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(220, 76, 209, 233),
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      input,
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      result,
                      style: const TextStyle(fontSize: 35, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
              height: 5,
              color: Colors.blueGrey,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                    itemCount: buttonList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      return MyButton(buttonList[index]);
                    }),
              ),
            )
          ],
        ));
  }

  Widget MyButton(String text) {
    return InkWell(
      splashColor: const Color.fromARGB(255, 233, 199, 7),
      onTap: () {
        setState(() {
          pressButton(text);
        });
      },
      child: Ink(
          decoration: BoxDecoration(
              color: getBgColor(text),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.amber,
                  blurRadius: 4,
                  spreadRadius: 0.5,
                  offset: Offset(-3, -3),
                )
              ]),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                color: getColor(text),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ))),
    );
  }

  getColor(String text) {
    if (text == "(" ||
        text == ")" ||
        text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "." ||
        text == "C") {
      return const Color.fromARGB(255, 63, 117, 2);
    }
    return Colors.white;
  }

  getBgColor(String text) {
    if (text == "AC") {
      return const Color.fromARGB(255, 87, 151, 13);
    }

    if (text == "=") {
      return const Color.fromARGB(255, 240, 81, 33);
    }
    return const Color.fromARGB(255, 180, 154, 7);
  }

  pressButton(String text) {
    if (text == "AC") {
      input = "";
      result = "0";
      return;
    }

    if (text == "Del") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (text == '=') {
      setState(() {
        result = calculateResult();

        input.split(text = "");

        if (input.endsWith(".0")) {
          input = input.replaceAll(".0", "");
        }

        if (result.endsWith(".0")) {
          result = result.replaceAll(".0", "");
          return;
        }
      });
    }
    input += text;
  }

  String calculateResult() {
    try {
      var exp = Parser().parse(input);
      var evl = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evl.toString();
    } catch (e) {
      return "Error";
    }
  }
}

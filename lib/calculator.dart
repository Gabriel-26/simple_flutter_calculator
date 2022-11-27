// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';




String strInput = "";
final textControllerInput = TextEditingController();
final textControllerResult = TextEditingController();

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);


  @override
  State<Calculator> createState() => _CalculatorState();

}

class _CalculatorState extends State<Calculator> {
  @override
  void initState() {
    super.initState();
    textControllerInput.addListener(() {});
    textControllerResult.addListener(() {});
  }
  @override
  void dispose() {
    textControllerInput.dispose();
    textControllerResult.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Calculator"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
           Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child:  TextField(
                decoration:  InputDecoration.collapsed(
                    hintText: "0",
                    hintStyle: TextStyle(
                      fontSize: 30,
                      fontFamily: 'RobotoMono',

                    )),
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'RobotoMono',
                  color: Colors.white,
                ),
                textAlign: TextAlign.right,
                controller: textControllerInput,
                onTap: () =>
                    FocusScope.of(context).requestFocus( FocusNode()),
              )),
           Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration:  InputDecoration.collapsed(
                    hintText: "Result",
                    // fillColor: Colors.deepPurpleAccent,
                    hintStyle: TextStyle(fontFamily: 'RobotoMono')),
                textInputAction: TextInputAction.none,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold
                  // color: Colors.deepPurpleAccent
                ),
                textAlign: TextAlign.right,
                controller: textControllerResult,
                onTap: () {
                  FocusScope.of(context).requestFocus( FocusNode());
                  // ClipboardManager.copyToClipBoard(textControllerResult.text).then((result) {
                  //   Fluttertoast.showToast(
                  //       msg: "Value copied to clipboard!",
                  //       toastLength: Toast.LENGTH_SHORT,
                  //       gravity: ToastGravity.CENTER,
                  //       timeInSecForIos: 1,
                  //       backgroundColor: Colors.blueAccent,
                  //       textColor: Colors.white,
                  //       fontSize: 16.0
                  //   );
                  // });
                },)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                btnAC("AC", Colors.grey, Colors.black),
                btnClear("=>", Colors.grey, Colors.black),
                numButton("%", Colors.grey, Colors.black),
                numButton("/", Colors.orange, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton("7", (Colors.grey[850])!, Colors.white),
                numButton("8", (Colors.grey[850])!, Colors.white),
                numButton("9", (Colors.grey[850])!, Colors.white),
                numButton("*", Colors.orange, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton("4", (Colors.grey[850])!, Colors.white),
                numButton("5", (Colors.grey[850])!, Colors.white),
                numButton("6", (Colors.grey[850])!, Colors.white),
                numButton("-", Colors.orange, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton("1", (Colors.grey[850])!, Colors.white),
                numButton("2", (Colors.grey[850])!, Colors.white),
                numButton("3", (Colors.grey[850])!, Colors.white),
                numButton("+", Colors.orange, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton("00", (Colors.grey[850])!, Colors.white),
                numButton("0", (Colors.grey[850])!, Colors.white),
                numButton(".", (Colors.grey[850])!, Colors.white),
                btnEqual("=", Colors.orange, Colors.white),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      );
  }

  Widget numButton( String btntext, btnColor, txtColor) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          textControllerInput.text = textControllerInput.text + btntext;
        });      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(70, 70), backgroundColor: btnColor,
        shape: CircleBorder(),
      ),
      child: Text(
        btntext,
        style: TextStyle(
          fontSize: 25,
          color: txtColor,
        ),
      ),
    );
  }
  Widget btnAC(btntext, Color btnColor, txtColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            textControllerInput.text = "";
            textControllerResult.text = "";
          });
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(70, 70), backgroundColor: btnColor,
          shape: CircleBorder(),
        ),
        child: Text(
          btntext,
          style: TextStyle(
              fontSize: 28.0, color: txtColor, fontFamily: 'RobotoMono'),
        ),
      ),
    );
  }

  Widget btnClear( String btntext, btnColor, txtColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      child: TextButton(
        onPressed: () {
          textControllerInput.text = (textControllerInput.text.length > 0)
              ? (textControllerInput.text
              .substring(0, textControllerInput.text.length - 1))
              : "";
        },
    style: TextButton.styleFrom(
    fixedSize: Size(70, 70), backgroundColor: btnColor,
    shape: CircleBorder(),
      ),
        child: Text(btntext,
        style: TextStyle(
            fontSize: 25, color: txtColor
        ),),
      )
    );
  }

  Widget btnEqual(btnText, btnColor, txtColor) {
    return ElevatedButton(
        onPressed: () {
    //Calculate everything here
    // Parse expression:
    Parser p = Parser();
    // Bind variables:
    ContextModel cm = ContextModel();
    Expression exp = p.parse(textControllerInput.text);
    setState(() {
      textControllerInput.text  =  exp.evaluate(EvaluationType.REAL, cm).toString();

    });
    },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(70, 70), backgroundColor: btnColor,
        shape: CircleBorder(),
      ),
        child: Text(
        btnText,
        style: TextStyle(fontSize: 35.0, color: txtColor),
    ),
  );
}
}
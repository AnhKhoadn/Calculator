import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {

  Widget button(String btnText, Color btnColor, Color textColor) {
    return Expanded(
      child: OutlinedButton(
          onPressed: () {
            calculation(btnText);
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: btnColor,
            padding: const EdgeInsets.all(25),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          ),
          child: Text(btnText, style: TextStyle(fontSize: 30, color: textColor))
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.only(right: 20, left: 10),
                child: Text(
                    '$text',
                    style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white)),
              )
          ),
          Row(
            children: [
              button('AC', Colors.red, Colors.white),
              button('+/-', Colors.white, Colors.black),
              button('%', Colors.white, Colors.black),
              button('/', Colors.orangeAccent, Colors.white),
            ],
          ),
          Row(
            children: [
              button('7', Colors.grey, Colors.white),
              button('8', Colors.grey, Colors.white),
              button('9', Colors.grey, Colors.white),
              button('x', Colors.orangeAccent, Colors.white),
            ],
          ),
          Row(
            children: [
              button('4', Colors.grey, Colors.white),
              button('5', Colors.grey, Colors.white),
              button('6', Colors.grey, Colors.white),
              button('-', Colors.orangeAccent, Colors.white),
            ],
          ),
          Row(
            children: [
              button('1', Colors.grey, Colors.white),
              button('2', Colors.grey, Colors.white),
              button('3', Colors.grey, Colors.white),
              button('+', Colors.orangeAccent, Colors.white),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                  child: OutlinedButton(
                      onPressed: () {
                        calculation('0');
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.fromLTRB(25, 25, 134, 25),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                      ),
                      child: const Text('0', style: TextStyle(fontSize: 30, color: Colors.white))
                  )
              ),
              button('.', Colors.grey, Colors.white),
              button('=', Colors.orangeAccent, Colors.white),
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  dynamic text = '0';
  double first = 0;
  double second = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  void calculation(btnText){
    if(btnText == 'AC'){
      text = '0';
      first = 0;
      second = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if(opr == '=' && btnText == '='){

      if(preOpr == '+'){
        finalResult = add();
      } else if(preOpr == '-'){
        finalResult = sub();
      } else if(preOpr == '*'){
        finalResult = mul();
      } else if(preOpr == '/'){
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '='){

      if(first == 0){
        first = double.parse(result);
      } else {
        second = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }

      preOpr = opr;
      opr = btnText;
      result = '';

    } else if(btnText == '%'){

      if(result.isNotEmpty){
        result = (double.parse(result) / 100).toString();
      } else {
        result = (first / 100).toString();
      }
      finalResult = containDecimal(result);

    } else if(btnText == '.'){
      if(!result.toString().contains('.')){
        result = result.toString() + '.';
      }
      finalResult = result;

    } else if(btnText == '+/-'){
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-' + result.toString();
      finalResult = result;
    }

    else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });

  }

  String add(){
    result = (first + second).toString();
    first = double.parse(result);
    return containDecimal(result);
  }

  String sub(){
    result = (first - second).toString();
    first = double.parse(result);
    return containDecimal(result);
  }

  String mul(){
    result = (first * second).toString();
    first = double.parse(result);
    return containDecimal(result);
  }

  String div(){
    result = (first / second).toString();
    first = double.parse(result);
    return containDecimal(result);
  }

  String containDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (splitDecimal[1] == '0') {
        return splitDecimal[0].toString();
      }
    }
    return result.toString();
  }
}

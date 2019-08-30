import 'package:flutter/material.dart';

class Questions extends StatelessWidget {
  final String questionText;

  // Questions ({var inputQuestionText}) {
  //   this.questionText = inputQuestionText;
  // }
  Questions(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Text(
          questionText,
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ));
  }
}

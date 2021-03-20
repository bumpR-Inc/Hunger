

import 'package:HUNGER/components/Colors.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';

class Logo extends StatelessWidget {
  double fontSize;

  Logo({fontSize: 35.0}) {
    this.fontSize = fontSize;
  }


  @override
  Widget build(BuildContext context) {
    return new GradientText(
      text: 'HUNGER',
      colors: [
        MyColors.darkOrange,
        MyColors.lightOrange
      ],
      style: TextStyle(fontFamily: 'Chalet', fontSize: this.fontSize)          
    );
  }
}
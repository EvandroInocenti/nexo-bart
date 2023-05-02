import 'dart:io';

import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeCustomRadioButton extends StatelessWidget {
  double elevation;
  double padding;
  double width;
  double height;
  bool absoluteZeroSpacing;
  Color selectedColor;
  Color unSelectedColor;
  TextStyle textStyle;
  bool enableShape;
  List<String> buttonLables;
  List<String> buttonValues;
  bool? radioButtonValue;

  AdaptativeCustomRadioButton({
    Key? key,
    required this.elevation,
    required this.padding,
    required this.width,
    required this.height,
    required this.absoluteZeroSpacing,
    required this.selectedColor,
    required this.unSelectedColor,
    required this.textStyle,
    required this.enableShape,
    required this.buttonLables,
    required this.buttonValues,
    required this.radioButtonValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoRadioChoice(
            choices: const {
              'sim': 'Sim',
              'não': 'Não',
            },
            onChange: (selectedGender) {},
            initialKeyValue: '',
          )
        : CustomRadioButton(
            elevation: elevation,
            padding: padding,
            height: height,
            width: width,
            enableShape: enableShape,
            selectedColor: selectedColor,
            unSelectedColor: unSelectedColor,
            absoluteZeroSpacing: absoluteZeroSpacing,
            buttonTextStyle: ButtonTextStyle(
                selectedColor: Colors.white,
                unSelectedColor: Colors.black,
                textStyle: textStyle),
            buttonLables: buttonLables,
            buttonValues: buttonValues,
            radioButtonValue: (value) {
              radioButtonValue = value == "Sim" ? true : false;
            },
          );
  }
}

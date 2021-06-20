
import 'package:flutter/material.dart';
import 'package:flutter_app/colors/colors.dart';

const double _buttonWidth = 120;
const double _imageWidth = 40;
const double _buttonPadding = 15.0;
const double _buttonBorderRadius = 20.0;
const double _buttonShadowBlurRadius = 10.0;
const double _buttonShadowSpreadRadius = 1.0;

Container defaultButtonContainer(text) {
  return Container(
    width: _buttonWidth,
    padding: EdgeInsets.all(_buttonPadding),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(_buttonBorderRadius),
      ),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            color: Colors.black26,
            spreadRadius: _buttonShadowSpreadRadius,
            blurRadius: _buttonShadowBlurRadius),
      ],
    ),
    child: Column(
      children: [
        Image.asset('assets/images/agreement.png',
          width: _imageWidth,
          height: _imageWidth,),
        Text(
          text,
          style: TextStyle(
              color: CustomColors.navy,
              fontWeight: FontWeight.bold,
              fontSize: 15),
        )
      ],
    ),
  );
}
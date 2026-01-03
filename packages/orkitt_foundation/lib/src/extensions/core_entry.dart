import 'package:flutter/material.dart';

extension CoreExt on BuildContext{
  EdgeInsets get uiPadding => MediaQuery.of(this).viewPadding;
  ThemeData get uiTheme => Theme.of(this);
  TextTheme get uiTextStyle => uiTheme.textTheme;
}
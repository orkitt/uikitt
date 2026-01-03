// Request focus to given FocusNode

import 'package:flutter/widgets.dart';

extension Focus on BuildContext {
  void requestFocus(FocusNode focus) {
    FocusScope.of(this).requestFocus(focus);
  }

  /// Request focus to given FocusNode
  void unFocus(FocusNode focus) {
    focus.unfocus();
  }
}

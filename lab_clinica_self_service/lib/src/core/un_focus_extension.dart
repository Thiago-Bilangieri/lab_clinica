
import 'package:flutter/widgets.dart';

extension UnFocusExtension on BuildContext {
  void unFocus()=>FocusScope.of(this).unfocus();
  
}
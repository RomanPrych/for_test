import 'package:flutter/cupertino.dart';

extension SizedBoxExtension on double {
  SizedBox get wsb => SizedBox(width: this);
  SizedBox get hsb =>  SizedBox(height: this);
}
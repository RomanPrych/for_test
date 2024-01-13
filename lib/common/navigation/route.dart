import 'package:flutter/material.dart';
import 'package:for_test/common/navigation/screens.dart';

MaterialPageRoute getPageRoute(String? name, {Object? arguments}) =>
    MaterialPageRoute(builder: (context) => getScreen(name, arguments: arguments));

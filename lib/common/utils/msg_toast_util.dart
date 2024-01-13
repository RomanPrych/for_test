import 'package:flutter/material.dart';
import 'package:for_test/common/extensions/sized_box_extension.dart';
import 'package:for_test/common/img.dart';
import 'package:for_test/common/navigation/navigation.dart';
import 'package:for_test/common/theme/app_theme.dart';
import 'package:flutter_svg/svg.dart';



class MsgToastUtil {
  static void showSnackBar(String msg, {Color? colorBackground, Color? textColor, int? milliseconds, String? image}) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12,),
        margin: EdgeInsets.zero,
        behavior:SnackBarBehavior.floating,
        backgroundColor: colorBackground ?? AppTheme.errorRedColor,
        content: Row(
          children: [
            if(image != null)
            SvgPicture.asset(image, colorFilter: ColorFilter.mode(textColor ?? AppTheme.errorRedColor,BlendMode.srcIn),),
            if(image != null)
            6.0.wsb,
            Text(
              msg,
              style: Theme.of(navigatorKey.currentContext!).textTheme.bodySmall?.copyWith(color: textColor ?? AppTheme.textColor),
            ),
          ],
        ),
        duration: Duration(milliseconds: milliseconds ?? 2500),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color valueColor;
  final double width;
  final double height;
  final double? value;

  const LoadingWidget({
    super.key,
    this.backgroundColor = Colors.transparent,
    this.valueColor = Colors.purple,
    this.width = 60.0,
    this.height = 60.0,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: 2,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(valueColor),
      ),
    );
  }
}

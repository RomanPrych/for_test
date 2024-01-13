import 'package:flutter/material.dart';
import 'package:for_test/common/theme/app_theme.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    this.title,
    this.margin,
    this.onTap,
    this.isActive,
    super.key,
  });

  final String? title;
  final bool? isActive;
  final EdgeInsets? margin;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: GestureDetector(
            onTap: isActive == true ? onTap : null,
            child: Container(
              margin: margin,
              alignment: Alignment.center,
              height: 56,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: isActive == true
                      ? AppTheme.activeTextFieldAndButtonColor
                      : AppTheme.grayColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                title ?? 'Button text',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      color: AppTheme.whiteColor,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

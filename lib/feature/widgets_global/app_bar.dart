import 'package:flutter/material.dart';
import 'package:for_test/common/extensions/sized_box_extension.dart';
import 'package:for_test/common/img.dart';
import 'package:for_test/common/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarMainWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarMainWidget({
    this.onBackTap,
    this.title,
    this.isCloseIcon,
    required this.onChanges,
    required this.onClearTap,
    required this.controller,
    required this.onSearchTap,
    super.key,
  });

  final Function()? onBackTap;
  final String? title;
  final Function(String value) onChanges;
  final Function() onClearTap;
  final Function() onSearchTap;
  final TextEditingController controller;
  final bool? isCloseIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 44,
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppTheme.textColor,
      toolbarHeight: 60,
      titleSpacing: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: _titleWidget(context),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          color: Colors.white,
          onPressed: onSearchTap,
        )
      ],
      leading: onBackTap == null
          ? null
          : GestureDetector(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 6),
                color: Colors.transparent,
                child: SvgPicture.asset(
                  Img.backArrow,
                  fit: BoxFit.none,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
    );
  }

  Widget _titleWidget(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        20.0.wsb,
        Text(title ?? 'empty'),
        10.0.wsb,
        Expanded(
          child: TextField(
            autofocus: true,
            onChanged: onChanges,
            controller: controller,
            cursorColor: const Color(0xff1E1929),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xff1E1929),
                ),
            decoration: InputDecoration(
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: const Color(0xff959498)),
              hintText: 'Search here..',
              contentPadding: const EdgeInsets.all(10),
              suffixIcon: _sufixIcon(onClearTap, isCloseIcon),
              suffixIconConstraints: const BoxConstraints(maxWidth: 40),
              fillColor: const Color(0xffF4F4F4),
              filled: true,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppTheme.activeTextFieldAndButtonColor, width: 3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  )),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sufixIcon(Function() onCloseTap, bool? isIcon) {
    if (isIcon != true) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: onCloseTap,
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.centerLeft,
        child: const Icon(
          Icons.clear,
          size: 30,
          color: AppTheme.errorRedColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

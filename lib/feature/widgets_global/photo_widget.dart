import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:for_test/common/img.dart';
import 'package:for_test/common/theme/app_theme.dart';
import 'package:for_test/feature/widgets_global/loading_widget.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    this.photo,
    required this.width,
    this.isOval,
    required this.height,
    this.errorBuilderWidget,
    Key? key,
  }) : super(key: key);
  final String? photo;
  final double? width, height;
  final Widget? errorBuilderWidget;
  final bool? isOval;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: photo == null ? const EdgeInsets.all(5) : null,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: photo == null ? AppTheme.emptyProfileBackground : null,
        borderRadius: BorderRadius.circular(100),
      ),
      child: photo != null && photo!.isNotEmpty
          ? _photoWidget(Image.network(
        photo ?? '',
        fit: BoxFit.cover,
        loadingBuilder: (context, widget, event) {
          return event != null
              ? LoadingWidget(
            value: event.cumulativeBytesLoaded / event.expectedTotalBytes!,
          )
              : widget;
        },
        errorBuilder: (context, object, stackTrace) => ifError,
      ),)
          : ifError,
    );
  }
  Widget _photoWidget(Widget child){
    return isOval == true? ClipOval(
      child: child,
    ):ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: child,);
  }

  Widget get ifError => errorBuilderWidget ?? SvgPicture.asset(Img.profile);
}

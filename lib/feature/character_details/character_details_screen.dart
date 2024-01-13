import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:for_test/common/img.dart';
import 'package:for_test/common/navigation/navigation.dart';
import 'package:for_test/common/theme/app_theme.dart';
import 'package:for_test/data/models/person_model.dart';
import 'package:for_test/feature/character_details/provider/character_provider.dart';
import 'package:for_test/feature/character_details/widget/character_widget.dart';
import 'package:for_test/feature/widgets_global/loading_widget.dart';
import 'package:provider/provider.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.textColor,
          automaticallyImplyLeading: false,
          leadingWidth: 50,
          title: Text(value.state.titleText),
          leading: GestureDetector(
            onTap: () => Nav.pop(),
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 6),
              color: Colors.transparent,
              child: SvgPicture.asset(
                Img.backArrow,
                fit: BoxFit.none,
                colorFilter: const ColorFilter.mode(
                    AppTheme.whiteColor, BlendMode.srcIn),
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        body: _getPersonBodyWidget(value),
      );
    });
  }

  Widget _getPersonBodyWidget(CharacterProvider value) {
    if (value.state.isError) {
      return Center(
        child: Text('Error:\n${value.state.errorText}'),
      );
    }
    return value.state.isLoading
        ? const Center(
            child: LoadingWidget(),
          )
        : CharacterWidget(value.state.model);
  }
}

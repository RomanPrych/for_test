import 'package:flutter/material.dart';
import 'package:for_test/common/extensions/sized_box_extension.dart';
import 'package:for_test/common/theme/app_theme.dart';
import 'package:for_test/data/models/person_model.dart';
import 'package:for_test/feature/widgets_global/photo_widget.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget(this.model, {super.key});

  final PersonModel? model;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model?.name ?? '',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          12.0.hsb,
          PhotoWidget(
            width: null,
            height: null,
            photo: model?.image,
          ),
          12.0.hsb,
          Text(
            model?.status ?? '',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: model?.status == 'Alive'
                      ? AppTheme.greenColor
                      : AppTheme.errorRedColor,
                ),
          ),
          10.0.hsb,
          ..._descWidget('Gender:', model?.gender, context),
          ..._descWidget(
              'Number of episodes: ', model?.episode?.length.toString(), context),
          ..._descWidget('Species:', model?.species, context),
          ..._descWidget('Last known location:', model?.location?.name, context),
          ..._descWidget('Origin:', model?.origin?.name, context),
          ..._descWidget('Was created:', model?.created.toString(), context),
        ],
      ),
    );
  }

  List<Widget> _descWidget(String? text, String? value, BuildContext context) {
    return [
      Text(
        text ?? 'no data',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.grayText),
      ),
      5.0.hsb,
      Text(
        value ?? 'no data',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      10.0.hsb,
    ];
  }
}

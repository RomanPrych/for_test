import 'package:flutter/material.dart';
import 'package:for_test/common/extensions/sized_box_extension.dart';
import 'package:for_test/common/navigation/navigation.dart';
import 'package:for_test/common/theme/app_theme.dart';
import 'package:for_test/data/models/person_model.dart';
import 'package:for_test/feature/widgets_global/photo_widget.dart';

class PersonItem extends StatelessWidget {
  const PersonItem(
    this.model,
    this.color,
    this.isOval, {
    super.key,
  });

  final PersonModel? model;
  final bool isOval;
  final int color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Nav.openCharacterDetailScreen(model?.id ?? 0),
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Color(color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            20.0.wsb,
            PhotoWidget(
              photo: model?.image,
              isOval: isOval,
              width: 43,
              height: 43,
            ),
            20.0.wsb,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.0.hsb,
                  Text(
                    model?.name ?? 'No name',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.whiteColor,
                          fontSize: 16,
                        ),
                  ),
                  2.0.hsb,
                  Text(
                    '${model?.status} - ${model?.species}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: model?.status == 'Alive'
                              ? AppTheme.greenColor
                              : AppTheme.errorRedColor,
                        ),
                  ),
                  10.0.hsb,
                ],
              ),
            ),
            20.0.wsb,
          ],
        ),
      ),
    );
  }
}

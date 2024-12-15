import 'package:e_commercial_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:e_commercial_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ChoiceChipSet extends StatelessWidget {
  const ChoiceChipSet({
    super.key,
    this.text = '',
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;
  @override
  Widget build(BuildContext context) {
    final isColor = THelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected? TColors.white : null),
        avatar: isColor? CircularContainer(width: 50, height: 50, backgroundColor: THelperFunctions.getColor(text)!) : null,
        labelPadding: isColor? const EdgeInsets.all(0) : null,
        padding: isColor? const EdgeInsets.all(0) : null,
        shape: THelperFunctions.getColor(text) != null ? const CircleBorder() : null,
        backgroundColor: isColor? THelperFunctions.getColor(text)! : null,
      ),
    );
  }
}

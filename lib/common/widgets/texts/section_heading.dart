
import 'package:flutter/material.dart';


class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.buttonTitle = "View all",
    this.showActionButton = true,
    this.textColor,
    this.onPressed,
  });

  final String title, buttonTitle;
  final bool showActionButton;
  final Color? textColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelMedium!.apply(color: textColor, fontWeightDelta: 4, fontSizeFactor: 1.5),
          maxLines: 1, overflow: TextOverflow.ellipsis,),
        if (showActionButton) TextButton(onPressed: onPressed, child: Text(buttonTitle, style: TextStyle(fontWeight: FontWeight.bold),)),
      ],
    );
  }
}
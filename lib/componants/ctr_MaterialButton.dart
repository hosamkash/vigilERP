import 'package:flutter/material.dart';

import '../shared/sharedDesigne.dart';

class ctr_MaterialButton extends StatelessWidget {
  late EdgeInsetsGeometry? Padding;
  late double Weidth;
  late double HeightValue;
  late Color BackColor;
  late BorderRadiusGeometry? BorderRadius;
  late String TextValue = '';
  late TextStyle? FontStyle;
  late TextAlign TextAlignLable;
  late bool VisibleIconButton;
  late IconData IconButton;
  late Color IconButtonColore;
  late double IconButtonSpaceWithText;
  late double IconButtonSize;
  late VoidCallback onPressed;

  ctr_MaterialButton(
      {Key? key,
      this.Padding,
      this.Weidth = double.infinity,
      this.HeightValue = 40.0,
      this.BackColor = Colors.transparent,
      this.BorderRadius,
      this.TextValue = '',
      this.FontStyle = const TextStyle(fontSize: 13, color: sharedDesigne.defaultColorFont),
      this.TextAlignLable = TextAlign.center,
      this.VisibleIconButton = false,
      this.IconButton = Icons.person,
      this.IconButtonColore = Colors.white,
      this.IconButtonSpaceWithText = 20,
      this.IconButtonSize = 20,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: Padding,
      child: Container(
        padding: const EdgeInsets.all(7),
        width: Weidth,
        height: HeightValue,
        decoration: BoxDecoration(
          color: BackColor,
          borderRadius: BorderRadius,
        ),
        child: Row(
          children: [
            if(VisibleIconButton)
            Icon(
              IconButton,
              color: IconButtonColore,
              size: IconButtonSize,
            ),
            SizedBox(width: IconButtonSpaceWithText),
            Text(
              TextValue,
              style: FontStyle,
              textAlign: TextAlignLable,
            ),
          ],
        ),
      ),
      onPressed: () => onPressed(),
    );
  }
}

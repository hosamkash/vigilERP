import 'package:flutter/material.dart';

class ctr_AlertDialog {
  static Future showListFilter(
    BuildContext context, {
    ShapeBorder? shape,
    Color? backgroundColor,
    double? elevation,
    Widget? content,
    bool? useSafeArea,
    bool? barrierDismissible,
  }) {
   return showDialog(
      context: context,
      // barrierColor: barrierColor ?? Colors.white,
      useSafeArea: useSafeArea ?? true,
      barrierDismissible: barrierDismissible ?? false,
      builder: (BuildContext context) {
        return Dialog(
          shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: backgroundColor ?? Colors.white,
          elevation: elevation ?? 4,
          child: content,
        );
      },
    );
  }
}

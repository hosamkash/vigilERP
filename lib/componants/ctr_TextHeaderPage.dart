import 'package:flutter/material.dart';

class ctr_TextHeaderPage extends StatelessWidget {
  late Color? color;

  // late Icon? SufixIcon;
  late BoxBorder? border;
  TextEditingController? Controller ;

  // late TextInputType TextType;
  late String text;

  // late Icon? PrefixIcon;
  late TextStyle? style;
  late BorderRadiusGeometry? borderRadius;
  late EdgeInsetsGeometry? padding;

  ctr_TextHeaderPage({
    Key? Key,
    this.Controller,
    this.color,
    this.style,
    this.borderRadius,
    // this.SufixIcon,
    this.border,
    // this.TextType = TextInputType.text,
    this.text = '',
    this.padding,
    // this.PrefixIcon,
  }) : super(key: Key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius, //?? BorderRadiusDirectional.all(Radius.circular(10)),
        border: border,
      ),
      child: Text(
        (Controller != null ? Controller!.text : text) ,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.start,
        style: style ?? const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
      ),
    );
  }
}

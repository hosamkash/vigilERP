import 'package:flutter/material.dart';

class ctr_TextFormField_Password extends StatefulWidget {
  late bool IsobscureText;
  late TextEditingController? Controller;
  late TextInputType TextType;
  late String Lable;
  late Icon? PrefixIcon;
  late String? Function(String?)? OnValidate;
  late String? Function(String?)? OnChanged;
  late String? Function()? OnTap;
  late String? Function(String?)? OnFieldSubmitted;

  ctr_TextFormField_Password({
    Key? Key,
    this.IsobscureText = false,
    this.Controller,
    this.TextType = TextInputType.visiblePassword,
    this.Lable = '',
    this.PrefixIcon,
    this.OnValidate,
    this.OnChanged,
    this.OnTap,
    this.OnFieldSubmitted,
  }) : super(key: Key);

  @override
  State<ctr_TextFormField_Password> createState() =>
      _ctr_TextFormField_PasswordState();
}

class _ctr_TextFormField_PasswordState
    extends State<ctr_TextFormField_Password> {
  late GestureDetector gesture_Detector;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5),
      height: 45,
      child: TextFormField(
        controller: widget.Controller,
        keyboardType: widget.TextType,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.start,
        obscureText: widget.IsobscureText,
        style: const TextStyle(fontSize: 17, color: Colors.black),
        decoration: InputDecoration(
          label: Text(widget.Lable),
          prefixIcon: widget.PrefixIcon,
          border: const OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 0.3  ,horizontal: 2), // حشوة داخلية ثابتة
          suffixIcon: GestureDetector(
            onLongPress: () {
              setState(() {
                widget.IsobscureText = false;
              });
            },
            onLongPressEnd: (details) {
              setState(() {
                widget.IsobscureText = true;
              });
            },
            child: IconButton(
              icon: const Icon(Icons.remove_red_eye),
              onPressed: () {},
            ),
          ),
        ),
        validator: widget.OnValidate,
        onChanged: widget.OnChanged,
        onTap: widget.OnTap,
        onFieldSubmitted: widget.OnFieldSubmitted,
      ),
    );
  }
}

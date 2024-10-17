import 'package:flutter/material.dart';

class ctr_DropDowenListString extends StatefulWidget {
  @override
  _ctr_DropDowenListStringState createState() => _ctr_DropDowenListStringState();

  String? selectedValue;
  String hintLable;
  List<String> lstDataString;
  TextStyle? itemsTextStyle;
  TextStyle? hintTextStyle;
  EdgeInsets? padding;
  double? menuMaxHeightValue;
  BorderRadius? borderRadius;
  bool showClearIcon;
  // double? height;
  late int? Function(String? returenValue)? OnChanged;
  late String? Function(String?)? OnValidate;

  ctr_DropDowenListString({
    this.hintLable = '',
    this.showClearIcon = true,
    this.lstDataString = const [],
    this.itemsTextStyle,
    this.hintTextStyle,
    this.padding,
    this.menuMaxHeightValue,
    this.borderRadius,
    // this.height,
    this.OnChanged,
    this.OnValidate,
  });
}

class _ctr_DropDowenListStringState extends State<ctr_DropDowenListString> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding:  EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5),
            // height: widget.height ?? 50,
            child: DropdownButtonFormField<String>(
              value: widget.selectedValue,
              hint: Text(
                widget.hintLable,
                style: widget.hintTextStyle ?? const TextStyle(fontSize: 15.0, color: Colors.grey),
              ),
              items: widget.lstDataString.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: widget.itemsTextStyle ?? const TextStyle(fontSize: 11.0, color: Colors.grey),
                  ),
                );
              }).toList(),
              onChanged: (String? val) {
                setState(() {
                  widget.selectedValue = val;
                  // print('selectedValue : ${widget.selectedValue}');
                  if (widget.OnChanged != null) {
                    widget.OnChanged!(widget.selectedValue);
                  }
                });
              },
              validator: widget.OnValidate,
              // validator: (val) {
              //   setState(() {
              //     if (val == null ) {
              //       widget.height = 55;
              //     } else
              //       widget.height = 50;
              //
              //     widget.OnValidate!(val);
              //   });
              //   return null;
              // },

              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
              ),
              dropdownColor: Colors.white,
              elevation: 2,
              menuMaxHeight: widget.menuMaxHeightValue ?? 250,
              borderRadius: widget.borderRadius ,

            ),
          ),
        ),

        if (widget.showClearIcon == true)
        IconButton(
          onPressed: () {
            setState(() {
              // print('selectedValue --------- ${widget.selectedValue}');
              widget.selectedValue = null;
            });
          },
          icon: const Icon(Icons.clear),
          color: Colors.black,
        ),
      ],
    );
  }
}

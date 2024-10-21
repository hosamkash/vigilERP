import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ctr_TextFormField extends StatefulWidget {
  late TextAlign? TextAlignValue;
  late Widget? SufixIcon;
  late Widget? sufix;
  late bool IsobscureText;
  late bool Isenabled = true;
  late InputBorder border = OutlineInputBorder();
  late TextEditingController? Controller;
  late TextInputType TextType;
  late TextStyle? textStyle;
  late String Lable;
  late TextStyle? labelStyle;
  late Widget? PrefixIcon;
  late EdgeInsets? padding;
  // double? height;
  late bool? autoSelectData;
  late bool? readOnly;
  late bool? useAsBarcodeControle;
  late int? maxLines;
  late int? minLines;
  late FocusNode? focusNode;

  late String? Function(String?)? OnValidate;
  late String? Function(String?)? OnChanged;
  late String? Function(String?)? OnSubmitted;
  late String? Function()? OnTap;

  ctr_TextFormField({
    Key? Key,
    this.TextAlignValue,
    this.SufixIcon,
    this.sufix,
    this.IsobscureText = false,
    this.Controller,
    this.Isenabled = true,
    this.border = const OutlineInputBorder(),
    this.TextType = TextInputType.text,
    this.textStyle,
    this.Lable = '',
    this.labelStyle,
    this.PrefixIcon,
    this.padding = const EdgeInsets.all(0),
    // this.height = 50,
    this.autoSelectData,
    this.readOnly,
    this.useAsBarcodeControle,
    this.maxLines,
    this.minLines,
    this.focusNode,
    this.OnValidate,
    this.OnChanged,
    this.OnSubmitted,
    this.OnTap,
  }) : super(key: Key);

  @override
  State<ctr_TextFormField> createState() => _ctr_TextFormFieldState();
}

class _ctr_TextFormFieldState extends State<ctr_TextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5),
      // height: widget.height ,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.Controller,
              enabled: widget.Isenabled,
              keyboardType: widget.TextType,
              textDirection: TextDirection.ltr,
              textAlign: widget.TextAlignValue ?? TextAlign.center,
              style: widget.textStyle ?? const TextStyle(fontSize: 17, color: Colors.black),
              obscureText: widget.IsobscureText,
              readOnly: widget.readOnly ?? false,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              focusNode: widget.focusNode,
              decoration: InputDecoration(
                label: Text(widget.Lable),
                labelStyle: widget.labelStyle ?? const TextStyle(fontSize: 17, color: Colors.grey),
                prefixIcon: widget.PrefixIcon,
                suffixIcon: widget.SufixIcon,
                fillColor: Colors.white,
                filled: true,
                suffix: widget.sufix,
                border: widget.border,
                contentPadding: EdgeInsets.symmetric(vertical: 0.3, horizontal: 2), // حشوة داخلية ثابتة
              ),

               validator: widget.OnValidate,
              // validator: (val) {
              //   setState(() {
              //     if (val == null || val.isEmpty) {
              //       widget.height = widget.height! + 10;
              //     } else
              //       widget.height = 50;
              //   });
              //    return widget.OnValidate != null ? widget.OnValidate!(val) : null;
              // },
              onChanged: widget.OnChanged,
              onTap: () {
                // if(autoSelectData == true )  {
                //   Controller!.selection = TextSelection(baseOffset: 0, extentOffset: Controller!.text.length);
                // }
                widget.OnTap != null ? widget.OnTap!() : null;
              },
              onFieldSubmitted: widget.OnSubmitted,
            ),
          ),
          if (widget.useAsBarcodeControle ?? false)
            IconButton(
                onPressed: () async {
                  await FlutterBarcodeScanner.scanBarcode("#ff6666", 'Cancel', false, ScanMode.BARCODE).then((val) {
                    // print('***************************   ${val}   ****************');
                    widget.Controller!.text = val;
                    widget.OnChanged != null ? widget.OnChanged!(val) : null;
                    return val;
                  });
                },
                icon: const Icon(Icons.qr_code)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ctr_TextFormField extends StatelessWidget {
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
  double? height;
  late bool? autoSelectData;
  late bool? readOnly;
  late bool? useAsBarcodeControle;
  late int? maxLines;
  late int? minLines;

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
    this.height,
    this.autoSelectData,
    this.readOnly,
    this.useAsBarcodeControle,
    this.maxLines,
    this.minLines,
    this.OnValidate,
    this.OnChanged,
    this.OnSubmitted,
    this.OnTap,
  }) : super(key: Key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5),
      height: height ?? 45,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: Controller,
              enabled: Isenabled,
              keyboardType: TextType,
              textDirection: TextDirection.ltr,
              textAlign: TextAlignValue ?? TextAlign.center,
              style: textStyle ?? const TextStyle(fontSize: 17, color: Colors.black),
              obscureText: IsobscureText,
              readOnly: readOnly ?? false,
              maxLines: maxLines,
          minLines: minLines,
              decoration: InputDecoration(
                label: Text(Lable),
                labelStyle: labelStyle ?? const TextStyle(fontSize: 17, color: Colors.grey),
                prefixIcon: PrefixIcon,
                suffixIcon: SufixIcon,
                fillColor: Colors.white,
                filled: true,
                suffix: sufix,
                border: border,
                contentPadding: EdgeInsets.symmetric(vertical: 0.3  ,horizontal: 2), // حشوة داخلية ثابتة
              ),
              validator: OnValidate,
              onChanged: OnChanged,
              onTap: () {
                // if(autoSelectData == true )  {
                //   Controller!.selection = TextSelection(baseOffset: 0, extentOffset: Controller!.text.length);
                // }
                OnTap != null ? OnTap!() : null;
              },
              onFieldSubmitted: OnSubmitted,
            ),
          ),
          if (useAsBarcodeControle ?? false)
            IconButton(
                onPressed: () async {
                  await FlutterBarcodeScanner.scanBarcode("#ff6666", 'Cancel', false, ScanMode.BARCODE).then((val) {
                    // print('***************************   ${val}   ****************');
                    Controller!.text = val;
                    OnChanged != null ? OnChanged!(val) : null;
                    return val;
                  });
                },
                icon: const Icon(Icons.qr_code)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../shared/sharedFunctions.dart';

class ctr_Date extends StatelessWidget {
  // DateTime selectedDate = DateTime.now();
  late BuildContext currenrContext;
  late bool isEnabled;
  late bool isReadOnly;
  late TextEditingController? dtController = TextEditingController();
  late String text;
  late TextStyle? textStyle;
  late TextAlign? TextAlignValue;
  late TextStyle? labelStyle;
  late bool isOpenSelectorOnTap;
  late bool isVisibleSearchIcon;
  late Icon? prefixIcon;
  // double? height;
  // late DateTime? defaultValue;
  late EdgeInsets? padding;
  late String? Function(String?)? OnValidate;
  late String? Function(String?)? OnChanged;
  late String? Function(String?)? OnSubmitted;

  // late String? Function()? OnTap;

  ctr_Date({
    Key? Key,
    this.dtController,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.text = '',
    this.textStyle,
    this.TextAlignValue,
    this.labelStyle,
    this.isOpenSelectorOnTap = false,
    this.isVisibleSearchIcon = false,
    this.prefixIcon,
    // this.defaultValue,
    this.padding = const EdgeInsets.all(0),
    // this.height,
    this.OnValidate,
    this.OnChanged,
    this.OnSubmitted,
    // this.OnTap,
  }) : super(key: Key);

  @override
  Widget build(BuildContext context) {
    currenrContext = context;

    // if (dtController != null && dtController!.text.isNotEmpty && defaultValue != null) {
    //   dtController!.text = sharedFunctions_Dates.convertToShortDateString(defaultValue);
    // } else
    //   sharedFunctions_Dates.convertToShortDateString(DateTime.now());

    return Container(
      padding: padding ?? EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5),
      // padding: EdgeInsets.symmetric(vertical: 0.3),
      // height: height ?? 45,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: dtController,
              enabled: isEnabled,
              keyboardType: TextInputType.datetime,
              textDirection: TextDirection.ltr,
              textAlign: TextAlignValue ?? TextAlign.center,
              readOnly: isReadOnly,
              style: textStyle ?? const TextStyle(fontSize: 17, color: Colors.black),
              decoration: InputDecoration(
                label: Text(text),
                labelStyle: labelStyle ?? const TextStyle(fontSize: 17, color: Colors.grey),
                prefixIcon: prefixIcon,
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0.3), // حشوة داخلية ثابتة
                suffixIcon: SizedBox(
                  height: 15,
                  child: IconButton(
                    onPressed: () {},
                    icon: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        dtController!.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
                border: const OutlineInputBorder(),
              ),
              validator: OnValidate,
              onChanged: OnChanged,
              onTap: isOpenSelectorOnTap ? openDatePicker : null,
              onFieldSubmitted: OnSubmitted,
            ),
          ),
          if (isVisibleSearchIcon)
            IconButton(
              onPressed: () {},
              icon: IconButton(
                padding: EdgeInsets.zero,
                onPressed: openDatePicker,
                icon: const Icon(Icons.search),
              ),
            ),
        ],
      ),
    );
  }

  void openDatePicker() async {
    DateTime currentDate = DateTime.now();

    // if (dtController != null && dtController!.text.isNotEmpty) {
    //   currentDate = sharedFunctions_Dates.convertDateStringToDatetime(dtController?.text)!;
    // }

    await showDatePicker(
      context: currenrContext,
      firstDate: DateTime(DateTime.now().subtract(const Duration(days: 36500)).year),
      lastDate: DateTime(DateTime.now().add(const Duration(days: 3650)).year),
      currentDate: DateTime(currentDate.year, currentDate.month, currentDate.day),
      keyboardType: TextInputType.datetime,
      cancelText: 'إلغاء',
      confirmText: 'إختيار',
    ).then((val) {
      if (val != null) {
        dtController!.text = sharedFunctions_Dates.convertToShortDateString(val);
        OnChanged != null ? OnChanged!(dtController!.text) : null;
        print(dtController!.text);
      }
    });
  }
}

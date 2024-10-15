import 'package:flutter/material.dart';

class ctr_DropDowenMap extends StatefulWidget {
  @override
  _ctr_DropDowenMapState createState() => _ctr_DropDowenMapState();

  Map<String, int>? selectedKey;
  String? selectedValue;
  String hintLable;
  List<String> lstDataString;
  List<Map<String, int>?> lstDataMap;
  TextStyle? itemsTextStyle;
  TextStyle? hintTextStyle;
  EdgeInsets? padding;
  double? menuMaxHeightValue;
  BorderRadius? borderRadius;

  // late int? Function(String? returnKey  , String? returnValue)? OnChanged;
  late int? Function(Map<String, int>? returnItemMap)? OnChanged;
  late int? Function(Map<String, int>? returnItemMap)? OnSaved;

  ctr_DropDowenMap({
      this.selectedKey,
    this.hintLable = '',
    this.lstDataString = const [],
    this.lstDataMap = const [],
    this.itemsTextStyle,
    this.hintTextStyle,
    this.padding,
    this.menuMaxHeightValue,
    this.borderRadius,
    this.OnChanged,
    this.OnSaved,
  });
}

class _ctr_DropDowenMapState extends State<ctr_DropDowenMap> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding:  EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5),
            height: 45,
            child: DropdownButtonFormField<Map<String, int>>(
              value: widget.selectedKey,
              hint: Text(
                widget.hintLable,
                style: widget.hintTextStyle ?? const TextStyle(fontSize: 15.0, color: Colors.grey),
              ),


              items: widget.lstDataMap.expand((element) {
                if (element != null) {
                  return element.entries.map((entry) {
                    return DropdownMenuItem<Map<String, int>>(
                      value: {entry.key: entry.value}, // استخدام الزوج كمفتاح وقيمة
                      child: Text(
                        '${entry.key} : ${entry.value}',
                        style: widget.itemsTextStyle ?? const TextStyle(fontSize: 11.0, color: Colors.grey),
                      ),
                    );
                  }).toList();
                }
                return <DropdownMenuItem<Map<String, int>>>[]; // Empty list for null elements
              }).toList(),

              onTap: ()
              {
                 widget.selectedKey = {'medo': 13};
              } ,
              onChanged: (Map<String, int>? newItem) {
                  widget.selectedKey = newItem;
                  if (widget.OnChanged != null) {
                    widget.OnChanged!(widget.selectedKey);
                  }
              },
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
              borderRadius: widget.borderRadius,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            widget.selectedKey = null; // إلغاء الاختيار
              if (widget.OnChanged != null) {
                widget.OnChanged!(null);
              }
          },
          icon: const Icon(Icons.clear),
          color: Colors.black,
        ),
      ],
    );
  }
}

// class _ctr_DropDowenState extends State<ctr_DropDowen> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: widget.padding ?? const EdgeInsets.all(0),
//             child: DropdownButtonFormField<String>(
//               value: widget.selectedValue,
//               hint: Text(
//                 widget.hintLable,
//                 style: widget.hintTextStyle ?? const TextStyle(fontSize: 15.0, color: Colors.grey),
//               ),
//               items: widget.lstDataString.map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(
//                     value,
//                     style: widget.itemsTextStyle ?? const TextStyle(fontSize: 11.0, color: Colors.grey),
//                   ),
//                 );
//               }).toList(),
//               onChanged: (String? val) {
//                 setState(() {
//                   widget.selectedValue = val;
//                   // print('selectedValue : ${widget.selectedValue}');
//                   if (widget.OnChanged != null) {
//                     widget.OnChanged!(widget.selectedValue);
//                   }
//                 });
//               },
//               icon: const Icon(
//                 Icons.keyboard_arrow_down_rounded,
//                 color: Colors.black,
//               ),
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: const BorderSide(
//                     color: Colors.grey,
//                     width: 2.0,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: const BorderSide(
//                     color: Colors.grey,
//                     width: 2.0,
//                   ),
//                 ),
//               ),
//               dropdownColor: Colors.white,
//               elevation: 2,
//               menuMaxHeight: widget.menuMaxHeightValue ?? 250,
//               borderRadius: widget.borderRadius ,
//
//             ),
//           ),
//         ),
//         IconButton(
//           onPressed: () {
//             setState(() {
//               // print('selectedValue --------- ${widget.selectedValue}');
//               widget.selectedValue = null;
//             });
//           },
//           icon: const Icon(Icons.clear),
//           color: Colors.black,
//         ),
//       ],
//     );
//   }
// }

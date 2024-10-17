import 'package:flutter/material.dart';

import '../shared/shared_controls.dart';

class ctr_ContactsNumber extends StatelessWidget {
  final GlobalKey _iconKey = GlobalKey();


  late TextAlign? TextAlignValue;
  // late Widget? SufixIcon;
  late Widget? sufix;
  late bool Isenabled = true;
  late InputBorder border = OutlineInputBorder();
  late TextEditingController? Controller;
  late TextStyle? textStyle;
  late String Lable;
  late TextStyle? labelStyle;
  late Icon? PrefixIcon;
  late EdgeInsets? padding;
  late bool? autoSelectData;
  late bool? readOnly;

  late String? Function(String?)? OnValidate;
  late String? Function(String?)? OnChanged;
  late String? Function(String?)? OnSubmitted;
  late String? Function()? OnTap;

  ctr_ContactsNumber({
    Key? Key,
    this.TextAlignValue,
    // this.SufixIcon,
    this.sufix,
    this.Controller,
    this.Isenabled = true,
    this.border = const OutlineInputBorder(),
    this.textStyle,
    this.Lable = '',
    this.labelStyle,
    this.PrefixIcon,
    this.padding = const EdgeInsets.all(0),
    this.autoSelectData,
    this.readOnly,
    this.OnValidate,
    this.OnChanged,
    this.OnSubmitted,
    this.OnTap,
  }) : super(key: Key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5),
      // height: 50,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: Controller,
              enabled: Isenabled,
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
              textAlign: TextAlignValue ?? TextAlign.center,
              style: textStyle ?? const TextStyle(fontSize: 17, color: Colors.black),
              readOnly: readOnly ?? false,
              decoration: InputDecoration(
                label: Text(Lable),
                labelStyle: labelStyle ?? const TextStyle(fontSize: 17, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(vertical: 0.3  ,horizontal: 2), // حشوة داخلية ثابتة
                prefixIcon: PrefixIcon,
                suffixIcon: IconButton(
                    key: _iconKey,
                    onPressed: () {
                      openMenuOption(context);

  },
                    icon: const Icon(Icons.call)),
                fillColor: Colors.white,
                filled: true,
                suffix: sufix,
                border: border,
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
        ],
      ),
    );
  }

  Widget showOptions() {
    List<String> lstDataString = ['Call إتصال', 'SMS رسالة نصية', 'WhatsApp واتس آب', 'Telegram تليجرام', '', '', ''];
    String? selectedValue;

    return SizedBox(
      width: 50,
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        // hint: Text(
        //   'خيارات الموبيل',
        //   style: const TextStyle(fontSize: 15.0, color: Colors.grey),
        // ),
        items: lstDataString.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 11.0, color: Colors.grey),
            ),
          );
        }).toList(),
        onChanged: (String? val) {
          print(selectedValue);
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
        menuMaxHeight: 250,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  openMenuOption(context , ) {
    final RenderBox renderBox = _iconKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero); // الحصول على إحداثيات الزر

    showMenu(
      color: Colors.white,
      context: context,
      // position: RelativeRect.fromLTRB(globalPosition.dx, globalPosition.dy, globalPosition.dx, globalPosition.dy),
      position: RelativeRect.fromLTRB(
        position.dx, // الموقع الأفقي
        position.dy + renderBox.size.height, // الموقع الرأسي أسفل الزر
        position.dx + renderBox.size.width, // الحجم الأفقي
        position.dy, // الحجم الرأسي
      ),
      items: [
        // PopupMenuItem(
        //   child: Center(
        //     child: Column(
        //       children: [
        //         Text('الخيارات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        //         Divider(
        //           color: Colors.grey,
        //           thickness: 1,
        //           height: 0,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.call, color: Colors.blue),
              Text('Call إتصال', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          ),
          onTap: () async {
            sharedControls.phoneNumber_Call(Controller != null ? Controller!.text.trim() : '');
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.sms, color: Colors.blue),
              Text('SMS رسالة نصية', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          ),
          onTap: () {
            sharedControls.phoneNumber_SMS(Controller != null ? Controller!.text.trim() : '' , 'مرحبا ..');
          },
        ),

        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.chat, color: Colors.blue),
              Text('  WhatsApp واتس آب', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          ),
          onTap: () {
            sharedControls.phoneNumber_WhatsApp(Controller != null ? Controller!.text.trim() : '' , 'Hellow..');
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.telegram, color: Colors.blue ),
              Text('  Telegram تليجرام', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          ),
          onTap: () {
            sharedControls.phoneNumber_Telegram(Controller != null ? Controller!.text.trim() : '' , 'Hellow..');
          },
        ),

      ],

    );
  }


}


// ctr_AlertDialog.showListFilter(
//   context,
//   backgroundColor: Colors.white,
//   content: SizedBox(
//     height: 200,
//     child: SingleChildScrollView(
//       child: Column(
//         children: [
//           ListView(
//             children: [
//               Text('الخيارات' , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),),
//               SizedBox(height: 10),                                  SizedBox(
//                 width : 250,
//                 child: ElevatedButton.icon(
//                   onPressed: () async {
//                     sharedControls.phoneNumber_Call(Controller != null ? Controller!.text.trim() : '');
//                   },
//                   label: const Text(
//                     'Call إتصال',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17,
//                       color: Colors.black,
//                     ),
//                   ),
//                   icon: const Icon(Icons.call),
//                   iconAlignment: IconAlignment.end,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     elevation: 3,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width : 250,
//                 child: ElevatedButton.icon(
//                   onPressed: () async {
//                     sharedControls.phoneNumber_SMS(Controller != null ? Controller!.text.trim() : '' , 'مرحبا ..');
//                   },
//                   label: const Text(
//                     'SMS رسالة نصية',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17,
//                       color: Colors.black,
//                     ),
//                   ),
//                   icon: const Icon(Icons.sms),
//                   iconAlignment: IconAlignment.end,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     elevation: 3,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width : 250,
//                 child: ElevatedButton.icon(
//                   onPressed: () async {
//                     sharedControls.phoneNumber_WhatsApp(Controller != null ? Controller!.text.trim() : '' , 'Hellow..');
//                   },
//                   label: const Text(
//                     'WhatsApp واتس آب',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17,
//                       color: Colors.black,
//                     ),
//                   ),
//                   icon: const Icon(Icons.chat),
//                   iconAlignment: IconAlignment.end,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     elevation: 3,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width : 250,
//                 child: ElevatedButton.icon(
//                   onPressed: () async {
//                     sharedControls.phoneNumber_Telegram(Controller != null ? Controller!.text.trim() : '', 'Hellow..');
//                   },
//                   label: const Text(
//                     'Telegram تليجرام',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17,
//                       color: Colors.black,
//                     ),
//                   ),
//                   icon: const Icon(Icons.telegram),
//                   iconAlignment: IconAlignment.end,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     elevation: 3,
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ],
//       ),
//     ),
//   ),
// );
import 'package:flutter/material.dart';

class ctr_Dialog {
  static void showListFilter(
    BuildContext context, {
    String? Header,
    ShapeBorder? shape,
    Color? backgroundColor,
    double? elevation,
    TextEditingController? controller,
    Widget? content,
  }) {


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ), // يمكنك تخصيص شكل الـ Dialog هنا
          child: IntrinsicHeight( // هنا يتم استخدام IntrinsicHeight لضبط الحجم على المحتويات
            child: Column(
              mainAxisSize: MainAxisSize.min, // هذا السطر يسمح للـ Dialog أن يأخذ حجم المحتويات فقط
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'هل تريد تأكيد حذف سمنود؟',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton.icon(
                      icon: Icon(Icons.delete),
                      label: Text('حذف'),
                      onPressed: () {
                        // action for delete
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.cancel),
                      label: Text('إلغاء'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );




  }
}

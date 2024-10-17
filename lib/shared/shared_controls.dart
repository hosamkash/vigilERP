import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:vigil_erp/shared/sharedDesigne.dart';

import '../bll/bllFirebase/ManageBLL.dart';
import '../blocManagment/blocDefinition/definition_bloc.dart';
import '../blocManagment/blocInventory/inv_bloc.dart';
import '../blocManagment/tablesCondions.dart';
import '../componants/ctr_AlertDialog.dart';
import '../componants/ctr_Date.dart';
import '../componants/ctr_DropDowenList.dart';
import '../componants/ctr_TextHeaderPage.dart';
import '../screens/definitions/category/scr_categoryView.dart';
import '../screens/definitions/products/scr_ProductView.dart';
import '../screens/settings/scr_SettingDefaulsValue.dart';

class sharedControls {
  static Future<bool?> toastNotification(String message, bool isSuccssed,
      {int secondShow = 2, ToastGravity toastType = ToastGravity.SNACKBAR}) async {
    return await Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: toastType,
        timeInSecForIosWeb: secondShow,
        backgroundColor: isSuccssed ? Colors.green : Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Widget circularProgressLoad() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        color: sharedDesigne.primaryColor,
      ),
    );
  }

  static Widget linearProgressLoad() {
    return const LinearProgressIndicator(
      color: sharedDesigne.primaryColor,
      value: 6,
    );
  }

  static void navigatTo(context, Widget NewWidget) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return NewWidget;
        },
      ),
    );
  }

  static void navigatToAndFinish(context, Widget GotoNewWidget) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => GotoNewWidget), (route) => false);
  }

  static Future<void> confirmDelete(context, String textHeader, VoidCallback OnDeleted) {
    return showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          actions: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: ctr_TextHeaderPage(
                    padding: EdgeInsets.only(top: 10, bottom: 0),
                    text: 'هل تريد تأكيد حذف \n',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(textHeader, style: TextStyle(fontSize: 20, color: Colors.red)),
                SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton.icon(
                      label: const Text('حذف', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      icon: const Icon(Icons.delete_forever),
                      iconAlignment: IconAlignment.end,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
                      onPressed: () {
                        OnDeleted();
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      label: const Text('الغاء', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      icon: const Icon(Icons.cancel),
                      iconAlignment: IconAlignment.end,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static Future<void> confirmDialog(context,String textAddress,  String textHeader, VoidCallback OnDeleted,
  {TextStyle? style,String? textButtonOk,String? textButtonCancle,  }) {

    return showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          actions: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: ctr_TextHeaderPage(
                    padding: EdgeInsets.only(top: 10, bottom: 0),
                    text: textAddress,
                    style: style ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(textHeader, style: TextStyle(fontSize: 20, color: Colors.red)),
                SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton.icon(
                      label: Text(textButtonOk ?? 'تأكيد', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      icon: const Icon(Icons.delete_forever),
                      iconAlignment: IconAlignment.end,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
                      onPressed: () {
                        OnDeleted();
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      label:  Text(textButtonCancle ?? 'الغاء', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      icon: const Icon(Icons.cancel),
                      iconAlignment: IconAlignment.end,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static Widget buildMainMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('الإعدادات'),
              onTap: () {
                sharedControls.navigatTo(context, scr_SettingDefaulsValue(true));
              },
            ),

            ExpansionTile(
              title: ListTile(
                leading: Icon(Icons.home),
                title: Text('التعريفات'),
                onTap: () {},
              ),
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('الأصناف'),
                  onTap: () {
                    sharedControls.navigatTo(context, scr_ProductView());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('التصنيفات'),
                  onTap: () {
                    sharedControls.navigatTo(context, scr_categoryView());
                  },
                ),
                // ListTile(
                //   leading: const Icon(Icons.home),
                //   title: const Text('SingleChildScrollView'),
                //   onTap: () {
                //     sharedControls.navigatTo(context, Scrollablexx());
                //   },
                // ),
              ],
            ),

            // ExpansionTile(
            //   title: ListTile(
            //     leading: Icon(Icons.home),
            //     title: Text('المندوبين'),
            //     onTap: () {},
            //   ),
            //   children: [
            //     ListTile(
            //       leading: Icon(Icons.home),
            //       title: Text('فواتير المندوبين'),
            //       onTap: () {},
            //     ),
            //     ListTile(
            //       leading: Icon(Icons.home),
            //       title: Text('طلبات المندوبين'),
            //       onTap: () {},
            //     ),
            //     ListTile(
            //       leading: Icon(Icons.home),
            //       title: Text('إضافة سريعة'),
            //       onTap: () {},
            //     ),
            //     ListTile(
            //       leading: Icon(Icons.home),
            //       title: Text('جرد وإستلام من المندوب'),
            //       onTap: () {},
            //     ),
            //   ],
            // ),
            // ExpansionTile(
            //   title: ListTile(
            //     leading: Icon(Icons.home),
            //     title: Text('الماليات'),
            //     onTap: () {},
            //   ),
            //   children: [
            //     ListTile(
            //       leading: Icon(Icons.home),
            //       title: Text('سندات الدفع'),
            //       onTap: () {},
            //     ),
            //     ListTile(
            //       leading: Icon(Icons.home),
            //       title: Text('سندات القبض'),
            //       onTap: () {},
            //     ),
            //     ListTile(
            //       leading: Icon(Icons.home),
            //       title: Text('حركة الخزينة'),
            //       onTap: () {},
            //     ),
            //   ],
            // ),
            //
            // ListTile(
            //   leading: Icon(Icons.home),
            //   title: Text('تايمر وقت وتاريخ'),
            //   onTap: () {
            //     sharedControls.navigatTo(context, ClockWidget());
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.home),
            //   title: Text('بصمة الوجه'),
            //   onTap: () {
            //     sharedControls.navigatTo(context, FaceRecognitionAuth());
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.home),
            //   title: Text('تجربة البلوك مع الشركة'),
            //   onTap: () {
            //     sharedControls.navigatTo(context, scr_CompanyViewNew());
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  static Future showFormFilterByDates(BuildContext context, en_TablesName tableName, int? branchID, TextEditingController contDateFrom,
      TextEditingController contDateTo, bool isGetAllDates) async {
    bool isEnableDates = !isGetAllDates;
    var frmKey = GlobalKey<FormState>();

    var xx = await ctr_AlertDialog.showListFilter(
      context,
      content: StatefulBuilder(
        builder: (context, setState) {
          return Form(
            key: frmKey,
            child: Column(
              mainAxisSize: MainAxisSize.min, // يجعل الارتفاع يتناسب مع المحتويات
              children: [
                Text(
                  'البحث بالفرع والتاريخ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ctr_DropDowenList(
                  hintLable: 'الفرع',
                  padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                  lstDataSource: company_bloc.instance.LstBranchesAsDataSource,
                  hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                  itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                  menuMaxHeightValue: 300,
                  showClearIcon: true,
                  selectedValue: branchID,
                  OnChanged: (returnID) {
                    branchID = returnID;
                    return null;
                  },
                  OnValidate: (value) {
                    if (value == null) {
                      return 'لابد من إختيار قيمة';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Checkbox(
                        value: isGetAllDates,
                        onChanged: (value) {
                          setState(() {
                            isGetAllDates = !isGetAllDates;

                            if (isGetAllDates) {
                              isEnableDates = false;
                              contDateFrom.text = '';
                              contDateTo.text = '';
                            } else
                              isEnableDates = true;
                          });
                        }),
                    const Text(
                      'كل التواريخ',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                ctr_Date(
                  text: 'من تاريخ',
                  dtController: contDateFrom,
                  padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 10),
                  isReadOnly: true,
                  isOpenSelectorOnTap: isEnableDates,
                  // defaultValue: contDateFrom.text,
                  // OnChanged: (val) {
                  //   return val;
                  // },
                  // OnValidate: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'لابد من إختيار قيمة';
                  //   }
                  //   return null;
                  // },
                ),
                ctr_Date(
                  text: 'إلى تاريخ',
                  dtController: contDateTo,
                  padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 10),
                  isReadOnly: true,
                  isOpenSelectorOnTap: isEnableDates,
                  // OnChanged: (val) {
                  //   return val;
                  // },
                  // OnValidate: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'لابد من إختيار قيمة';
                  //   }
                  //   return null;
                  // },
                ),
                Center(
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () async {
                          var cond = await tablesCondions.createCondionsByDates(tableName, branchID, contDateFrom, contDateTo, isGetAllDates);
                          if (tableName == en_TablesName.Inv_PermissionAdd)
                            permissionAdd_bloc.instance.add(getListPermissionAdd_Event(condions: cond));
                         else if (tableName == en_TablesName.Inv_PermissionDiscount)
                            permissionDiscount_bloc.instance.add(getListPermissionDiscount_Event(condions: cond));
                          else if (tableName == en_TablesName.Inv_Settlement)
                            settlement_bloc.instance.add(getListSettlement_Event(condions: cond));
                          List<dynamic> dates = [isGetAllDates, contDateFrom.text, contDateTo.text, branchID];
                          Navigator.pop(context, dates);
                        },
                        child: Text('تأكيد', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('إلغاء', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    if (xx != null) {
      return xx;
    }
  }

  //***********************************************************************

  static void phoneNumber_Call(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static void phoneNumber_SMS(String phoneNumber, String messege) async {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: <String, String>{
        'body': messege,
        // 'body': Uri.encodeComponent('Example Subject & Symbols are allowed!'),
      },
    );
    await launchUrl(smsLaunchUri);
  }

  static void phoneNumber_WhatsApp(String phoneNumber, String message) async {
    final Uri whatsappUri = Uri.parse('https://wa.me/2$phoneNumber&text=${message})');

    // التحقق مما إذا كان يمكن فتح الرابط
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      throw 'Could not launch $whatsappUri';
    }
  }

  static void phoneNumber_Telegram(String phoneNumber, String message) async {
    // final Uri telegramUri = Uri.parse('https://t.me/+${phoneNumber}?text=${Uri.encodeComponent(message)}');
    //
    // // التحقق مما إذا كان يمكن فتح الرابط
    // if (await canLaunch(telegramUri.toString())) {
    //   await launch(telegramUri.toString());
    // } else {
    //   throw 'Could not launch $telegramUri';
    // }
  }

  static void sendEmail(String number) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'smith@example.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Example Subject & Symbols are allowed!',
      }),
    );
    launchUrl(emailLaunchUri);
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }

  static void openFacebookPage() async {
    // https://www.facebook.com/100067572786844       vigiljeans page
    // groupId https://www.facebook.com/groups/810385623368699/      Maka group
    const facebookUrl = 'fb://page/100067572786844';
    const fallbackUrl = 'https://www.facebook.com/100067572786844';

    try {
      bool launched = await launchUrl(Uri.parse(facebookUrl));
      if (!launched) {
        await launchUrl(Uri.parse(fallbackUrl));
      }
    } catch (e) {
      await launchUrl(Uri.parse(fallbackUrl));
    }
  }

  static void openFacebookGroup() async {
    const groupId = '810385623368699';
    final facebookGroupUrl = 'fb://group/$groupId';
    final fallbackGroupUrl = 'https://www.facebook.com/groups/$groupId';

    try {
      bool launched = await launchUrl(Uri.parse(facebookGroupUrl));
      if (!launched) {
        await launchUrl(Uri.parse(fallbackGroupUrl));
      }
    } catch (e) {
      await launchUrl(Uri.parse(fallbackGroupUrl));
    }
  }

  static void openRDClient() async {
    final Uri rdClientUri = Uri.parse('rdp://'); // Replace with the correct URL scheme

    if (await canLaunchUrl(rdClientUri)) {
      await launchUrl(rdClientUri);
    } else {
      throw 'Could not launch $rdClientUri';
    }
  }

  static void openAnyApp(String appName) async {
    // URL scheme for iOS/Android
    final Uri urlSchemeUri = Uri.parse('your-app-scheme://');

    // Android package name (optional)
    final Uri androidPackageUri = Uri.parse('intent://#Intent;package=com.example.yourapp;end');

    // First, try to open using URL scheme
    if (await canLaunchUrl(urlSchemeUri)) {
      await launchUrl(urlSchemeUri);
    }
    // If not available, try using package name (Android only)
    else if (await canLaunchUrl(androidPackageUri)) {
      await launchUrl(androidPackageUri);
    } else {
      throw 'Could not launch app';
    }
  }
}

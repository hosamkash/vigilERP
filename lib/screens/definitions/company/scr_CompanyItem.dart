import 'package:flutter/material.dart';
import 'package:vigil_erp/componants/ctr_ContactsNumber.dart';
import 'package:vigil_erp/componants/ctr_Date.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/sharedFunctions.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/bllDef_CompanyStructure.dart';
import '../../../bll/classModel/Def_CompanyStructure.dart';

class scr_CompanyItem extends StatefulWidget {
  scr_CompanyItem(this.itemCompany, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Def_CompanyStructure? itemCompany;
  en_FormMode frmMode;

  @override
  State<scr_CompanyItem> createState() => _scr_CompanyItemState();
}

class _scr_CompanyItemState extends State<scr_CompanyItem> {
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDateCreat = TextEditingController();
  TextEditingController controllerAdress = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerMobile = TextEditingController();
  TextEditingController controllerLogo = TextEditingController();
  bool chkIsActive = false;
  bool chkIsOwner = false;
  TextEditingController controllerDefaultStock = TextEditingController();
  TextEditingController controllerDefaultTreasure = TextEditingController();
  TextEditingController controllerDefaultEmployee = TextEditingController();
  var frmKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: buildCustomBar(),
        titleSpacing: 20,
        actions: [
          // const SizedBox(width: 50),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_forward)),
        ],
      ),
      drawer: sharedControls.buildMainMenu(context),
      body: Container(
        color: Colors.white,
        child: buildPageContent(),
      ),
    );
  }

  Widget buildPageContent() {
    return SingleChildScrollView(
      child: Form(
        key: frmKey,
        child: Column(
          children: [
            ctr_TextHeaderPage(
              text: 'بيانات الفرع',
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            // const SizedBox(height: 5),
            Row(
              children: [
                Checkbox(
                    value: chkIsActive,
                    onChanged: (value) {
                      setState(() {
                        chkIsActive = !chkIsActive;
                      });
                    }),
                const Text('نشط', style: TextStyle(fontSize: 17)),
                const SizedBox(width: 50),
                Checkbox(
                    value: chkIsOwner,
                    onChanged: (value) {
                      setState(() {
                        chkIsOwner = !chkIsOwner;
                      });
                    }),
                const Text('رئيسي', style: TextStyle(fontSize: 17)),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 110,
                  child: ctr_TextFormField(
                    padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                    Controller: controllerCode,
                    Lable: 'كود',
                    TextType: TextInputType.number,
                    OnValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'لابد من إدخال قيمة';
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_Date(
                    text: 'تاريخ',
                    padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                    dtController: controllerDateCreat,
                    isOpenSelectorOnTap: true,
                    OnValidate: (value) {
                      if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            ctr_TextFormField(
              Controller: controllerName,
              padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
              TextType: TextInputType.text,
              TextAlignValue: TextAlign.end,
              Lable: 'الإســـم',
              OnValidate: (value) {
                if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
                return null;
              },
            ),
            ctr_TextFormField(
              Controller: controllerAdress,
              padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
              TextType: TextInputType.text,
              TextAlignValue: TextAlign.end,
              Lable: 'العنوان',
              // OnValidate: (value) {
              //   if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
              // },
            ),
            // const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_ContactsNumber(
                    Controller: controllerMobile,
                    padding: EdgeInsets.only(right: 2, left: 5, top: 0, bottom: 0),
                    Lable: 'الموبيل',
                  ),
                ),
                Expanded(
                  child: ctr_ContactsNumber(
                    Controller: controllerPhone,
                    padding: EdgeInsets.only(right: 2, left: 5, top: 0, bottom: 0),
                    Lable: 'الهاتف',
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.grey, height: 20, indent: 20, endIndent: 20, thickness: 3),
            ctr_TextHeaderPage(
              text: 'الإعدادات الإفتراضية',
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            const SizedBox(height: 5),
            ctr_TextFormField(
              Controller: controllerDefaultStock,
              padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
              TextType: TextInputType.text,
              TextAlignValue: TextAlign.end,
              Lable: 'المخزن الإفتراضي',
              OnChanged: (value) {
                return null;
              },
            ),
            ctr_TextFormField(
              Controller: controllerDefaultTreasure,
              padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
              TextType: TextInputType.text,
              TextAlignValue: TextAlign.end,
              Lable: 'الخزينة الإفتراضي',
              OnChanged: (value) {
                return null;
              },
            ),
            ctr_TextFormField(
              Controller: controllerDefaultEmployee,
              padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
              TextType: TextInputType.text,
              TextAlignValue: TextAlign.end,
              Lable: 'الموظف الإفتراضي',
              OnChanged: (value) {
                return null;
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.frmMode == en_FormMode.NewMode)
      NewMode();
    else if (widget.frmMode == en_FormMode.EditMode) EditMode();
  }

  Widget buildCustomBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            saveData();
          },
          icon: Icon(
            Icons.save,
            color: Colors.blue[900],
            size: 30,
          ),
          padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 0),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.cancel,
            color: Colors.red[700],
            size: 30,
          ),
          padding: EdgeInsets.only(right: 0, left: 5, top: 0, bottom: 0),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.print,
            color: Colors.purple,
            size: 30,
          ),
          padding: EdgeInsets.only(right: 0, left: 5, top: 0, bottom: 0),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.share,
            color: Colors.green,
            size: 30,
          ),
          padding: EdgeInsets.only(right: 0, left: 5, top: 0, bottom: 0),
        ),
      ],
    );
  }

  void NewMode() async {
    controllerDateCreat.text = await sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    chkIsActive = true;
    bllDef_CompanyStructure.getMaxID_firestore().then((val) {
      controllerCode.text = val.toString();
    }).toString();
  }

  void EditMode() {
    if (widget.itemCompany != null) {
      controllerCode.text = widget.itemCompany!.Code.toString();
      controllerDateCreat.text = widget.itemCompany!.DateCreate!;
      controllerName.text = widget.itemCompany!.Name!;
      controllerAdress.text = widget.itemCompany!.Adress!;
      controllerPhone.text = widget.itemCompany!.Phone!;
      controllerMobile.text = widget.itemCompany!.Mobile!;
      controllerLogo.text = widget.itemCompany!.Logo!;
      chkIsActive = widget.itemCompany!.isActive!;
      chkIsOwner = widget.itemCompany!.isOwner!;
      controllerDefaultStock.text = widget.itemCompany!.defaultStock!;
      controllerDefaultTreasure.text = widget.itemCompany!.defaultTreasure!;
      controllerDefaultEmployee.text = widget.itemCompany!.defaultEmployee!;
    }
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      int maxID = 0;

      if (widget.frmMode == en_FormMode.NewMode) {
        maxID = await bllDef_CompanyStructure.getMaxID_firestore();
        widget.itemCompany = Def_CompanyStructure(ID: maxID);
      } else if (widget.frmMode == en_FormMode.EditMode) {
        maxID = widget.itemCompany!.ID!;
      }
      widget.itemCompany!.Code = int.parse(controllerCode.text);
      widget.itemCompany!.DateCreate = controllerDateCreat.text;
      widget.itemCompany!.Name = controllerName.text;
      widget.itemCompany!.Adress = controllerAdress.text;
      widget.itemCompany!.Phone = controllerPhone.text;
      widget.itemCompany!.Mobile = controllerMobile.text;
      widget.itemCompany!.Logo = controllerLogo.text;
      widget.itemCompany!.isActive = chkIsActive;
      widget.itemCompany!.isOwner = chkIsOwner;
      widget.itemCompany!.defaultStock = controllerDefaultStock.text;
      widget.itemCompany!.defaultTreasure = controllerDefaultTreasure.text;
      widget.itemCompany!.defaultEmployee = controllerDefaultEmployee.text;
      await bllDef_CompanyStructure.fire_SetItem(maxID.toString(), widget.itemCompany!);
      Navigator.pop(context, true);
    }
  }
}

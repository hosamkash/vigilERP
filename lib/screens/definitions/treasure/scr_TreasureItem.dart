import 'package:flutter/material.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/bllDef_Treasures.dart';
import '../../../bll/classModel/Def_Treasures.dart';

class scr_TreasureItem extends StatefulWidget {
  scr_TreasureItem(this.itemTreasure, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Def_Treasures? itemTreasure;
  en_FormMode frmMode;

  @override
  State<scr_TreasureItem> createState() => _scr_TreasureItemState();
}

class _scr_TreasureItemState extends State<scr_TreasureItem> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerBalance = TextEditingController();
  bool chkIsActive = false;
  bool chkIsBindBranch = false;
  int? branchID;

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
          // const SizedBox(width: 210),
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
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              ctr_TextHeaderPage(
                text: 'بيانات خزينة النقدية',
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: ctr_TextFormField(
                      Controller: controllerCode,
                      Lable: 'كود',
                      TextType: TextInputType.number,
                      padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                      OnValidate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'لابد من إدخال قيمة';
                        }
                        return null;
                      },
                    ),
                  ),
                  Checkbox(
                      value: chkIsActive,
                      onChanged: (value) {
                        setState(() {
                          chkIsActive = !chkIsActive;
                        });
                      }),
                  const Text('نشط', style: TextStyle(fontSize: 17)),
                ],
              ),
              ctr_TextFormField(
                Controller: controllerName,
                padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                TextType: TextInputType.text,
                TextAlignValue: TextAlign.end,
                Lable: 'الإســــم',
                OnValidate: (value) {
                  if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
                  return null;
                },
              ),
              Row(
                children: [
                  Checkbox(
                      value: chkIsBindBranch,
                      onChanged: (value) {
                        setState(() {
                          chkIsBindBranch = !chkIsBindBranch;
                        });
                      }),
                  const Text('مرتبط بفرع', style: TextStyle(fontSize: 17)),
                ],
              ),
              ctr_DropDowenList(
                hintLable: 'الفرع التابع له',
                padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                lstDataSource: company_bloc.instance.LstBranchesAsDataSource,
                hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                menuMaxHeightValue: 300,
                selectedValue: branchID,
                OnChanged: (returnID) {
                  branchID = returnID;
                  print(branchID);
                  return branchID;
                },
                OnValidate: (value) {
                  if (value == null) {
                    return 'لابد من إختيار الفرع';
                  }
                  return null;
                },
              ),

              ctr_TextFormField(
                Controller: controllerBalance,
                padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                TextType: TextInputType.number,
                TextAlignValue: TextAlign.end,
                Lable: 'الرصيد الحالى',
                OnValidate: (value) {
                  if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
                  return null;
                },
              ),
            ],
          ),
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
    chkIsActive = true ;
    bllDef_Treasures.getMaxID_firestore().then((val) {
      controllerCode.text = val.toString();
      controllerBalance.text = 0.toString();
    }).toString();
  }

  void EditMode() {
    if (widget.itemTreasure != null) {
      controllerCode.text = widget.itemTreasure!.Code.toString();
      controllerName.text = widget.itemTreasure!.Name!;
      chkIsActive = widget.itemTreasure!.IsActive!;
      chkIsBindBranch = widget.itemTreasure!.IsBindBranch!;
      branchID = widget.itemTreasure!.IDBranch;
      controllerBalance.text = widget.itemTreasure!.Balance.toString();
    }
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      int maxID = 0;

      //************************** New
      if (widget.frmMode == en_FormMode.NewMode) {
        maxID = await bllDef_Treasures.getMaxID_firestore();
        widget.itemTreasure = Def_Treasures(
          ID: maxID,
          Code: int.parse(controllerCode.text),
          Name: controllerName.text,
          IsActive: chkIsActive,
          IsBindBranch: chkIsBindBranch,
          IDBranch: branchID,
          Balance: double.parse(controllerBalance.text),
        );
        await bllDef_Treasures.fire_SetItem(maxID.toString(), widget.itemTreasure!);
      }

      //************************** Edit
      else if (widget.frmMode == en_FormMode.EditMode) {
        maxID = widget.itemTreasure!.ID!;
        widget.itemTreasure!.Code = int.parse(controllerCode.text);
        widget.itemTreasure!.Name = controllerName.text;
        widget.itemTreasure!.IsActive = chkIsActive;
        widget.itemTreasure!.IsBindBranch = chkIsBindBranch;
        widget.itemTreasure!.IDBranch = branchID;
        widget.itemTreasure!.Balance = double.parse(controllerBalance.text);
      }

      await bllDef_Treasures.fire_SetItem(maxID.toString(), widget.itemTreasure!);
      Navigator.pop(context, true);
    }
  }
}

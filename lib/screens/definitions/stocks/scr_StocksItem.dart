import 'package:flutter/material.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/bllDef_Stocks.dart';
import '../../../bll/classModel/Def_Stocks.dart';

class scr_StocksItem extends StatefulWidget {
  scr_StocksItem(this.itemStock, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Def_Stocks? itemStock;
  final en_FormMode frmMode;

  @override
  State<scr_StocksItem> createState() => _scr_StocksItemState();
}

class _scr_StocksItemState extends State<scr_StocksItem> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCode = TextEditingController();
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
        child: Column(
          children: [
            ctr_TextHeaderPage(
              text: 'بيانات المخزن',
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
                    padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 0),
                    TextType: TextInputType.number,
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
              padding: EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 0),
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
              padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 0),
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
    chkIsActive = true ;
    bllDef_Stocks.getMaxID_firestore().then((val) {
      controllerCode.text = val.toString();
    }).toString();
  }

  void EditMode() {
    if (widget.itemStock != null) {
      controllerCode.text = widget.itemStock!.Code.toString();
      controllerName.text = widget.itemStock!.Name!;
      chkIsActive = widget.itemStock!.IsActive!;
      chkIsBindBranch = widget.itemStock!.IsBindBranch!;
      branchID = widget.itemStock!.IDBranch;
    }
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      int maxID = 0;

      //************************** New
      if (widget.frmMode == en_FormMode.NewMode) {
        maxID = await bllDef_Stocks.getMaxID_firestore();
        widget.itemStock = Def_Stocks(
          ID: maxID,
          Code: int.parse(controllerCode.text),
          Name: controllerName.text,
          IsActive: chkIsActive,
          IsBindBranch: chkIsBindBranch,
          IDBranch: branchID,
        );
        await bllDef_Stocks.fire_SetItem(maxID.toString(), widget.itemStock!);
      }

      //************************** Edit
      else if (widget.frmMode == en_FormMode.EditMode) {
        maxID = widget.itemStock!.ID!;
        widget.itemStock!.Code = int.parse(controllerCode.text);
        widget.itemStock!.Name = controllerName.text;
        widget.itemStock!.IsActive = chkIsActive;
        widget.itemStock!.IsBindBranch = chkIsBindBranch;
        widget.itemStock!.IDBranch = branchID;
      }

      await bllDef_Stocks.fire_SetItem(maxID.toString(), widget.itemStock!);
      Navigator.pop(context, true);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/bllDef_FinancialCluses.dart';
import '../../../bll/classModel/Def_FinancialCluses.dart';

class scr_FinancialClusesItem extends StatefulWidget {
  scr_FinancialClusesItem(this.itemFinancialCluses, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Def_FinancialCluses? itemFinancialCluses;
  en_FormMode frmMode;

  @override
  State<scr_FinancialClusesItem> createState() => _scr_FinancialClusesItemState();
}

class _scr_FinancialClusesItemState extends State<scr_FinancialClusesItem> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCode = TextEditingController();
  bool chkIsActive = false;
  bool chkIsViewToRepresent = false;
  bool chkIsDefaultToTransferMony = false;
  int? financialTypeID;

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
              text: 'بيانات بند النقدية',
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
            ctr_DropDowenList(
              hintLable: 'نوع البند',
              padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 0),
              lstDataSource: financialCluses_bloc.instance.LstFinacialType,
              hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
              itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
              menuMaxHeightValue: 300,
              selectedValue: financialTypeID,
              OnChanged: (returnID) {
                financialTypeID = returnID;
                print(financialTypeID);
                return financialTypeID;
              },
              OnValidate: (value) {
                if (value == null) {
                  return 'لابد من إختيار نوع البند';
                }
                return null;
              },
            ),
            Row(
              children: [
                Checkbox(
                    value: chkIsViewToRepresent,
                    onChanged: (value) {
                      setState(() {
                        chkIsViewToRepresent = !chkIsViewToRepresent;
                      });
                    }),
                const Text('يستخدم مع المندوبين', style: TextStyle(fontSize: 17)),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: chkIsDefaultToTransferMony,
                    onChanged: (value) {
                      setState(() {
                        chkIsDefaultToTransferMony = !chkIsDefaultToTransferMony;
                      });
                    }),
                const Text('البند الإفتراضي لتحويل النقدية', style: TextStyle(fontSize: 17)),
              ],
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
    chkIsActive = true ;
    bllDef_FinancialCluses.getMaxID_firestore().then((val) {
      controllerCode.text = val.toString();
    }).toString();
  }

  void EditMode() {
    if (widget.itemFinancialCluses != null) {
      controllerCode.text = widget.itemFinancialCluses!.Code.toString();
      controllerName.text = widget.itemFinancialCluses!.Name!;
      chkIsActive = widget.itemFinancialCluses!.IsActive!;
      chkIsViewToRepresent = widget.itemFinancialCluses!.IsViewToRepresent!;
      chkIsDefaultToTransferMony = widget.itemFinancialCluses!.IsDefaultToTransferMony!;
      financialTypeID = widget.itemFinancialCluses!.IDFinancialType;
    }
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      int maxID = 0;

      //************************** New
      if (widget.frmMode == en_FormMode.NewMode) {
        maxID = await bllDef_FinancialCluses.getMaxID_firestore();
        widget.itemFinancialCluses = Def_FinancialCluses(
          ID: maxID,
          Code: int.parse(controllerCode.text),
          Name: controllerName.text,
          IsActive: chkIsActive,
          IsViewToRepresent: chkIsViewToRepresent,
          IsDefaultToTransferMony: chkIsDefaultToTransferMony,
          IDFinancialType: financialTypeID,
        );
        await bllDef_FinancialCluses.fire_SetItem(maxID.toString(), widget.itemFinancialCluses!);
      }

      //************************** Edit
      else if (widget.frmMode == en_FormMode.EditMode) {
        maxID = widget.itemFinancialCluses!.ID!;
        widget.itemFinancialCluses!.Code = int.parse(controllerCode.text);
        widget.itemFinancialCluses!.Name = controllerName.text;
        widget.itemFinancialCluses!.IsActive = chkIsActive;
        widget.itemFinancialCluses!.IsViewToRepresent = chkIsViewToRepresent;
        widget.itemFinancialCluses!.IsDefaultToTransferMony = chkIsDefaultToTransferMony;
        widget.itemFinancialCluses!.IDFinancialType = financialTypeID;
      }

      await bllDef_FinancialCluses.fire_SetItem(maxID.toString(), widget.itemFinancialCluses!);
      Navigator.pop(context, true);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/bllDef_ProductionCompanies.dart';
import '../../../bll/classModel/Def_ProductionCompanies.dart';

class scr_ProductionComItem extends StatefulWidget {
  scr_ProductionComItem(this.itemProductionCom, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Def_ProductionCompanies? itemProductionCom;
  en_FormMode frmMode;

  @override
  State<scr_ProductionComItem> createState() => _scr_ProductionComItemState();
}

class _scr_ProductionComItemState extends State<scr_ProductionComItem> {
  TextEditingController controllerName = TextEditingController();
  bool chkIsActive = false;
  bool chkIsSalesCategory = false;
  var frmKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: buildCustomBar(),
        titleSpacing: 20,actions: [
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
                text: 'بيانات الشركة المنتجة',
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
              ),
              const SizedBox(height: 5),
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
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: chkIsSalesCategory,
                      onChanged: (value) {
                        setState(() {
                          chkIsSalesCategory = !chkIsSalesCategory;
                        });
                      }),
                  const Text('يعرض فى المبيعات', style: TextStyle(fontSize: 17)),
                ],
              ),
              ctr_TextFormField(
                Controller: controllerName,
                padding: const EdgeInsets.only(right: 7),
                TextType: TextInputType.text,
                TextAlignValue: TextAlign.end,
                Lable: 'الإســــم',
                OnValidate: (value) {
                  if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
                  return null;
                },
              ),
              SizedBox(height: 10),

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
          onPressed: () {

          },
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

  }

  void EditMode() {
    if (widget.itemProductionCom != null) {
      controllerName.text = widget.itemProductionCom!.Name!;
      chkIsActive = widget.itemProductionCom!.IsActive!;
      chkIsSalesCategory = widget.itemProductionCom!.IsSalesCategory!;
    }
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      int maxID = 0;

      //************************** New
      if (widget.frmMode == en_FormMode.NewMode) {
        maxID = await bllDef_ProductionCompanies.getMaxID_firestore();
        widget.itemProductionCom = Def_ProductionCompanies(
          ID: maxID,
          Name: controllerName.text,
          IsActive: chkIsActive,
          IsSalesCategory: chkIsSalesCategory,
        );
        await bllDef_ProductionCompanies.fire_SetItem(maxID.toString(), widget.itemProductionCom!);
      }

      //************************** Edit
      else if (widget.frmMode == en_FormMode.EditMode) {
        maxID = widget.itemProductionCom!.ID!;
        widget.itemProductionCom!.Name = controllerName.text;
        widget.itemProductionCom!.IsActive = chkIsActive;
        widget.itemProductionCom!.IsSalesCategory = chkIsSalesCategory;
      }

      await bllDef_ProductionCompanies.fire_SetItem(maxID.toString(), widget.itemProductionCom!);
      Navigator.pop(context, true);
    }
  }
}

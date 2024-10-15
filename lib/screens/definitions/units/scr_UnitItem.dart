import 'package:flutter/material.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/bllDef_Units.dart';
import '../../../bll/classModel/Def_Units.dart';

class scr_UnitItem extends StatefulWidget {
  scr_UnitItem(this.itemUnit, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Def_Units? itemUnit;
  en_FormMode frmMode;

  @override
  State<scr_UnitItem> createState() => _scr_UnitItemState();
}

class _scr_UnitItemState extends State<scr_UnitItem> {
  TextEditingController controllerName = TextEditingController();
  bool chkIsActive = false;
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
                text: 'وحدة الأصناف',
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
              ctr_TextFormField(
                Controller: controllerName,
                padding: const EdgeInsets.only(right: 7),
                TextType: TextInputType.text,
                TextAlignValue: TextAlign.end,
                Lable: 'الإســـم',
                OnValidate: (value) {
                  if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
                  return null;
                },
              ),
              SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     ElevatedButton.icon(
              //       onPressed: () async {
              //         saveData();
              //       },
              //       label: const Text(
              //         'حفظ',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 17,
              //           color: Colors.black,
              //         ),
              //       ),
              //       icon: Icon(Icons.save),
              //       iconAlignment: IconAlignment.end,
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.white,
              //         elevation: 5,
              //       ),
              //     ),
              //     const SizedBox(width: 10),
              //     ElevatedButton.icon(
              //       onPressed: () {
              //         Navigator.of(context).pop();
              //       },
              //       label: const Text(
              //         'الغاء',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 17,
              //           color: Colors.black,
              //         ),
              //       ),
              //       icon: Icon(Icons.cancel),
              //       iconAlignment: IconAlignment.end,
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.white,
              //         elevation: 5,
              //       ),
              //     ),
              //   ],
              // ),
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
    if (widget.itemUnit != null) {
      controllerName.text = widget.itemUnit!.Name!;
      chkIsActive = widget.itemUnit!.IsActive!;
    }
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      int maxID = 0;

      //************************** New
      if (widget.frmMode == en_FormMode.NewMode) {
        maxID = await bllDef_Units.getMaxID_firestore();
        widget.itemUnit = Def_Units(
          ID: maxID,
          Name: controllerName.text,
          IsActive: chkIsActive,
        );
        await bllDef_Units.fire_SetItem(maxID.toString(), widget.itemUnit!);
      }

      //************************** Edit
      else if (widget.frmMode == en_FormMode.EditMode) {
        maxID = widget.itemUnit!.ID!;
        widget.itemUnit!.Name = controllerName.text;
        widget.itemUnit!.IsActive = chkIsActive;
      }

      await bllDef_Units.fire_SetItem(maxID.toString(), widget.itemUnit!);
      Navigator.pop(context, true);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/bllDef_Sections.dart';
import '../../../bll/classModel/Def_Sections.dart';

class scr_SectionItem extends StatefulWidget {
  scr_SectionItem(this.itemSection, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Def_Sections? itemSection;
  en_FormMode frmMode;

  @override
  State<scr_SectionItem> createState() => _scr_SectionItemState();
}

class _scr_SectionItemState extends State<scr_SectionItem> {
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
        child: Column(
          children: [
            ctr_TextHeaderPage(
              text: 'بيانات الإدارة - القسم',
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
              padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
              TextType: TextInputType.text,
              TextAlignValue: TextAlign.end,
              Lable: 'الإســـم',
              OnValidate: (value) {
                if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
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

  }

  void EditMode() {
    if (widget.itemSection != null) {
      controllerName.text = widget.itemSection!.Name!;
      chkIsActive = widget.itemSection!.IsActive!;
    }
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      int maxID = 0;

      //************************** New
      if (widget.frmMode == en_FormMode.NewMode) {
        maxID = await bllDef_Sections.getMaxID_firestore();
        widget.itemSection = Def_Sections(
          ID: maxID,
          Name: controllerName.text,
          IsActive: chkIsActive,
        );
        await bllDef_Sections.fire_SetItem(maxID.toString(), widget.itemSection!);
      }

      //************************** Edit
      else if (widget.frmMode == en_FormMode.EditMode) {
        maxID = widget.itemSection!.ID!;
        widget.itemSection!.Name = controllerName.text;
        widget.itemSection!.IsActive = chkIsActive;
      }

      await bllDef_Sections.fire_SetItem(maxID.toString(), widget.itemSection!);
      Navigator.pop(context, true);
    }
  }
}

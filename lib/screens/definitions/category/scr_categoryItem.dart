import 'package:flutter/material.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/bllDef_Categories.dart';
import '../../../bll/classModel/Def_Categories.dart';

class scr_categoryItem extends StatefulWidget {
  scr_categoryItem(this.itemCategory, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Def_Categories? itemCategory;
  en_FormMode frmMode;

  @override
  State<scr_categoryItem> createState() => _scr_categoryItemState();
}

class _scr_categoryItemState extends State<scr_categoryItem> {
  TextEditingController controllerName = TextEditingController();
  bool chkIsActive = false;
  bool chkIsSalesCategory = false;
  bool chkIsViewAllProducts = false;
  var frmKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: buildCustomBar(),
        titleSpacing: 20, actions: [
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
                text: 'بيانات التصنيف',
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
              Row(
                children: [
                  Checkbox(
                      value: chkIsViewAllProducts,
                      onChanged: (value) {
                        setState(() {
                          chkIsViewAllProducts = !chkIsViewAllProducts;
                        });
                      }),
                  const Text('يحوي كل الأصناف', style: TextStyle(fontSize: 17)),
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
    if (widget.itemCategory != null) {
      controllerName.text = widget.itemCategory!.Name!;
      chkIsActive = widget.itemCategory!.IsActive!;
      chkIsSalesCategory = widget.itemCategory!.IsSalesCategory!;
      chkIsViewAllProducts = widget.itemCategory!.IsViewAllProducts!;
    }
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      int maxID = 0;

      //************************** New
      if (widget.frmMode == en_FormMode.NewMode) {
        maxID = await bllDef_Categories.getMaxID_firestore();
        widget.itemCategory = Def_Categories(
          ID: maxID,
          Name: controllerName.text,
          IsActive: chkIsActive,
          IsSalesCategory: chkIsSalesCategory,
          IsViewAllProducts: chkIsViewAllProducts,
        );
        await bllDef_Categories.fire_SetItem(maxID.toString(), widget.itemCategory!);
      }

      //************************** Edit
      else if (widget.frmMode == en_FormMode.EditMode) {
        maxID = widget.itemCategory!.ID!;
        widget.itemCategory!.Name = controllerName.text;
        widget.itemCategory!.IsActive = chkIsActive;
        widget.itemCategory!.IsSalesCategory = chkIsSalesCategory;
        widget.itemCategory!.IsViewAllProducts = chkIsViewAllProducts;
      }

      await bllDef_Categories.fire_SetItem(maxID.toString(), widget.itemCategory!);
      Navigator.pop(context, true);
    }
  }
}

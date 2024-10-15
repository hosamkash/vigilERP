import 'package:flutter/material.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/blocManagment/blocFixTables/fix_table_bloc.dart';
import 'package:vigil_erp/componants/ctr_ContactsNumber.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/bllDealing_Vendors.dart';
import '../../../bll/classModel/Dealing_Vendors.dart';

class scr_VendorItem extends StatefulWidget {
  scr_VendorItem(this.itemVendor, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Dealing_Vendors? itemVendor;
  en_FormMode frmMode;

  @override
  State<scr_VendorItem> createState() => _scr_VendorItemState();
}

class _scr_VendorItemState extends State<scr_VendorItem> {
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
            icon: const Icon(Icons.arrow_forward),
          ),
          // const SizedBox(width: 100),
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
              text: 'بيانات المورد',
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_DropDowenList(
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
                      return branchID;
                    },
                    OnValidate: (value) {
                      if (value == null) {
                        return 'لابد من إختيار قيمة';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: ctr_TextFormField(
                    Controller: contCode,
                    padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                    Lable: 'الكود',
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
              Controller: contName,
              padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
              TextType: TextInputType.text,
              TextAlignValue: TextAlign.end,
              Lable: 'الإســــم',
              autoSelectData: true,
              OnValidate: (value) {
                if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
                return null;
              },
            ),

            Row(
              children: [
                Expanded(
                  child: ctr_ContactsNumber(
                    Controller: contMobile,
                    padding: EdgeInsets.only(right: 5, left: 2, top: 0, bottom: 5),

                    TextAlignValue: TextAlign.center,
                    Lable: 'الموبيل',
                    autoSelectData: true,
                  ),
                ),
                Expanded(
                  child: ctr_ContactsNumber(
                    Controller: contPhone,
                    padding: EdgeInsets.only(right: 2, left: 5, top: 0, bottom: 5),

                    TextAlignValue: TextAlign.center,
                    Lable: 'الهاتف',
                    autoSelectData: true,
                  ),
                ),
              ],
            ),

            ctr_TextFormField(
              Controller: contAddress,
              padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
              TextType: TextInputType.text,
              TextAlignValue: TextAlign.end,
              Lable: 'العنوان',
              autoSelectData: true,
              OnValidate: (value) {
                if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
                return null;
              },
            ),

            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contCurrentBalance,
                    padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                    TextType: TextInputType.phone,
                    TextAlignValue: TextAlign.center,
                    Lable: 'الرصيد الحالى',
                    autoSelectData: true,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: ctr_DropDowenList(
                    hintLable: 'الحالة',
                    padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                    lstDataSource: balanceType_bloc.instance.lstBalanceTypeAsDataSource,
                    hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                    itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                    menuMaxHeightValue: 300,
                    selectedValue: balanceTypeID,
                    OnChanged: (returnID) {
                      balanceTypeID = returnID;
                      return balanceTypeID;
                    },
                  ),
                ),
              ],
            ),
            ctr_TextFormField(
              Controller: contNote,
              padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
              TextType: TextInputType.phone,
              TextAlignValue: TextAlign.center,
              Lable: 'ملاحظات',
              autoSelectData: true,
            ),

          ],
        ),
      ),
    );
  }

  int? branchID;
  bool chkIsActive = true;
  TextEditingController contCode = TextEditingController();
  TextEditingController contName = TextEditingController();
  TextEditingController contMobile = TextEditingController();
  TextEditingController contPhone = TextEditingController();
  TextEditingController contAddress = TextEditingController();
  TextEditingController contCurrentBalance = TextEditingController();
  int? balanceTypeID;
  TextEditingController contNote = TextEditingController();

  var frmKey = GlobalKey<FormState>();

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
    bllDealing_Vendors.getMax_firestore(enTable_Dealing_Vendors.Code).then((val) {
      contCode.text = val.toString();
    }).toString();

    // branchID =
    // company_bloc.instance.LstBranchesAsDataSource.isNotEmpty ? company_bloc.instance.LstBranchesAsDataSource.first.valueMember : null;
    // priceTypeID = job_bloc.instance.LstJobsAsDataSource.isNotEmpty ? job_bloc.instance.LstJobsAsDataSource.first.valueMember : null;
    chkIsActive = true;
  }

  void EditMode() {
    if (widget.itemVendor != null) {
      branchID = widget.itemVendor!.IDBranch;
      chkIsActive = widget.itemVendor!.IsActive!;
      contCode.text = widget.itemVendor!.Code.toString();
      contName.text = widget.itemVendor!.Name!;
      contPhone.text = widget.itemVendor!.Phone!;
      contMobile.text = widget.itemVendor!.Mobile!;
      contAddress.text = widget.itemVendor!.Address!;
      contCurrentBalance.text = widget.itemVendor!.CurrentBalance.toString();
      balanceTypeID = widget.itemVendor!.BalanceType;
      contNote.text = widget.itemVendor!.Note!;
    }
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      int maxID = 0;
      //************************** New
      if (widget.frmMode == en_FormMode.NewMode) {
        maxID = await bllDealing_Vendors.getMaxID_firestore();
        widget.itemVendor = Dealing_Vendors(
          ID: maxID,
          IDBranch: branchID,
          IsActive: chkIsActive,
          Code: int.parse(contCode.text),
          Name: contName.text,
          Phone: contPhone.text,
          Mobile: contMobile.text,
          Address: contAddress.text,
          CurrentBalance: double.parse(contCurrentBalance.text),
          BalanceType: balanceTypeID,
          Note: contNote.text,
        );
      }

      //************************** Edit
      else if (widget.frmMode == en_FormMode.EditMode) {
        maxID = widget.itemVendor!.ID!;
        widget.itemVendor!.IDBranch = branchID;
        widget.itemVendor!.IsActive = chkIsActive;
        widget.itemVendor!.Code = int.parse(contCode.text);
        widget.itemVendor!.Name = contName.text;
        widget.itemVendor!.Phone = contPhone.text;
        widget.itemVendor!.Mobile = contMobile.text;
        widget.itemVendor!.Address = contAddress.text;
        widget.itemVendor!.CurrentBalance = double.parse(contCurrentBalance.text);
        widget.itemVendor!.BalanceType = balanceTypeID;
        widget.itemVendor!.Note = contNote.text;
      }

      await bllDealing_Vendors.fire_SetItem(maxID.toString(), widget.itemVendor!);
      Navigator.pop(context, true);
    }
  }
}

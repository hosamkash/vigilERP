import 'package:flutter/material.dart';
import 'package:vigil_erp/blocManagment/blocDealing/dealing_bloc.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/componants/ctr_ContactsNumber.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/managment/managmeFirebaseAuthentication.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/sharedHive.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/bllDealing_Users.dart';
import '../../../bll/classModel/Dealing_Users.dart';

class scr_UserItem extends StatefulWidget {
  scr_UserItem(this.itemUsers, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Dealing_Users? itemUsers;
  en_FormMode frmMode;

  @override
  State<scr_UserItem> createState() => _scr_UserItemState();
}

class _scr_UserItemState extends State<scr_UserItem> {
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
            const SizedBox(height: 5),
            ctr_TextHeaderPage(
              text: 'بيانات المستخدم',
              padding: const EdgeInsets.only(top: 5, right: 0, left: 0, bottom: 0),
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            Row(
              children: [
                Expanded(
                  child: ctr_DropDowenList(
                    hintLable: 'الفرع',
                    padding: EdgeInsets.only(right: 5, left: 5),
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
                  width: 130,
                  child: ctr_TextFormField(
                    Controller: contCode,
                    Lable: 'الكود',
                    padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
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
                Checkbox(
                    value: chkIsAdminAccount,
                    onChanged: (value) {
                      setState(() {
                        chkIsAdminAccount = !chkIsAdminAccount;
                      });
                    }),
                const Text('مدير النظام', style: TextStyle(fontSize: 17)),
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
            ctr_TextFormField(
              Controller: contEMail,
              padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
              TextType: TextInputType.emailAddress,
              TextAlignValue: TextAlign.end,
              Lable: 'الإيميل',
              autoSelectData: true,
              readOnly: (widget.frmMode == en_FormMode.NewMode ? false : true),
              OnValidate: (value) {
                if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
                return null;
              },
            ),
            ctr_DropDowenList(
              hintLable: 'مرتبط بموظف',
              padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
              lstDataSource: employee_bloc.instance.LstEmployeeAsDataSource,
              hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
              itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
              menuMaxHeightValue: 300,
              showClearIcon: true,
              selectedValue: employeeBindID,
              OnChanged: (returnID) {
                employeeBindID = returnID;
                return employeeBindID;
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
            ctr_TextFormField(
              Controller: contNote,
              padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
              TextType: TextInputType.text,
              TextAlignValue: TextAlign.center,
              Lable: 'ملاحظات',
            ),
          ],
        ),
      ),
    );
  }

  int? branchID;
  TextEditingController contCode = TextEditingController();
  TextEditingController contName = TextEditingController();
  TextEditingController contEMail = TextEditingController();
  bool chkIsActive = true;
  bool chkIsAdminAccount = false;
  int? employeeBindID;
  TextEditingController contMobile = TextEditingController();
  TextEditingController contPhone = TextEditingController();
  TextEditingController contAddress = TextEditingController();
  TextEditingController contNote = TextEditingController();
  String ImageName = '';
  String ImageURL = '';

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
    bllDealing_Users.getMax_firestore(enTable_Dealing_Users.Code).then((val) {
      contCode.text = val.toString();
    }).toString();

    // branchID =
    // company_bloc.instance.LstBranchesAsDataSource.isNotEmpty ? company_bloc.instance.LstBranchesAsDataSource.first.valueMember : null;
    // priceTypeID = job_bloc.instance.LstJobsAsDataSource.isNotEmpty ? job_bloc.instance.LstJobsAsDataSource.first.valueMember : null;
  }

  void EditMode() {
    if (widget.itemUsers != null) {
      branchID = widget.itemUsers!.IDBranch;
      contCode.text = widget.itemUsers!.Code.toString();
      contName.text = widget.itemUsers!.Name!;
      contEMail.text = widget.itemUsers!.EMail!;
      chkIsActive = widget.itemUsers!.IsActive!;
      chkIsAdminAccount = widget.itemUsers!.IsAdminAccount!;
      employeeBindID = widget.itemUsers!.IDEmployeeBind ?? null;
      contPhone.text = widget.itemUsers!.Phone!;
      contMobile.text = widget.itemUsers!.Mobile!;
      contAddress.text = widget.itemUsers!.Address!;
      contNote.text = widget.itemUsers!.Note!;
      widget.itemUsers!.ImageName = ImageName;
      widget.itemUsers!.ImageURL = ImageURL;
    }
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      int maxID = 0;

      if (widget.frmMode == en_FormMode.NewMode) {
        sharedHive.UID = await managmeFirebaseAuthentication.createUserWithEmailAndPassword(contEMail.text.trim(), '123456');
        if (sharedHive.UID.isEmpty) {
          sharedControls.toastNotification('خطأ فى تسجيل المستخدم', false);
          return;
        }
        widget.itemUsers = Dealing_Users();
        maxID = await bllDealing_Users.getMaxID_firestore();
      } else if (widget.frmMode == en_FormMode.EditMode) {
        maxID = widget.itemUsers!.ID!;
      }

      widget.itemUsers!.ID = maxID;
      widget.itemUsers!.IDBranch = branchID;
      widget.itemUsers!.Code = int.parse(contCode.text);
      widget.itemUsers!.Name = contName.text;
      widget.itemUsers!.EMail = contEMail.text;
      widget.itemUsers!.IsActive = chkIsActive;
      widget.itemUsers!.IsAdminAccount = chkIsAdminAccount;
      widget.itemUsers!.IDEmployeeBind = employeeBindID;
      widget.itemUsers!.Mobile = contMobile.text;
      widget.itemUsers!.Phone = contPhone.text;
      widget.itemUsers!.Address = contAddress.text;
      widget.itemUsers!.Note = contNote.text;
      widget.itemUsers!.ImageName = ImageName;
      widget.itemUsers!.ImageURL = ImageURL;

      await bllDealing_Users.fire_SetItem(maxID.toString(), widget.itemUsers!);
      Navigator.pop(context, true);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:vigil_erp/bll/bllFirebase/bllDealing_Employees.dart';
import 'package:vigil_erp/bll/bllFirebase/bllHR_Bonus.dart';
import 'package:vigil_erp/bll/classModel/HR_Bonus.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/blocManagment/blocFixTables/fix_table_bloc.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/sharedFunctions.dart';
import 'package:vigil_erp/shared/sharedHive.dart';
import 'package:vigil_erp/shared/shared_controls.dart';
import '../../../blocManagment/blocDealing/dealing_bloc.dart';
import '../../../componants/ctr_Date.dart';
import '../../../componants/ctr_SelectEmployee.dart';
import '../../../componants/ctr_Time.dart';

class scr_bonusItem extends StatefulWidget {
  scr_bonusItem(this.itemBonus, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  HR_Bonus? itemBonus;
  en_FormMode frmMode;

  @override
  State<scr_bonusItem> createState() => _scr_bonusItemState();
}

class _scr_bonusItemState extends State<scr_bonusItem> {
  int selectedID = -1;
  int? branchID;
  int? bounsTypeID;
  bool chkIsClosed = false;
  TextEditingController contCode = TextEditingController();
  TextEditingController contDate = TextEditingController();
  TextEditingController contTime = TextEditingController();
  TimeOfDay? timeWorkFrom;
  TextEditingController_Employee contEmployee = TextEditingController_Employee();
  TextEditingController contJob = TextEditingController();
  TextEditingController contDepartment = TextEditingController();
  TextEditingController contSalaryMonthValue = TextEditingController();
  TextEditingController contSalaryWeekValue = TextEditingController();
  TextEditingController contSalaryDayValue = TextEditingController();
  TextEditingController contSalaryHourValue = TextEditingController();
  TextEditingController contBonusDay = TextEditingController();
  TextEditingController contBonusValue = TextEditingController();
  TextEditingController contBounsReson = TextEditingController();
  var frmKey = GlobalKey<FormState>();
  FocusNode focusNodeBonusDay = FocusNode();
  FocusNode focusNodeBonusValue = FocusNode();

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
    return Form(
      key: frmKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ctr_TextHeaderPage(
              text: 'بيانات المكافئة',
              color: checkIsSavedClosed() ? Colors.red[100] : Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            const SizedBox(height: 5),
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

                      // reset Employee and populate with New branch
                      contEmployee.selectEmployee = null;
                      contEmployee.text = '';
                      employee_bloc.instance.add(getLstEmployeeAsDataSource_Event());
                      ctr_SelectEmployee.branchID = branchID;
                      return null;
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
            SizedBox(height: 5),
            Row(
              children: [
                SizedBox(
                  width: 175,
                  child: ctr_TextFormField(
                    Controller: contCode,
                    padding: EdgeInsets.only(right: 5, left: 0),
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
                    value: chkIsClosed,
                    onChanged: (value) {
                      // setState(() {
                      //   chkIsClosed = !chkIsClosed;
                      // });
                    }),
                const Text('مستند مغلق', style: TextStyle(fontSize: 17)),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                SizedBox(
                  width: 175,
                  child: ctr_Date(
                    text: 'التاريخ',
                    dtController: contDate,
                    padding: EdgeInsets.only(right: 5, left: 0),
                    isReadOnly: true,
                    isOpenSelectorOnTap: true,
                    OnChanged: (val) {
                      return val;
                    },
                    OnValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'لابد من إختيار قيمة';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 175,
                  child: ctr_Time(
                    text: 'الساعة',
                    dtController: contTime,
                    padding: EdgeInsets.only(right: 5, left: 0),
                    isReadOnly: true,
                    isVisibleSearchIcon: false,
                    isOpenSelectorOnTap: true,
                    selectedTime: timeWorkFrom,
                    OnChanged: (val) {
                      timeWorkFrom = val;
                      return null;
                    },
                    OnValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'لابد من إختيار قيمة';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                ctr_SelectEmployee(
                  Controller: contEmployee,
                  padding: EdgeInsets.only(right: 5, left: 0),
                  labelText: 'الموظف',
                  isOpenSelectorOnTap: true,
                  labelStyle: TextStyle(color: Colors.red[700]),
                  colorBorder: Colors.red[700],
                  onSelectEmployee: (Dealing) {
                    contEmployee.selectEmployee = Dealing;
                    contJob.text = job_bloc.instance.getNameByID(contEmployee.selectEmployee!.IDJob);
                    contDepartment.text = sections_bloc.instance.getNameByID(contEmployee.selectEmployee!.IDDepartment);
                    contSalaryMonthValue.text = contEmployee.selectEmployee!.SalaryMonthValue.toString();
                    contSalaryWeekValue.text = contEmployee.selectEmployee!.SalaryWeekValue.toString();
                    contSalaryDayValue.text = contEmployee.selectEmployee!.SalaryDayValue.toString();
                    contSalaryHourValue.text = contEmployee.selectEmployee!.SalaryHourValue.toString();
                  },
                  OnValidate: (employee) {
                    if (employee != null && employee.isEmpty) {
                      return 'لابد من إختيار قيمة';
                    }
                    return null;
                  },
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contDepartment,
                    padding: EdgeInsets.only(right: 5, left: 0),
                    Lable: 'الإدارة - القسم',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    readOnly: true,
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contJob,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'الوظيفة',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contSalaryMonthValue,
                    padding: EdgeInsets.only(right: 5, left: 0),
                    Lable: 'قيمة الشهر',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    readOnly: true,
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contSalaryWeekValue,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'قيمة الأسبوع',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contSalaryDayValue,
                    padding: EdgeInsets.only(right: 5, left: 0),
                    Lable: 'قيمة اليوم',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    readOnly: true,
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contSalaryHourValue,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'قيمة الساعة',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(
              color: Colors.grey,
              thickness: 2,
              indent: 30,
              endIndent: 30,
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ctr_DropDowenList(
                    hintLable: 'نوع المكافئة',
                    padding: EdgeInsets.only(right: 5, left: 0),
                    lstDataSource: bonusType_bloc.instance.lstBonusTypeAsDataSource,
                    hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                    itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                    menuMaxHeightValue: 300,
                    showClearIcon: false,
                    selectedValue: bounsTypeID,
                    OnChanged: (returnID) {
                      bounsTypeID = returnID;
                      if (bounsTypeID == en_BounsType.Day.value) {
                        FocusScope.of(context).requestFocus(focusNodeBonusDay);
                      } else if (bounsTypeID == en_BounsType.MonyValue.value) {
                        FocusScope.of(context).requestFocus(focusNodeBonusValue);
                        contBonusDay.text = '0';
                      }

                      return bounsTypeID;
                    },
                    OnValidate: (value) {
                      if (value == null) {
                        return 'لابد من إختيار قيمة';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: ctr_TextFormField(
                    Controller: contBonusDay,
                    padding: EdgeInsets.only(right: 5, left: 0),
                    Lable: 'اليوم',
                    TextType: TextInputType.number,
                    focusNode: focusNodeBonusDay,
                    OnChanged: (val) {
                      if (val != null && val.isNotEmpty && bounsTypeID == en_BounsType.MonyValue.value) {
                        contBonusDay.text = '0';
                        sharedControls.toastNotification('للكتابة فى الأيام إختار يوم من نوع المكافئة', false);
                      }

                      contBonusDay.text = contBonusDay.text.isNotEmpty && double.tryParse(contBonusDay.text) != null ? contBonusDay.text : '0';
                      contBonusValue.text = (double.parse(contBonusDay.text) * double.parse(contSalaryDayValue.text)).toStringAsFixed(2);
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: ctr_TextFormField(
                    Controller: contBonusValue,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'القيمة',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    focusNode: focusNodeBonusValue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            ctr_TextFormField(
              Controller: contBounsReson,
              padding: EdgeInsets.only(right: 5, left: 5),
              TextType: TextInputType.multiline,
              TextAlignValue: TextAlign.center,
              Lable: 'سبب المكافئة',
              autoSelectData: true,
              minLines: 3,
            ),

            if (!checkIsSavedClosed())
              ElevatedButton.icon(
                label: Text(
                  'حفظ وغلق',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.blue[800]),
                ),
                icon: Icon(Icons.done_outline),
                style: ElevatedButton.styleFrom(elevation: 3, backgroundColor: Colors.white),
                onPressed: () {
                  sharedControls.confirmDialog(context, 'حفظ وإغلاق', 'فى حالة التأكيد سيتم غلق المستند ولا يمكن التعديل فيها نهائياً', () {
                    chkIsClosed = true;
                    saveData();
                  });
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

    clearCachedData();

    if (widget.frmMode == en_FormMode.NewMode)
      newMode();
    else if (widget.frmMode == en_FormMode.EditMode) editMode();
  }

  Widget buildCustomBar() {
    return Row(
      children: [
        if (!checkIsSavedClosed())
        IconButton(
          onPressed: () {
            saveData();
          },
          icon: Icon(
            Icons.save,
            color: Colors.blue[900],
            size: 30,
          ),
          padding: EdgeInsets.only(right: 5, left: 0),
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
          padding: EdgeInsets.only(right: 0, left: 5),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.print,
            color: Colors.purple,
            size: 30,
          ),
          padding: EdgeInsets.only(right: 0, left: 5),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.share,
            color: Colors.green,
            size: 30,
          ),
          padding: EdgeInsets.only(right: 0, left: 5),
        ),
      ],
    );
  }

  void newMode() async {
    bllHR_Bonus.getMax_firestore(enTable_HR_Bonus.Code).then((val) {
      contCode.text = val.toString();
    }).toString();

    contDate.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    contTime.text = sharedFunctions_Dates.convertDateTime_TimeString(DateTime.now());
    chkIsClosed = false;
  }

  void editMode() async {
    if (widget.itemBonus != null) {
      bounsTypeID = widget.itemBonus!.BounsType;
      chkIsClosed = widget.itemBonus!.IsClosed!;
      branchID = widget.itemBonus!.IDBranch;
      selectedID = widget.itemBonus!.ID!;
      contCode.text = widget.itemBonus!.Code.toString();
      contDate.text = widget.itemBonus!.Date!;
      contTime.text = widget.itemBonus!.Time!;
      contEmployee.selectEmployee = await bllDealing_Employees.fire_getItem(widget.itemBonus!.IDEmployee!.toString());
      contEmployee.text = contEmployee.selectEmployee!.Name!;

      contJob.text = job_bloc.instance.getNameByID(widget.itemBonus!.IDJob);
      contDepartment.text = sections_bloc.instance.getNameByID(widget.itemBonus!.IDDepartment);
      contSalaryMonthValue.text = widget.itemBonus!.EmployeeSalaryMonth.toString();
      contSalaryWeekValue.text = widget.itemBonus!.EmployeeSalaryWeek.toString();
      contSalaryDayValue.text = widget.itemBonus!.EmployeeSalaryDay.toString();
      contSalaryHourValue.text = widget.itemBonus!.EmployeeSalaryHour.toString();
      contBonusDay.text = widget.itemBonus!.BounsDays.toString();
      contBonusValue.text = widget.itemBonus!.BounsValue.toString();
      contBounsReson.text = widget.itemBonus!.BounsReson!;
    }
  }

  void clearCachedData() {
    ctr_SelectEmployee.branchID = branchID = contEmployee.selectEmployee = null;
    contBonusValue.text = contBonusDay.text = contBounsReson.text = contEmployee.text = '';
    employee_bloc.instance.add(resetFilterEmployee_Event());
  }

  bool checkIsSavedClosed() {
    if (widget.frmMode == en_FormMode.EditMode && (widget.itemBonus!.IsClosed!))
      return true;
    else
      return false;
  }


  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      if (widget.frmMode == en_FormMode.NewMode) {
        selectedID = await bllHR_Bonus.getMaxID_firestore();
      } else if (widget.frmMode == en_FormMode.EditMode) {
        selectedID = widget.itemBonus!.ID!;
      }
      widget.itemBonus = HR_Bonus();
      widget.itemBonus!.ID = selectedID;
      widget.itemBonus!.IDBranch = branchID;
      widget.itemBonus!.Code = int.parse(contCode.text);
      widget.itemBonus!.Date = contDate.text;
      widget.itemBonus!.Time = contTime.text;
      widget.itemBonus!.IDEmployee = contEmployee.selectEmployee!.ID;
      widget.itemBonus!.IDJob = contEmployee.selectEmployee!.IDJob;
      widget.itemBonus!.IDDepartment = contEmployee.selectEmployee!.IDDepartment;
      widget.itemBonus!.EmployeeSalaryMonth = double.tryParse(contSalaryMonthValue.text);
      widget.itemBonus!.EmployeeSalaryWeek = double.tryParse(contSalaryWeekValue.text);
      widget.itemBonus!.EmployeeSalaryDay = double.tryParse(contSalaryDayValue.text);
      widget.itemBonus!.EmployeeSalaryHour = double.tryParse(contSalaryHourValue.text);
      widget.itemBonus!.BounsType = bounsTypeID;
      widget.itemBonus!.BounsDays = double.tryParse(contBonusDay.text);
      widget.itemBonus!.BounsValue = double.tryParse(contBonusValue.text);
      widget.itemBonus!.BounsReson = contBounsReson.text;
      widget.itemBonus!.UID = sharedHive.UID;
      widget.itemBonus!.IsClosed = chkIsClosed;

      await bllHR_Bonus.fire_SetItem(selectedID.toString(), widget.itemBonus!);
      Navigator.pop(context, true);
    }
  }
}

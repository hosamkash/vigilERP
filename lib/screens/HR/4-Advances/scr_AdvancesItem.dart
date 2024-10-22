import 'package:flutter/material.dart';
import 'package:vigil_erp/bll/bllFirebase/bllDealing_Employees.dart';
import 'package:vigil_erp/bll/bllFirebase/bllHR_Advances.dart';
import 'package:vigil_erp/bll/classModel/HR_Advances.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
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

class scr_AdvancesItem extends StatefulWidget {
  scr_AdvancesItem(this.itemAdvances, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  HR_Advances? itemAdvances;
  en_FormMode frmMode;

  @override
  State<scr_AdvancesItem> createState() => _scr_AdvancesItemState();
}

class _scr_AdvancesItemState extends State<scr_AdvancesItem> {
  int selectedID = -1;
  int? branchID;
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
  TextEditingController contValue = TextEditingController();
  TextEditingController contInstallmentValue = TextEditingController();
  TextEditingController contInstallmentCount = TextEditingController();
  TextEditingController contInstallmentDateStart = TextEditingController();
  TextEditingController contReson = TextEditingController();
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
              text: 'بيان السحب النقدي',
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
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contValue,
                    padding: EdgeInsets.only(right: 5, left: 0),
                    Lable: 'قيمة السلفة',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contInstallmentValue,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'قيمة القسط',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    OnChanged: (val) {
                      contInstallmentCount.text = (double.parse(contValue.text) / double.parse(contInstallmentValue.text)).toStringAsFixed(2);
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contInstallmentCount,
                    padding: EdgeInsets.only(right: 5, left: 0),
                    Lable: 'عدد الأقساط',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    OnChanged: (val) {
                      contInstallmentCount.text = contInstallmentCount.text.trim().isNotEmpty  ? contInstallmentCount.text.trim() : '0.0';
                      contValue.text = contValue.text.trim().isNotEmpty  ? contValue.text.trim() : '0.0';

                      contInstallmentValue.text = (double.parse(contValue.text) / double.parse(contInstallmentCount.text)).toStringAsFixed(2);
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: ctr_Date(
                    text: 'تاريخ أول قسط',
                    dtController: contInstallmentDateStart,
                    padding: EdgeInsets.only(right: 5, left: 0),
                    isReadOnly: true,
                    isOpenSelectorOnTap: true,
                    OnChanged: (val) {
                      return val;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            ctr_TextFormField(
              Controller: contReson,
              padding: EdgeInsets.only(right: 5, left: 5),
              TextType: TextInputType.multiline,
              TextAlignValue: TextAlign.center,
              Lable: 'البيان - سبب السلفة',
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
    bllHR_Advances.getMax_firestore(enTable_HR_Advances.Code).then((val) {
      contCode.text = val.toString();
    }).toString();

    contDate.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    contTime.text = sharedFunctions_Dates.convertDateTime_TimeString(DateTime.now());
    chkIsClosed = false;
  }

  void editMode() async {
    if (widget.itemAdvances != null) {
      chkIsClosed = widget.itemAdvances!.IsClosed!;
      branchID = widget.itemAdvances!.IDBranch;
      selectedID = widget.itemAdvances!.ID!;
      contCode.text = widget.itemAdvances!.Code.toString();
      contDate.text = widget.itemAdvances!.Date!;
      contTime.text = widget.itemAdvances!.Time!;
      contEmployee.selectEmployee = await bllDealing_Employees.fire_getItem(widget.itemAdvances!.IDEmployee!.toString());
      contEmployee.text = contEmployee.selectEmployee!.Name!;

      contJob.text = job_bloc.instance.getNameByID(widget.itemAdvances!.IDJob);
      contDepartment.text = sections_bloc.instance.getNameByID(widget.itemAdvances!.IDDepartment);
      contSalaryMonthValue.text = widget.itemAdvances!.EmployeeSalaryMonth.toString();
      contSalaryWeekValue.text = widget.itemAdvances!.EmployeeSalaryWeek.toString();
      contSalaryDayValue.text = widget.itemAdvances!.EmployeeSalaryDay.toString();
      contSalaryHourValue.text = widget.itemAdvances!.EmployeeSalaryHour.toString();
      contValue.text = widget.itemAdvances!.Value.toString();
      contInstallmentValue .text = widget.itemAdvances!.InstallmentValue .toString();
      contInstallmentCount .text = widget.itemAdvances!. InstallmentCount.toString();
      contInstallmentDateStart.text = widget.itemAdvances!.InstallmentDateStart .toString();
      contReson.text = widget.itemAdvances!.Reson!;
    }
  }

  void clearCachedData() {
    ctr_SelectEmployee.branchID = branchID = contEmployee.selectEmployee = null;
    contValue.text = contReson.text = contEmployee.text = '';
    employee_bloc.instance.add(resetFilterEmployee_Event());
  }

  bool checkIsSavedClosed() {
    if (widget.frmMode == en_FormMode.EditMode && (widget.itemAdvances!.IsClosed!))
      return true;
    else
      return false;
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      if (widget.frmMode == en_FormMode.NewMode) {
        selectedID = await bllHR_Advances.getMaxID_firestore();
      } else if (widget.frmMode == en_FormMode.EditMode) {
        selectedID = widget.itemAdvances!.ID!;
      }
      widget.itemAdvances = HR_Advances();
      widget.itemAdvances!.ID = selectedID;
      widget.itemAdvances!.IDBranch = branchID;
      widget.itemAdvances!.Code = int.parse(contCode.text);
      widget.itemAdvances!.Date = contDate.text;
      widget.itemAdvances!.Time = contTime.text;
      widget.itemAdvances!.IDEmployee = contEmployee.selectEmployee!.ID;
      widget.itemAdvances!.IDJob = contEmployee.selectEmployee!.IDJob;
      widget.itemAdvances!.IDDepartment = contEmployee.selectEmployee!.IDDepartment;
      widget.itemAdvances!.EmployeeSalaryMonth = double.tryParse(contSalaryMonthValue.text);
      widget.itemAdvances!.EmployeeSalaryWeek = double.tryParse(contSalaryWeekValue.text);
      widget.itemAdvances!.EmployeeSalaryDay = double.tryParse(contSalaryDayValue.text);
      widget.itemAdvances!.EmployeeSalaryHour = double.tryParse(contSalaryHourValue.text);
      widget.itemAdvances!.Value = double.tryParse(contValue.text);
      widget.itemAdvances!.InstallmentValue = double.tryParse(contInstallmentValue.text);
      widget.itemAdvances!.InstallmentCount = double.tryParse(contInstallmentCount.text);
      widget.itemAdvances!.InstallmentDateStart = contInstallmentDateStart.text;
      widget.itemAdvances!.Reson = contReson.text;
      widget.itemAdvances!.UID = sharedHive.UID;
      widget.itemAdvances!.IsClosed = chkIsClosed;

      await bllHR_Advances.fire_SetItem(selectedID.toString(), widget.itemAdvances!);
      Navigator.pop(context, true);
    }
  }
}

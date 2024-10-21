import 'package:flutter/material.dart';
import 'package:vigil_erp/bll/bllFirebase/bllDealing_Employees.dart';
import 'package:vigil_erp/bll/bllFirebase/bllHR_Discount.dart';
import 'package:vigil_erp/bll/classModel/HR_Discount.dart';
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

class scr_discountItem extends StatefulWidget {
  scr_discountItem(this.itemDiscount, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  HR_Discount? itemDiscount;
  en_FormMode frmMode;

  @override
  State<scr_discountItem> createState() => _scr_discountItemState();
}

class _scr_discountItemState extends State<scr_discountItem> {
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
  TextEditingController contDiscountDay = TextEditingController();
  TextEditingController contDiscountValue = TextEditingController();
  TextEditingController contBounsReson = TextEditingController();
  var frmKey = GlobalKey<FormState>();
  FocusNode focusNodeDiscountDay = FocusNode();
  FocusNode focusNodeDiscountValue = FocusNode();

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
              text: 'بيانات الجزاء - الخصم',
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
                    hintLable: 'نوع الخصم',
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
                        FocusScope.of(context).requestFocus(focusNodeDiscountDay);
                      } else if (bounsTypeID == en_BounsType.MonyValue.value) {
                        FocusScope.of(context).requestFocus(focusNodeDiscountValue);
                        contDiscountDay.text = '0';
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
                    Controller: contDiscountDay,
                    padding: EdgeInsets.only(right: 5, left: 0),
                    Lable: 'اليوم',
                    TextType: TextInputType.number,
                    focusNode: focusNodeDiscountDay,
                    OnChanged: (val) {
                      if (val != null && val.isNotEmpty && bounsTypeID == en_BounsType.MonyValue.value) {
                        contDiscountDay.text = '0';
                        sharedControls.toastNotification('للكتابة فى الأيام إختار يوم من نوع المكافئة', false);
                      }

                      contDiscountDay.text = contDiscountDay.text.isNotEmpty && double.tryParse(contDiscountDay.text) != null ? contDiscountDay.text : '0';
                      contDiscountValue.text = (double.parse(contDiscountDay.text) * double.parse(contSalaryDayValue.text)).toStringAsFixed(2);
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: ctr_TextFormField(
                    Controller: contDiscountValue,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'القيمة',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    focusNode: focusNodeDiscountValue,
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
              Lable: 'سبب الجزاء - الخصم',
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
    bllHR_Discount.getMax_firestore(enTable_HR_Discount.Code).then((val) {
      contCode.text = val.toString();
    }).toString();

    contDate.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    contTime.text = sharedFunctions_Dates.convertDateTime_TimeString(DateTime.now());
    chkIsClosed = false;
  }

  void editMode() async {
    if (widget.itemDiscount != null) {
      bounsTypeID = widget.itemDiscount!.DiscountType;
      chkIsClosed = widget.itemDiscount!.IsClosed!;
      branchID = widget.itemDiscount!.IDBranch;
      selectedID = widget.itemDiscount!.ID!;
      contCode.text = widget.itemDiscount!.Code.toString();
      contDate.text = widget.itemDiscount!.Date!;
      contTime.text = widget.itemDiscount!.Time!;
      contEmployee.selectEmployee = await bllDealing_Employees.fire_getItem(widget.itemDiscount!.IDEmployee!.toString());
      contEmployee.text = contEmployee.selectEmployee!.Name!;

      contJob.text = job_bloc.instance.getNameByID(widget.itemDiscount!.IDJob);
      contDepartment.text = sections_bloc.instance.getNameByID(widget.itemDiscount!.IDDepartment);
      contSalaryMonthValue.text = widget.itemDiscount!.EmployeeSalaryMonth.toString();
      contSalaryWeekValue.text = widget.itemDiscount!.EmployeeSalaryWeek.toString();
      contSalaryDayValue.text = widget.itemDiscount!.EmployeeSalaryDay.toString();
      contSalaryHourValue.text = widget.itemDiscount!.EmployeeSalaryHour.toString();
      contDiscountDay.text = widget.itemDiscount!.DiscountDays.toString();
      contDiscountValue.text = widget.itemDiscount!.DiscountValue.toString();
      contBounsReson.text = widget.itemDiscount!.DiscountReson!;
    }
  }

  void clearCachedData() {
    ctr_SelectEmployee.branchID = branchID = contEmployee.selectEmployee = null;
    contDiscountValue.text = contDiscountDay.text = contBounsReson.text = contEmployee.text = '';
    employee_bloc.instance.add(resetFilterEmployee_Event());
  }

  bool checkIsSavedClosed() {
    if (widget.frmMode == en_FormMode.EditMode && (widget.itemDiscount!.IsClosed!))
      return true;
    else
      return false;
  }


  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      if (widget.frmMode == en_FormMode.NewMode) {
        selectedID = await bllHR_Discount.getMaxID_firestore();
      } else if (widget.frmMode == en_FormMode.EditMode) {
        selectedID = widget.itemDiscount!.ID!;
      }
      widget.itemDiscount = HR_Discount();
      widget.itemDiscount!.ID = selectedID;
      widget.itemDiscount!.IDBranch = branchID;
      widget.itemDiscount!.Code = int.parse(contCode.text);
      widget.itemDiscount!.Date = contDate.text;
      widget.itemDiscount!.Time = contTime.text;
      widget.itemDiscount!.IDEmployee = contEmployee.selectEmployee!.ID;
      widget.itemDiscount!.IDJob = contEmployee.selectEmployee!.IDJob;
      widget.itemDiscount!.IDDepartment = contEmployee.selectEmployee!.IDDepartment;
      widget.itemDiscount!.EmployeeSalaryMonth = double.tryParse(contSalaryMonthValue.text);
      widget.itemDiscount!.EmployeeSalaryWeek = double.tryParse(contSalaryWeekValue.text);
      widget.itemDiscount!.EmployeeSalaryDay = double.tryParse(contSalaryDayValue.text);
      widget.itemDiscount!.EmployeeSalaryHour = double.tryParse(contSalaryHourValue.text);
      widget.itemDiscount!.DiscountType = bounsTypeID;
      widget.itemDiscount!.DiscountDays = double.tryParse(contDiscountDay.text);
      widget.itemDiscount!.DiscountValue = double.tryParse(contDiscountValue.text);
      widget.itemDiscount!.DiscountReson = contBounsReson.text;
      widget.itemDiscount!.UID = sharedHive.UID;
      widget.itemDiscount!.IsClosed = chkIsClosed;

      await bllHR_Discount.fire_SetItem(selectedID.toString(), widget.itemDiscount!);
      Navigator.pop(context, true);
    }
  }
}

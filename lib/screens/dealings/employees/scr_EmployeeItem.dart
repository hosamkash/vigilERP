import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vigil_erp/blocManagment/blocDealing/dealing_bloc.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/blocManagment/blocFixTables/fix_table_bloc.dart';
import 'package:vigil_erp/componants/0-PagesNew_SamplesGood/FingerprintAuth.dart';
import 'package:vigil_erp/componants/ctr_ContactsNumber.dart';
import 'package:vigil_erp/componants/ctr_Date.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_TabBar.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/componants/ctr_Time.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/managment/manage_Images.dart';
import 'package:vigil_erp/shared/sharedDesigne.dart';
import 'package:vigil_erp/shared/sharedFunctions.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/bllDealing_Employees.dart';
import '../../../bll/classModel/Dealing_Employees.dart';

class scr_EmployeeItem extends StatefulWidget {
  scr_EmployeeItem(this.itemEmployee, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Dealing_Employees itemEmployee;
  en_FormMode frmMode;

  @override
  State<scr_EmployeeItem> createState() => _scr_EmployeeItemState();
}

class _scr_EmployeeItemState extends State<scr_EmployeeItem> {
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
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              ctr_TextHeaderPage(
                text: 'بيانات الموظف',
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ctr_TextFormField(
                      Controller: contName,
                      padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                      TextType: TextInputType.text,
                      TextAlignValue: TextAlign.end,
                      Lable: 'الإســــم',
                      autoSelectData: true,
                      OnValidate: (value) {
                        if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 85,
                    child: Row(
                      children: [
                        Checkbox(
                            value: chkIsActive,
                            onChanged: (value) {
                              setState(() {
                                chkIsActive = !chkIsActive;
                              });
                            }),
                        Expanded(child: const Text('نشط', style: TextStyle(fontSize: 17))),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 550,
                child: Card(
                  color: Colors.grey[100],
                  child: ctr_TabBar(
                    LstTabBarViewHeaderWidget: const [
                      Text('الشخصية', style:  TextStyle(fontWeight: FontWeight.bold ),),
                      Text('الوظيفية', style:  TextStyle(fontWeight: FontWeight.bold ),),
                      Text('الراتب', style:  TextStyle(fontWeight: FontWeight.bold ),),
                      Text('الأقارب', style:  TextStyle(fontWeight: FontWeight.bold ),),
                    ],
                    LstTabBarViewWidget: [
                      BuildPersonalData(),
                      BuildJobData(),
                      BuildSalaryData(),
                      BuildRelativesPersonsData(),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget BuildPersonalData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // const SizedBox(height: 5),
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
              Expanded(
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
              ElevatedButton.icon(
                  onPressed: () {
                    sharedControls.navigatTo(context, FingerprintAuth());
                  },
                  label: Text('بصمة الموظف'),
                  icon: Icon(Icons.fingerprint)),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ctr_ContactsNumber(
                  Controller: contMobile,
                  padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                  TextAlignValue: TextAlign.center,
                  Lable: 'الموبيل',
                  autoSelectData: true,
                ),
              ),
              Expanded(
                child: ctr_ContactsNumber(
                  Controller: contPhone,
                  padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
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
          ),
          ctr_TextFormField(
            Controller: contNationalID,
            padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
            TextType: TextInputType.text,
            TextAlignValue: TextAlign.end,
            Lable: 'الرقم القومي',
            autoSelectData: true,
          ),

          Row(
            children: [
              Expanded(
                child: ctr_Date(
                  text: 'تاريخ الميلاد',
                  dtController: contBirthDate,
                  padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                  isReadOnly: true,
                  isOpenSelectorOnTap: true,
                  OnChanged: (val) {
                    if (val!.isNotEmpty) {
                      contAge.text = sharedFunctions_Dates.calcAge(val).toString();
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 100,
                child: ctr_TextFormField(
                  Controller: contAge,
                  padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                  TextType: TextInputType.number,
                  TextAlignValue: TextAlign.end,
                  Lable: 'العمر - السن',
                  autoSelectData: true,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ctr_DropDowenList(
                  hintLable: 'الحالة الإجتماعية',
                  padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                  lstDataSource: maritalStatus_bloc.instance.lstMaritalStatusAsDataSource,
                  hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                  itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                  menuMaxHeightValue: 300,
                  selectedValue: maritalStatusID,
                  OnChanged: (returnID) {
                    maritalStatusID = returnID;
                    return maritalStatusID;
                  },
                ),
              ),
              SizedBox(
                width: 100,
                child: ctr_TextFormField(
                  Controller: contChildrenCount,
                  padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                  TextType: TextInputType.number,
                  TextAlignValue: TextAlign.end,
                  Lable: 'عدد الأولاد',
                  autoSelectData: true,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ctr_DropDowenList(
                  hintLable: 'الديانة',
                  padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                  lstDataSource: religions_bloc.instance.lstReligionsAsDataSource,
                  hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                  itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                  menuMaxHeightValue: 300,
                  selectedValue: religionsID,
                  showClearIcon: false,
                  OnChanged: (returnID) {
                    religionsID = returnID;
                    return religionsID;
                  },
                ),
              ),
              Expanded(
                child: ctr_DropDowenList(
                  hintLable: 'النوع',
                  padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                  lstDataSource: gender_bloc.instance.lstgenderAsDataSource,
                  hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                  itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                  menuMaxHeightValue: 300,
                  selectedValue: genderID,
                  showClearIcon: false,
                  OnChanged: (returnID) {
                    genderID = returnID;
                    return genderID;
                  },
                ),
              ),
            ],
          ),
          ctr_DropDowenList(
            hintLable: 'الموقف التجنيدي',
            padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
            lstDataSource: militaryStatus_bloc.instance.lstmilitaryStatusAsDataSource,
            hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
            itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
            menuMaxHeightValue: 300,
            selectedValue: militaryStatusID,
            showClearIcon: false,
            OnChanged: (returnID) {
              militaryStatusID = returnID;
              return militaryStatusID;
            },
          ),
          ctr_TextFormField(
            Controller: contQualification,
            padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
            TextType: TextInputType.text,
            TextAlignValue: TextAlign.end,
            Lable: 'المؤهل الدراسي',
            autoSelectData: true,
          ),


          Stack(
            children: [
              Container(
                color: Colors.grey[100],
                child: BlocBuilder<employee_bloc, dealing_state>(
                  builder: (context, state) {
                    if (state is! getListEmployee_StateDataChanged) {
                      loadImageEmployee();
                    }
                    return Image(
                      image: employee_bloc.instance.EmployeeImageTemp.image ?? manage_Images.defaultImage,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 25,
                  child: IconButton(
                    onPressed: (() async {
                      employee_bloc.instance.takeImageEmployee(ImageSource.camera);
                      widget.itemEmployee.ImageURL = '';
                    }),
                    icon: const Icon(
                      Icons.add_a_photo,
                      size: 27,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget BuildJobData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ctr_DropDowenList(
            hintLable: 'الوظيفة',
            padding: EdgeInsets.only(right: 5, left: 5),
            lstDataSource: job_bloc.instance.LstJobsAsDataSource,
            hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
            itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
            menuMaxHeightValue: 300,
            selectedValue: jobID,
            OnChanged: (returnID) {
              jobID = returnID;
              return jobID;
            },
          ),
          ctr_DropDowenList(
            hintLable: 'الإدارة / القسم',
            padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
            lstDataSource: sections_bloc.instance.LstSectionAsDataSource,
            hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
            itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
            menuMaxHeightValue: 300,
            selectedValue: departmentID,
            OnChanged: (returnID) {
              departmentID = returnID;
              return departmentID;
            },
          ),
          ctr_Date(
            text: 'تاريخ التعيين',
            dtController: contDateHiring,
            padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
            isReadOnly: true,
            isOpenSelectorOnTap: true,
          ),
          ctr_TextHeaderPage(
            text: 'مواعيد العمل',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            color: Colors.grey[200],
            borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
          ),
          Divider(
            color: sharedDesigne.primaryColor,
            height: 20,
            indent: 10,
            endIndent: 10,
            thickness: 3,
          ),
          Row(
            children: [
              Expanded(
                child: ctr_Time(
                  text: 'من',
                  dtController: contTimeWorkFrom,
                  padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                  isReadOnly: true,
                  isVisibleSearchIcon: false,
                  isOpenSelectorOnTap: true,
                  selectedTime: timeWorkFrom,
                  OnChanged: (val) {
                    timeWorkFrom = val;
                    calcTimeTotalWorkHour();
                    return null;
                  },
                ),
              ),
              Expanded(
                  child: ctr_Time(
                text: 'إلى',
                dtController: contTimeWorkTo,
                    padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                isReadOnly: true,
                isVisibleSearchIcon: false,
                selectedTime: timeWorkTo,
                isOpenSelectorOnTap: true,
                OnChanged: (val) {
                  timeWorkTo = val;
                  calcTimeTotalWorkHour();
                  return null;
                },
              )),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ctr_TextFormField(
                  Controller: contTimeTotalWorkHour,
                  padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                  TextType: const TextInputType.numberWithOptions(),
                  TextAlignValue: TextAlign.center,
                  Lable: 'عدد الساعات',
                  autoSelectData: true,
                  readOnly: true,
                ),
              ),
              Expanded(
                child: ctr_TextFormField(
                  Controller: contMonthlyVacationDays,
                  padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                  TextType: const TextInputType.numberWithOptions(),
                  TextAlignValue: TextAlign.center,
                  Lable: 'أيام الأجازة الشهرية',
                  autoSelectData: true,
                ),
              ),
            ],
          ),
          ctr_Date(
            text: 'تاريخ إنتهاء الخدمة',
            dtController: contExpiryDateJob,
            padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
            isReadOnly: true,
            isOpenSelectorOnTap: true,
          ),
          ctr_TextFormField(
            Controller: contLeavingReson,
            padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
            TextType: TextInputType.numberWithOptions(),
            TextAlignValue: TextAlign.end,
            Lable: 'سبب إنتهاء الخدمة',
            autoSelectData: true,
          ),
        ],
      ),
    );
  }

  Widget BuildSalaryData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            color: Colors.white,
            elevation: 3,
            child: Column(
              children: [
                ctr_TextHeaderPage(
                  text: 'قيمة الراتب',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contSalaryMonthValue,
                        padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                        Lable: 'قيمة الشهر',
                        TextType: const TextInputType.numberWithOptions(decimal: true),
                        OnChanged: (val) {
                          if (contTimeTotalWorkHour.text.isNotEmpty) {
                            contSalaryWeekValue.text = (double.parse(val!) / 4).toStringAsFixed(2);
                            contSalaryDayValue.text = (double.parse(val) / 30).toStringAsFixed(2);
                            contSalaryHourValue.text = (double.parse(val) / (30 * double.parse(contTimeTotalWorkHour.text))).toStringAsFixed(2);
                          }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contSalaryWeekValue,
                        padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                        Lable: 'قيمة الأسبوع',
                        TextType: const TextInputType.numberWithOptions(decimal: true),
                        OnChanged: (val) {
                          if (contTimeTotalWorkHour.text.isNotEmpty) {
                            contSalaryMonthValue.text = (double.parse(val!) * 4).toStringAsFixed(2);
                            contSalaryDayValue.text = (double.parse(contSalaryMonthValue.text) / 30).toStringAsFixed(2);
                            contSalaryHourValue.text =
                                (double.parse(contSalaryMonthValue.text) / (30 * double.parse(contTimeTotalWorkHour.text))).toStringAsFixed(2);
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contSalaryDayValue,
                        padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                        Lable: 'قيمة اليوم',
                        TextType: const TextInputType.numberWithOptions(decimal: true),
                        OnChanged: (val) {
                          // if (contTimeTotalWorkHour.text.isNotEmpty) {
                          contSalaryMonthValue.text = (double.parse(val!) * 30).toStringAsFixed(2);
                          contSalaryWeekValue.text = (double.parse(contSalaryMonthValue.text) / 4).toStringAsFixed(2);
                          contSalaryHourValue.text =
                              (double.parse(contSalaryMonthValue.text) / (30 * double.parse(contTimeTotalWorkHour.text))).toStringAsFixed(2);
                          // }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contSalaryHourValue,
                        padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                        Lable: 'قيمة الساعة',
                        TextType: const TextInputType.numberWithOptions(decimal: true),
                        OnChanged: (val) {
                          // if (contTimeTotalWorkHour.text.isNotEmpty) {
                          contSalaryMonthValue.text = (double.parse(val!) * (30 * double.parse(contTimeTotalWorkHour.text))).toStringAsFixed(2);
                          contSalaryWeekValue.text = (double.parse(contSalaryMonthValue.text) / 4).toStringAsFixed(2);
                          contSalaryDayValue.text = (double.parse(contSalaryMonthValue.text) / 30).toStringAsFixed(2);
                          // }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 3,
            child: Column(
              children: [
                ctr_TextHeaderPage(
                  text: 'تارجت المبيعات',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contMonthlyTarget,
                        padding: const EdgeInsets.only(top: 5, right: 5, bottom: 0, left: 5),
                        Lable: 'التارجت الشهري',
                        TextType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contMonthlyCommissionExecute,
                        padding: const EdgeInsets.only(top: 5, right: 0, bottom: 0, left: 5),
                        Lable: '% عمولة التحقيق',
                        TextType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contMonthlyCommissionNotExecute,
                        padding: const EdgeInsets.only(top: 5, right: 0, bottom: 0, left: 5),
                        Lable: '% خصم التحقيق',
                        TextType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contDailyTarget,
                        padding: const EdgeInsets.only(top: 5, right: 5, bottom: 10, left: 5),
                        Lable: 'التارجت اليومى',
                        TextType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contDailyCommissionExecute,
                        padding: const EdgeInsets.only(top: 5, right: 0, bottom: 10, left: 5),
                        Lable: '% عمولة التحقيق',
                        TextType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contDailyCommissionNotExecute,
                        padding: const EdgeInsets.only(top: 5, right: 0, bottom: 10, left: 5),
                        Lable: '% خصم التحقيق',
                        TextType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 3,
            child: Column(
              children: [
                // SizedBox(height: 5),
                ctr_TextHeaderPage(
                  text: 'العمولة على فئة سعر 1',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contCommissionSales1,
                        padding: const EdgeInsets.only(top: 5, right: 5, bottom: 10, left: 5),
                        Lable: 'عمولة البيع1',
                        TextType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contCommissionSalesReturned1,
                        padding: const EdgeInsets.only(top: 5, right: 0, bottom: 10, left: 5),
                        Lable: 'خصم عمولة المرتجع1',
                        TextType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 3,
            child: Column(
              children: [
                // SizedBox(height: 5),
                ctr_TextHeaderPage(
                  text: 'العمولة على فئة سعر 2',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contCommissionSales2,
                        padding: const EdgeInsets.only(top: 5, right: 5, bottom: 10, left: 5),
                        Lable: 'عمولة البيع2',
                        TextType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contCommissionSalesReturned2,
                        padding: const EdgeInsets.only(top: 5, right: 0, bottom: 10, left: 5),
                        Lable: 'خصم عمولة المرتجع2',
                        TextType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 3,
            child: Column(
              children: [
                // SizedBox(height: 5),
                ctr_TextHeaderPage(
                  text: 'العمولة على فئة سعر 3',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contCommissionSales3,
                        padding: const EdgeInsets.only(top: 5, right: 5, bottom: 10, left: 5),
                        Lable: 'عمولة البيع3',
                        TextType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contCommissionSalesReturned3,
                        padding: const EdgeInsets.only(top: 5, right: 0, bottom: 10, left: 5),
                        Lable: 'خصم عمولة المرتجع3',
                        TextType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 3,
            child: Column(
              children: [
                // SizedBox(height: 5),
                ctr_TextHeaderPage(
                  text: 'العمولة على فئة سعر 4',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contCommissionSales4,
                        padding: const EdgeInsets.only(top: 5, right: 5, bottom: 10, left: 5),
                        Lable: 'عمولة البيع4',
                        TextType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contCommissionSalesReturned4,
                        padding: const EdgeInsets.only(top: 5, right: 0, bottom: 10, left: 5),
                        Lable: 'خصم عمولة المرتجع4',
                        TextType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 3,
            child: Column(
              children: [
                // SizedBox(height: 5),
                ctr_TextHeaderPage(
                  text: 'العمولة على فئة سعر 5',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contCommissionSales5,
                        padding: const EdgeInsets.only(top: 5, right: 5, bottom: 10, left: 5),
                        Lable: 'عمولة البيع5',
                        TextType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contCommissionSalesReturned5,
                        padding: const EdgeInsets.only(top: 5, right: 0, bottom: 10, left: 5),
                        Lable: 'خصم عمولة المرتجع5',
                        TextType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget BuildRelativesPersonsData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            color: Colors.white,
            elevation: 3,
            child: Column(
              children: [
                // SizedBox(height: 5),
                ctr_TextHeaderPage(
                  text: 'القريب الأول',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                  // padding: const EdgeInsets.only(top: 10, right: 5, bottom: 0,left: 5),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contRelativeName1,
                        padding: const EdgeInsets.only(top: 5, right: 5, bottom: 0, left: 5),
                        Lable: 'إســــم القريب',
                        TextType: TextInputType.text,
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      child: ctr_TextFormField(
                        Controller: contRelativeType1,
                        padding: const EdgeInsets.only(top: 5, right: 0, bottom: 0, left: 5),
                        Lable: 'صلة القرابة',
                        TextType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                ctr_ContactsNumber(
                  Controller: contRelativeMobile1,
                  padding: const EdgeInsets.only(top: 5, right: 5, bottom: 8, left: 5),
                  Lable: 'موبيل القريب',
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 3,
            child: Column(
              children: [
                // SizedBox(height: 5),
                ctr_TextHeaderPage(
                  text: 'القريب الثاني',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                  // padding: const EdgeInsets.only(top: 10, right: 5, bottom: 0,left: 5),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contRelativeName2,
                        padding: const EdgeInsets.only(top: 5, right: 5, bottom: 0, left: 5),
                        Lable: 'إســــم القريب',
                        TextType: TextInputType.text,
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      child: ctr_TextFormField(
                        Controller: contRelativeType2,
                        padding: const EdgeInsets.only(top: 5, right: 0, bottom: 0, left: 5),
                        Lable: 'صلة القرابة',
                        TextType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                ctr_ContactsNumber(
                  Controller: contRelativeMobile2,
                  padding: const EdgeInsets.only(top: 5, right: 5, bottom: 8, left: 5),
                  Lable: 'موبيل القريب',
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 3,
            child: Column(
              children: [
                // SizedBox(height: 5),
                ctr_TextHeaderPage(
                  text: 'القريب الثالث',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                  // padding: const EdgeInsets.only(top: 10, right: 5, bottom: 0,left: 5),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contRelativeName3,
                        padding: const EdgeInsets.only(top: 5, right: 5, bottom: 0, left: 5),
                        Lable: 'إســــم القريب',
                        TextType: TextInputType.text,
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      child: ctr_TextFormField(
                        Controller: contRelativeType3,
                        padding: const EdgeInsets.only(top: 5, right: 0, bottom: 0, left: 5),
                        Lable: 'صلة القرابة',
                        TextType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                ctr_ContactsNumber(
                  Controller: contRelativeMobile3,
                  padding: const EdgeInsets.only(top: 5, right: 5, bottom: 8, left: 5),
                  Lable: 'موبيل القريب',
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 3,
            child: Column(
              children: [
                // SizedBox(height: 5),
                ctr_TextHeaderPage(
                  text: 'القريب الرابع',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                  // padding: const EdgeInsets.only(top: 10, right: 5, bottom: 0,left: 5),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ctr_TextFormField(
                        Controller: contRelativeName4,
                        padding: const EdgeInsets.only(top: 5, right: 5, bottom: 0, left: 5),
                        Lable: 'إســــم القريب',
                        TextType: TextInputType.text,
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      child: ctr_TextFormField(
                        Controller: contRelativeType4,
                        padding: const EdgeInsets.only(top: 5, right: 0, bottom: 0, left: 5),
                        Lable: 'صلة القرابة',
                        TextType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                ctr_ContactsNumber(
                  Controller: contRelativeMobile4,
                  padding: const EdgeInsets.only(top: 5, right: 5, bottom: 8, left: 5),
                  Lable: 'موبيل القريب',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  var frmKey = GlobalKey<FormState>();

//************************** البيانات الشخصية
  TextEditingController contCode = TextEditingController();
  TextEditingController contName = TextEditingController();
  TextEditingController contMobile = TextEditingController();
  TextEditingController contPhone = TextEditingController();
  TextEditingController contAddress = TextEditingController();
  TextEditingController contNationalID = TextEditingController();
  int? jobID;
  bool chkIsActive = true;
  String imageName = '';
  String imagePath = '';
  TextEditingController contAge = TextEditingController();
  TextEditingController contBirthDate = TextEditingController();
  int? maritalStatusID;
  TextEditingController contChildrenCount = TextEditingController();
  int? religionsID;
  int? genderID;
  int? militaryStatusID;
  TextEditingController contQualification = TextEditingController();

//************************** البيانات الوظيفية
  int? branchID;
  int? departmentID;
  TextEditingController contDateHiring = TextEditingController();
  TextEditingController contTimeWorkFrom = TextEditingController();
  TextEditingController contTimeWorkTo = TextEditingController();
  TextEditingController contTimeTotalWorkHour = TextEditingController();
  TextEditingController contMonthlyVacationDays = TextEditingController();
  TextEditingController contExpiryDateJob = TextEditingController();
  TextEditingController contLeavingReson = TextEditingController();

//************************** بيانات الراتب
  TextEditingController contSalaryMonthValue = TextEditingController();
  TextEditingController contSalaryWeekValue = TextEditingController();
  TextEditingController contSalaryDayValue = TextEditingController();
  TextEditingController contSalaryHourValue = TextEditingController();

  TextEditingController contMonthlyTarget = TextEditingController();
  TextEditingController contMonthlyCommissionExecute = TextEditingController();
  TextEditingController contMonthlyCommissionNotExecute = TextEditingController();
  TextEditingController contDailyTarget = TextEditingController();
  TextEditingController contDailyCommissionExecute = TextEditingController();
  TextEditingController contDailyCommissionNotExecute = TextEditingController();

  TextEditingController contCommissionSales1 = TextEditingController();
  TextEditingController contCommissionSalesReturned1 = TextEditingController();

  TextEditingController contCommissionSales2 = TextEditingController();
  TextEditingController contCommissionSalesReturned2 = TextEditingController();

  TextEditingController contCommissionSales3 = TextEditingController();
  TextEditingController contCommissionSalesReturned3 = TextEditingController();

  TextEditingController contCommissionSales4 = TextEditingController();
  TextEditingController contCommissionSalesReturned4 = TextEditingController();

  TextEditingController contCommissionSales5 = TextEditingController();
  TextEditingController contCommissionSalesReturned5 = TextEditingController();

  //************************** البيانات الوظيفية
  TextEditingController contRelativeName1 = TextEditingController();
  TextEditingController contRelativeMobile1 = TextEditingController();
  TextEditingController contRelativeType1 = TextEditingController();

  TextEditingController contRelativeName2 = TextEditingController();
  TextEditingController contRelativeMobile2 = TextEditingController();
  TextEditingController contRelativeType2 = TextEditingController();

  TextEditingController contRelativeName3 = TextEditingController();
  TextEditingController contRelativeMobile3 = TextEditingController();
  TextEditingController contRelativeType3 = TextEditingController();

  TextEditingController contRelativeName4 = TextEditingController();
  TextEditingController contRelativeMobile4 = TextEditingController();
  TextEditingController contRelativeType4 = TextEditingController();

  //*************************************************************
  int maxID = -1;
  TimeOfDay? timeWorkFrom;
  TimeOfDay? timeWorkTo;

  @override
  void initState() {
    super.initState();
    if (widget.frmMode == en_FormMode.NewMode)
      NewMode();
    else if (widget.frmMode == en_FormMode.EditMode) {
      EditMode();
    }
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
    bllDealing_Employees.getMax_firestore(enTable_Dealing_Employees.Code).then((val) {
      contCode.text = val.toString();
    }).toString();

    // branchID = company_bloc.instance.LstBranchesAsDataSource.isNotEmpty ? company_bloc.instance.LstBranchesAsDataSource.first.valueMember : null;
    // jobID = job_bloc.instance.LstJobsAsDataSource.isNotEmpty ? job_bloc.instance.LstJobsAsDataSource.first.valueMember : null;
    chkIsActive = true;
    // reset obj image عشان لما بفتح صنف جديد بيجيب الصورة القديمة
    employee_bloc.instance.EmployeeImageTemp.imageName = '';
    employee_bloc.instance.EmployeeImageTemp.imagepath = '';
    employee_bloc.instance.EmployeeImageTemp.image = null;
    employee_bloc.instance.EmployeeImageTemp.imageFile = null;
    employee_bloc.instance.EmployeeImageTemp.imageURL = '';
  }

  void EditMode() {
    branchID = widget.itemEmployee.IDBranch;
    chkIsActive = widget.itemEmployee.IsActive!;
    contCode.text = widget.itemEmployee.Code.toString();
    contName.text = widget.itemEmployee.Name!;
    contPhone.text = widget.itemEmployee.Phone!;
    contMobile.text = widget.itemEmployee.Mobile!;
    contAddress.text = widget.itemEmployee.Address!;
    contNationalID.text = widget.itemEmployee.NationalID!;
    contBirthDate.text = widget.itemEmployee.BirthDate!;
    contAge.text = widget.itemEmployee.Age != null ? widget.itemEmployee.Age!.toString() : '';
    maritalStatusID = widget.itemEmployee.IDMaritalStatus;
    contChildrenCount.text = widget.itemEmployee.ChildrenCount != null ? widget.itemEmployee.ChildrenCount.toString() : '0';
    religionsID = widget.itemEmployee.IDReligions ?? null;
    genderID = widget.itemEmployee.IDGender ?? null;
    militaryStatusID = widget.itemEmployee.IDMilitaryStatus ?? null;
    contQualification.text = widget.itemEmployee.Qualification!;
    jobID = widget.itemEmployee.IDJob ?? null;
    departmentID = widget.itemEmployee.IDDepartment ?? null;
    contDateHiring.text = widget.itemEmployee.DateHiring!;

    contTimeWorkFrom.text = widget.itemEmployee.TimeWorkFrom!;
    timeWorkFrom = sharedFunctions_Dates.convertTimeStringToTimeOfDay(widget.itemEmployee.TimeWorkFrom!);
    contTimeWorkTo.text = widget.itemEmployee.TimeWorkTo!;
    timeWorkTo = sharedFunctions_Dates.convertTimeStringToTimeOfDay(widget.itemEmployee.TimeWorkTo!);
    calcTimeTotalWorkHour();

    contTimeTotalWorkHour.text = widget.itemEmployee.TimeTotalWorkHour != null ? widget.itemEmployee.TimeTotalWorkHour.toString() : '0';
    contMonthlyVacationDays.text = widget.itemEmployee.MonthlyVacationDays != null ? widget.itemEmployee.MonthlyVacationDays.toString() : '0';
    contExpiryDateJob.text = widget.itemEmployee.ExpiryDateJob!;
    contLeavingReson.text = widget.itemEmployee.LeavingReson!;
    contSalaryMonthValue.text = widget.itemEmployee.SalaryMonthValue != null ? widget.itemEmployee.SalaryMonthValue.toString() : '0';
    contSalaryWeekValue.text = widget.itemEmployee.SalaryWeekValue != null ? widget.itemEmployee.SalaryWeekValue.toString() : '0';
    contSalaryDayValue.text = widget.itemEmployee.SalaryDayValue != null ? widget.itemEmployee.SalaryDayValue.toString() : '0';
    contSalaryHourValue.text = widget.itemEmployee.SalaryHourValue != null ? widget.itemEmployee.SalaryHourValue.toString() : '0';
    contMonthlyTarget.text = widget.itemEmployee.MonthlyTarget != null ? widget.itemEmployee.MonthlyTarget.toString() : '0';
    contMonthlyCommissionExecute.text =
        widget.itemEmployee.MonthlyCommissionExecute != null ? widget.itemEmployee.MonthlyCommissionExecute.toString() : '0';
    contMonthlyCommissionNotExecute.text =
        widget.itemEmployee.MonthlyCommissionNotExecute != null ? widget.itemEmployee.MonthlyCommissionNotExecute.toString() : '0';
    contDailyTarget.text = widget.itemEmployee.DailyTarget != null ? widget.itemEmployee.DailyTarget.toString() : '0';
    contDailyCommissionExecute.text =
        widget.itemEmployee.DailyCommissionExecute != null ? widget.itemEmployee.DailyCommissionExecute.toString() : '0';
    contDailyCommissionNotExecute.text =
        widget.itemEmployee.DailyCommissionNotExecute != null ? widget.itemEmployee.DailyCommissionNotExecute.toString() : '0';
    contCommissionSales1.text = widget.itemEmployee.CommissionSales1 != null ? widget.itemEmployee.CommissionSales1.toString() : '0';
    contCommissionSalesReturned1.text =
        widget.itemEmployee.CommissionSalesReturned1 != null ? widget.itemEmployee.CommissionSalesReturned1.toString() : '0';
    contCommissionSales2.text = widget.itemEmployee.CommissionSales2 != null ? widget.itemEmployee.CommissionSales2.toString() : '0';
    contCommissionSalesReturned2.text =
        widget.itemEmployee.CommissionSalesReturned2 != null ? widget.itemEmployee.CommissionSalesReturned2.toString() : '0';
    contCommissionSales3.text = widget.itemEmployee.CommissionSales3 != null ? widget.itemEmployee.CommissionSales3.toString() : '0';
    contCommissionSalesReturned3.text =
        widget.itemEmployee.CommissionSalesReturned3 != null ? widget.itemEmployee.CommissionSalesReturned3.toString() : '0';
    contCommissionSales4.text = widget.itemEmployee.CommissionSales4 != null ? widget.itemEmployee.CommissionSales4.toString() : '0';
    contCommissionSalesReturned4.text =
        widget.itemEmployee.CommissionSalesReturned4 != null ? widget.itemEmployee.CommissionSalesReturned4.toString() : '0';
    contCommissionSales5.text = widget.itemEmployee.CommissionSales5 != null ? widget.itemEmployee.CommissionSales5.toString() : '0';
    contCommissionSalesReturned5.text =
        widget.itemEmployee.CommissionSalesReturned5 != null ? widget.itemEmployee.CommissionSalesReturned5.toString() : '0';

    contRelativeName1.text = widget.itemEmployee.RelativeName1!;
    contRelativeMobile1.text = widget.itemEmployee.RelativeMobile1!;
    contRelativeType1.text = widget.itemEmployee.RelativeType1!;

    contRelativeName2.text = widget.itemEmployee.RelativeName2!;
    contRelativeMobile2.text = widget.itemEmployee.RelativeMobile2!;
    contRelativeType2.text = widget.itemEmployee.RelativeType2!;

    contRelativeName3.text = widget.itemEmployee.RelativeName3!;
    contRelativeMobile3.text = widget.itemEmployee.RelativeMobile3!;
    contRelativeType3.text = widget.itemEmployee.RelativeType3!;

    contRelativeName4.text = widget.itemEmployee.RelativeName4!;
    contRelativeMobile4.text = widget.itemEmployee.RelativeMobile4!;
    contRelativeType4.text = widget.itemEmployee.RelativeType4!;

    // employee_bloc.instance.EmployeeImageTemp.imageName = widget.itemEmployee.ImageName!
    // imageUrlUpload = widget.itemEmployee.ImageURL!
  }

  void loadImageEmployee() {
    if (widget.itemEmployee.ImageURL != null && widget.itemEmployee.ImageURL!.isNotEmpty) {
      employee_bloc.instance.EmployeeImageTemp.image = NetworkImage(widget.itemEmployee.ImageURL!);
    } else if (employee_bloc.instance.EmployeeImageTemp.image != null) {
    } else {
      // بيرجع الصورة الافتراضية
      employee_bloc.instance.EmployeeImageTemp.image = manage_Images.defaultImage;
    }
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      // Uplade Image before save item
      String imageUrlUpload = '';
      if (employee_bloc.instance.EmployeeImageTemp.image == null) {
        imageUrlUpload = '';
      } else if (employee_bloc.instance.EmployeeImageTemp.imageName != null && employee_bloc.instance.EmployeeImageTemp.imageFile != null) {
        await bllDealing_Employees
            .storage_UploadFile(employee_bloc.instance.EmployeeImageTemp.imageName!, employee_bloc.instance.EmployeeImageTemp.imageFile!)
            .then((img) {
          imageUrlUpload = img;
        });
      }

      //********************************************************************
      if (widget.frmMode == en_FormMode.NewMode) {
        maxID = await bllDealing_Employees.getMaxID_firestore();
      } else if (widget.frmMode == en_FormMode.EditMode) {
        maxID = widget.itemEmployee.ID!;
      }

      widget.itemEmployee.ID = maxID;
      widget.itemEmployee.IDBranch = branchID;
      widget.itemEmployee.Code = int.tryParse(contCode.text);
      widget.itemEmployee.Name = contName.text;
      widget.itemEmployee.IsActive = chkIsActive;
      widget.itemEmployee.Phone = contPhone.text;
      widget.itemEmployee.Mobile = contMobile.text;
      widget.itemEmployee.Address = contAddress.text;
      widget.itemEmployee.NationalID = contNationalID.text;
      widget.itemEmployee.BirthDate = contBirthDate.text;
      widget.itemEmployee.Age = contAge.text.isEmpty ? 0 : double.tryParse(contAge.text);
      widget.itemEmployee.IDMaritalStatus = maritalStatusID;
      widget.itemEmployee.ChildrenCount = contChildrenCount.text.isEmpty ? 0 : int.tryParse(contChildrenCount.text);
      widget.itemEmployee.IDReligions = religionsID;
      widget.itemEmployee.IDGender = genderID;
      widget.itemEmployee.IDMilitaryStatus = militaryStatusID;
      widget.itemEmployee.Qualification = contQualification.text;
      widget.itemEmployee.IDJob = jobID;
      widget.itemEmployee.IDDepartment = departmentID;
      widget.itemEmployee.DateHiring = contDateHiring.text;
      widget.itemEmployee.TimeWorkFrom = contTimeWorkFrom.text;
      widget.itemEmployee.TimeWorkTo = contTimeWorkTo.text;
      widget.itemEmployee.TimeTotalWorkHour =
          contTimeTotalWorkHour.text.isEmpty ? 0 : double.tryParse(contTimeTotalWorkHour.text.replaceAll(':', '.'));
      widget.itemEmployee.MonthlyVacationDays = contMonthlyVacationDays.text.isEmpty ? 0 : int.tryParse(contMonthlyVacationDays.text);
      widget.itemEmployee.ExpiryDateJob = contExpiryDateJob.text;
      widget.itemEmployee.LeavingReson = contLeavingReson.text;
      widget.itemEmployee.SalaryMonthValue = contSalaryMonthValue.text.isEmpty ? 0 : double.tryParse(contSalaryMonthValue.text);
      widget.itemEmployee.SalaryWeekValue = contSalaryWeekValue.text.isEmpty ? 0 : double.tryParse(contSalaryWeekValue.text);
      widget.itemEmployee.SalaryDayValue = contSalaryDayValue.text.isEmpty ? 0 : double.tryParse(contSalaryDayValue.text);
      widget.itemEmployee.SalaryHourValue = contSalaryHourValue.text.isEmpty ? 0 : double.tryParse(contSalaryHourValue.text);
      widget.itemEmployee.MonthlyTarget = contMonthlyTarget.text.isEmpty ? 0 : double.tryParse(contMonthlyTarget.text);
      widget.itemEmployee.MonthlyCommissionExecute =
          contMonthlyCommissionExecute.text.isEmpty ? 0 : double.tryParse(contMonthlyCommissionExecute.text);
      widget.itemEmployee.MonthlyCommissionNotExecute =
          contMonthlyCommissionNotExecute.text.isEmpty ? 0 : double.tryParse(contMonthlyCommissionNotExecute.text);
      widget.itemEmployee.DailyTarget = contDailyTarget.text.isEmpty ? 0 : double.tryParse(contDailyTarget.text);
      widget.itemEmployee.DailyCommissionExecute = contDailyCommissionExecute.text.isEmpty ? 0 : double.tryParse(contDailyCommissionExecute.text);
      widget.itemEmployee.DailyCommissionNotExecute =
          contDailyCommissionNotExecute.text.isEmpty ? 0 : double.tryParse(contDailyCommissionNotExecute.text);
      widget.itemEmployee.CommissionSales1 = contCommissionSales1.text.isEmpty ? 0 : double.tryParse(contCommissionSales1.text);
      widget.itemEmployee.CommissionSalesReturned1 =
          contCommissionSalesReturned1.text.isEmpty ? 0 : double.tryParse(contCommissionSalesReturned1.text);
      widget.itemEmployee.CommissionSales2 = contCommissionSales2.text.isEmpty ? 0 : double.tryParse(contCommissionSales2.text);
      widget.itemEmployee.CommissionSalesReturned2 =
          contCommissionSalesReturned2.text.isEmpty ? 0 : double.tryParse(contCommissionSalesReturned2.text);
      widget.itemEmployee.CommissionSales3 = contCommissionSales3.text.isEmpty ? 0 : double.tryParse(contCommissionSales3.text);
      widget.itemEmployee.CommissionSalesReturned3 =
          contCommissionSalesReturned3.text.isEmpty ? 0 : double.tryParse(contCommissionSalesReturned3.text);
      widget.itemEmployee.CommissionSales4 = contCommissionSales4.text.isEmpty ? 0 : double.tryParse(contCommissionSales4.text);
      widget.itemEmployee.CommissionSalesReturned4 =
          contCommissionSalesReturned4.text.isEmpty ? 0 : double.tryParse(contCommissionSalesReturned4.text);
      widget.itemEmployee.CommissionSales5 = contCommissionSales5.text.isEmpty ? 0 : double.tryParse(contCommissionSales5.text);
      widget.itemEmployee.CommissionSalesReturned5 =
          contCommissionSalesReturned5.text.isEmpty ? 0 : double.tryParse(contCommissionSalesReturned5.text);
      widget.itemEmployee.RelativeName1 = contRelativeName1.text;
      widget.itemEmployee.RelativeMobile1 = contRelativeName1.text;
      widget.itemEmployee.RelativeType1 = contRelativeType1.text;
      widget.itemEmployee.RelativeName2 = contRelativeName2.text;
      widget.itemEmployee.RelativeMobile2 = contRelativeName2.text;
      widget.itemEmployee.RelativeType2 = contRelativeType2.text;
      widget.itemEmployee.RelativeName3 = contRelativeName3.text;
      widget.itemEmployee.RelativeMobile3 = contRelativeName3.text;
      widget.itemEmployee.RelativeType3 = contRelativeType3.text;
      widget.itemEmployee.RelativeName4 = contRelativeName4.text;
      widget.itemEmployee.RelativeMobile4 = contRelativeName4.text;
      widget.itemEmployee.RelativeType4 = contRelativeType4.text;
      widget.itemEmployee.ImageName = employee_bloc.instance.EmployeeImageTemp.imageName;
      widget.itemEmployee.ImageURL = imageUrlUpload;

      await bllDealing_Employees.fire_SetItem(maxID.toString(), widget.itemEmployee);
      Navigator.pop(context, true);
    }
  }

  // void saveNewEmployee(String imageUrlUpload) async {
  //   maxID = await bllDealing_Employees.getMaxID_firestore();
  //   widget.itemEmployee = await bllDealing_Employees(
  //     ID: maxID,
  //     IDBranch: branchID,
  //     Code: int.tryParse(contCode.text),
  //     Name: contName.text,
  //     IsActive: chkIsActive,
  //     Phone: contPhone.text ?? '',
  //     Mobile: contMobile.text ?? '',
  //     Address: contAddress.text ?? '',
  //     NationalID: contNationalID.text ?? '',
  //     BirthDate: contBirthDate.text ?? '',
  //     Age: contAge.text.isEmpty ? 0 : double.tryParse(contAge.text),
  //     IDMaritalStatus: maritalStatusID,
  //     ChildrenCount: contChildrenCount.text.isEmpty ? 0 : int.tryParse(contChildrenCount.text),
  //     IDReligions: religionsID,
  //     IDGender: genderID,
  //     IDMilitaryStatus: militaryStatusID,
  //     Qualification: contQualification.text ?? '',
  //     IDJob: jobID,
  //     IDDepartment: departmentID,
  //     DateHiring: contDateHiring.text ?? '',
  //     TimeWorkFrom: contTimeWorkFrom.text ?? '',
  //     TimeWorkTo: contTimeWorkTo.text ?? '',
  //     TimeTotalWorkHour: contTimeTotalWorkHour.text.isEmpty ? 0 : double.tryParse(contTimeTotalWorkHour.text),
  //     MonthlyVacationDays: contMonthlyVacationDays.text.isEmpty ? 0 : int.tryParse(contMonthlyVacationDays.text),
  //     ExpiryDateJob: contExpiryDateJob.text ?? '',
  //     LeavingReson: contLeavingReson.text ?? '',
  //     SalaryMonthValue: contSalaryMonthValue.text.isEmpty ? 0 : double.tryParse(contSalaryMonthValue.text),
  //     SalaryWeekValue: contSalaryWeekValue.text.isEmpty ? 0 : double.tryParse(contSalaryWeekValue.text),
  //     SalaryDayValue: contSalaryDayValue.text.isEmpty ? 0 : double.tryParse(contSalaryDayValue.text),
  //     SalaryHourValue: contSalaryHourValue.text.isEmpty ? 0 : double.tryParse(contSalaryHourValue.text),
  //     MonthlyTarget: contMonthlyTarget.text.isEmpty ? 0 : double.tryParse(contMonthlyTarget.text),
  //     MonthlyCommissionExecute: contMonthlyCommissionExecute.text.isEmpty ? 0 : double.tryParse(contMonthlyCommissionExecute.text),
  //     MonthlyCommissionNotExecute: contMonthlyCommissionNotExecute.text.isEmpty ? 0 : double.tryParse(contMonthlyCommissionNotExecute.text),
  //     DailyTarget: contDailyTarget.text.isEmpty ? 0 : double.tryParse(contDailyTarget.text),
  //     DailyCommissionExecute: contDailyCommissionExecute.text.isEmpty ? 0 : double.tryParse(contDailyCommissionExecute.text),
  //     DailyCommissionNotExecute: contDailyCommissionNotExecute.text.isEmpty ? 0 : double.tryParse(contDailyCommissionNotExecute.text),
  //     CommissionSales1: contCommissionSales1.text.isEmpty ? 0 : double.tryParse(contCommissionSales1.text),
  //     CommissionSalesReturned1: contCommissionSalesReturned1.text.isEmpty ? 0 : double.tryParse(contCommissionSalesReturned1.text),
  //     CommissionSales2: contCommissionSales2.text.isEmpty ? 0 : double.tryParse(contCommissionSales2.text),
  //     CommissionSalesReturned2: contCommissionSalesReturned2.text.isEmpty ? 0 : double.tryParse(contCommissionSalesReturned2.text),
  //     CommissionSales3: contCommissionSales3.text.isEmpty ? 0 : double.tryParse(contCommissionSales3.text),
  //     CommissionSalesReturned3: contCommissionSalesReturned3.text.isEmpty ? 0 : double.tryParse(contCommissionSalesReturned3.text),
  //     CommissionSales4: contCommissionSales4.text.isEmpty ? 0 : double.tryParse(contCommissionSales4.text),
  //     CommissionSalesReturned4: contCommissionSalesReturned4.text.isEmpty ? 0 : double.tryParse(contCommissionSalesReturned4.text),
  //     CommissionSales5: contCommissionSales5.text.isEmpty ? 0 : double.tryParse(contCommissionSales5.text),
  //     CommissionSalesReturned5: contCommissionSalesReturned5.text.isEmpty ? 0 : double.tryParse(contCommissionSalesReturned5.text),
  //     RelativeName1: contRelativeName1.text ?? '',
  //     RelativeMobile1: contRelativeName1.text ?? '',
  //     RelativeType1: contRelativeType1.text ?? '',
  //     RelativeName2: contRelativeName2.text ?? '',
  //     RelativeMobile2: contRelativeName2.text ?? '',
  //     RelativeType2: contRelativeType2.text ?? '',
  //     RelativeName3: contRelativeName3.text ?? '',
  //     RelativeMobile3: contRelativeName3.text ?? '',
  //     RelativeType3: contRelativeType3.text ?? '',
  //     RelativeName4: contRelativeName4.text ?? '',
  //     RelativeMobile4: contRelativeName4.text ?? '',
  //     RelativeType4: contRelativeType4.text ?? '',
  //     ImageName: employee_bloc.instance.EmployeeImageTemp.imageName ?? '',
  //     ImageURL: imageUrlUpload ?? '',
  //   );
  // }
  //
  // void saveEditEmployee(String imageUrlUpload) async {
  //   maxID = widget.itemEmployee.ID!;
  //   widget.itemEmployee.IDBranch = branchID;
  //   widget.itemEmployee.Code = int.tryParse(contCode.text);
  //   widget.itemEmployee.Name = contName.text;
  //   widget.itemEmployee.IsActive = chkIsActive;
  //   widget.itemEmployee.Phone = contPhone.text;
  //   widget.itemEmployee.Mobile = contMobile.text;
  //   widget.itemEmployee.Address = contAddress.text;
  //   widget.itemEmployee.NationalID = contNationalID.text;
  //   widget.itemEmployee.BirthDate = contBirthDate.text;
  //   widget.itemEmployee.Age = contAge.text.isEmpty ? 0 : double.tryParse(contAge.text);
  //   widget.itemEmployee.IDMaritalStatus = maritalStatusID;
  //   widget.itemEmployee.ChildrenCount = contChildrenCount.text.isEmpty ? 0 : int.tryParse(contChildrenCount.text);
  //   widget.itemEmployee.IDReligions = religionsID;
  //   widget.itemEmployee.IDGender = genderID;
  //   widget.itemEmployee.IDMilitaryStatus = militaryStatusID;
  //   widget.itemEmployee.Qualification = contQualification.text;
  //   widget.itemEmployee.IDJob = jobID;
  //   widget.itemEmployee.IDDepartment = departmentID;
  //   widget.itemEmployee.DateHiring = contDateHiring.text;
  //   widget.itemEmployee.TimeWorkFrom = contTimeWorkFrom.text;
  //   widget.itemEmployee.TimeWorkTo = contTimeWorkTo.text;
  //   widget.itemEmployee.TimeTotalWorkHour = contTimeTotalWorkHour.text.isEmpty ? 0 : double.tryParse(contTimeTotalWorkHour.text);
  //   widget.itemEmployee.MonthlyVacationDays = contMonthlyVacationDays.text.isEmpty ? 0 : int.tryParse(contMonthlyVacationDays.text);
  //   widget.itemEmployee.ExpiryDateJob = contExpiryDateJob.text;
  //   widget.itemEmployee.LeavingReson = contLeavingReson.text;
  //   widget.itemEmployee.SalaryMonthValue = contSalaryMonthValue.text.isEmpty ? 0 : double.tryParse(contSalaryMonthValue.text);
  //   widget.itemEmployee.SalaryWeekValue = contSalaryWeekValue.text.isEmpty ? 0 : double.tryParse(contSalaryWeekValue.text);
  //   widget.itemEmployee.SalaryDayValue = contSalaryDayValue.text.isEmpty ? 0 : double.tryParse(contSalaryDayValue.text);
  //   widget.itemEmployee.SalaryHourValue = contSalaryHourValue.text.isEmpty ? 0 : double.tryParse(contSalaryHourValue.text);
  //   widget.itemEmployee.MonthlyTarget = contMonthlyTarget.text.isEmpty ? 0 : double.tryParse(contMonthlyTarget.text);
  //   widget.itemEmployee.MonthlyCommissionExecute = contMonthlyCommissionExecute.text.isEmpty ? 0 : double.tryParse(contMonthlyCommissionExecute.text);
  //   widget.itemEmployee.MonthlyCommissionNotExecute =
  //       contMonthlyCommissionNotExecute.text.isEmpty ? 0 : double.tryParse(contMonthlyCommissionNotExecute.text);
  //   widget.itemEmployee.DailyTarget = contDailyTarget.text.isEmpty ? 0 : double.tryParse(contDailyTarget.text);
  //   widget.itemEmployee.DailyCommissionExecute = contDailyCommissionExecute.text.isEmpty ? 0 : double.tryParse(contDailyCommissionExecute.text);
  //   widget.itemEmployee.DailyCommissionNotExecute =
  //       contDailyCommissionNotExecute.text.isEmpty ? 0 : double.tryParse(contDailyCommissionNotExecute.text);
  //   widget.itemEmployee.CommissionSales1 = contCommissionSales1.text.isEmpty ? 0 : double.tryParse(contCommissionSales1.text);
  //   widget.itemEmployee.CommissionSalesReturned1 = contCommissionSalesReturned1.text.isEmpty ? 0 : double.tryParse(contCommissionSalesReturned1.text);
  //   widget.itemEmployee.CommissionSales2 = contCommissionSales2.text.isEmpty ? 0 : double.tryParse(contCommissionSales2.text);
  //   widget.itemEmployee.CommissionSalesReturned2 = contCommissionSalesReturned2.text.isEmpty ? 0 : double.tryParse(contCommissionSalesReturned2.text);
  //   widget.itemEmployee.CommissionSales3 = contCommissionSales3.text.isEmpty ? 0 : double.tryParse(contCommissionSales3.text);
  //   widget.itemEmployee.CommissionSalesReturned3 = contCommissionSalesReturned3.text.isEmpty ? 0 : double.tryParse(contCommissionSalesReturned3.text);
  //   widget.itemEmployee.CommissionSales4 = contCommissionSales4.text.isEmpty ? 0 : double.tryParse(contCommissionSales4.text);
  //   widget.itemEmployee.CommissionSalesReturned4 = contCommissionSalesReturned4.text.isEmpty ? 0 : double.tryParse(contCommissionSalesReturned4.text);
  //   widget.itemEmployee.CommissionSales5 = contCommissionSales5.text.isEmpty ? 0 : double.tryParse(contCommissionSales5.text);
  //   widget.itemEmployee.CommissionSalesReturned5 = contCommissionSalesReturned5.text.isEmpty ? 0 : double.tryParse(contCommissionSalesReturned5.text);
  //   widget.itemEmployee.RelativeName1 = contRelativeName1.text;
  //   widget.itemEmployee.RelativeMobile1 = contRelativeName1.text;
  //   widget.itemEmployee.RelativeType1 = contRelativeType1.text;
  //   widget.itemEmployee.RelativeName2 = contRelativeName2.text;
  //   widget.itemEmployee.RelativeMobile2 = contRelativeName2.text;
  //   widget.itemEmployee.RelativeType2 = contRelativeType2.text;
  //   widget.itemEmployee.RelativeName3 = contRelativeName3.text;
  //   widget.itemEmployee.RelativeMobile3 = contRelativeName3.text;
  //   widget.itemEmployee.RelativeType3 = contRelativeType3.text;
  //   widget.itemEmployee.RelativeName4 = contRelativeName4.text;
  //   widget.itemEmployee.RelativeMobile4 = contRelativeName4.text;
  //   widget.itemEmployee.RelativeType4 = contRelativeType4.text;
  //   widget.itemEmployee.ImageName = employee_bloc.instance.EmployeeImageTemp.imageName;
  //   widget.itemEmployee.ImageURL = imageUrlUpload;
  // }

  void calcTimeTotalWorkHour() {
    if (timeWorkFrom != null && timeWorkTo != null) {
      DateTime time1 = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, timeWorkFrom!.hour, timeWorkFrom!.minute);
      DateTime time2 = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, timeWorkTo!.hour, timeWorkTo!.minute);
      Duration difference = time2.difference(time1);

      String hour = difference.inHours.toString();
      String minutes = (difference.inMinutes % 60).toString();
      // ترجع القيمة ساعات.دقايق وتتحفظ دبل
      contTimeTotalWorkHour.text = hour + '.' + minutes;
      // ترجع القيمة بنص الساعات وتتحفظ نص
      // contTimeTotalWorkHour.text = sharedFunctions_Dates.formatTimeDuration(difference);
    }
  }
}

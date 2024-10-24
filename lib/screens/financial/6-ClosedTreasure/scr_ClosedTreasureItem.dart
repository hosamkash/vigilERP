import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/bllFirebase/bllFina_ClosedTreasure.dart';
import 'package:vigil_erp/bll/classModel/Fina_ClosedTreasure.dart';
import 'package:vigil_erp/blocManagment/blocDealing/dealing_bloc.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/screens/financial/2-Supplay/scr_SupplayItem.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/sharedFunctions.dart';
import 'package:vigil_erp/shared/shared_controls.dart';
import '../../../bll/bllFirebase/bllDealing_Employees.dart';
import '../../../bll/classModel/Fina_TreasuryMovementFull.dart';
import '../../../blocManagment/blocFixTables/fix_table_bloc.dart';
import '../../../blocManagment/bloc_Financial/financial_bloc.dart';
import '../../../componants/ctr_Date.dart';
import '../../../componants/ctr_SelectEmployee.dart';
import '../../../componants/ctr_TabBar.dart';
import '../../../componants/ctr_Time.dart';
import '../1-Exchange/scr_ExchangeItem.dart';

class scr_ClosedTreasureItem extends StatefulWidget {
  scr_ClosedTreasureItem(this.itemClosedTreasure, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Fina_ClosedTreasure? itemClosedTreasure;
  en_FormMode frmMode;

  @override
  State<scr_ClosedTreasureItem> createState() => _scr_ClosedTreasureItemState();
}

class _scr_ClosedTreasureItemState extends State<scr_ClosedTreasureItem> {
  int selectedID = -1;
  TextEditingController contCode = TextEditingController();
  TextEditingController contDate = TextEditingController();
  TextEditingController contTime = TextEditingController();
  TimeOfDay? timeWorkFrom;
  int? employeeID;
  TextEditingController_Employee contEmployee = TextEditingController_Employee();
  int? branchFromID;
  ValueNotifier<int?>? _branchFromID;
  int? treasurFromID;
  TextEditingController contBalanceTreasurFrom = TextEditingController();
  int? branchToID;
  ValueNotifier<int?>? _branchToID;
  int? treasurToID;
  TextEditingController contBalanceTreasurTo = TextEditingController();
  // TextEditingController contValue = TextEditingController();
  TextEditingController contNote = TextEditingController();
  bool chkIsClosed = false;
  var frmKey = GlobalKey<FormState>();
  TextEditingController contSumExchange = TextEditingController();
  TextEditingController contSumSupplay = TextEditingController();
  TextEditingController contNetValue = TextEditingController();

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
    _branchFromID = ValueNotifier(branchFromID);
    _branchToID = ValueNotifier(branchToID);

    return Form(
      key: frmKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ctr_TextHeaderPage(
              text: 'بيانات تقفيل الخزينة',
              color: checkIsSavedClosed() ? Colors.red[100] : Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            SizedBox(
              height: 535,
              child: Card(
                color: Colors.grey[100],
                child: ctr_TabBar(
                  LstTabBarViewHeaderWidget: [
                    Text('البيانات الأساسية', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text('السندات-الإيصالات', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
                  ],
                  LstTabBarViewWidget: [
                    BuildMasterData(),
                    buildListViewRecipts(context),
                  ],
                ),
              ),
            ),
            summary(),
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

  Widget BuildMasterData() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 5),
          Row(
            children: [
              SizedBox(
                width: 180,
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
              const Text('مغلق', style: TextStyle(fontSize: 17)),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
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
              Expanded(
                child: ctr_Time(
                  text: 'الساعة',
                  dtController: contTime,
                  padding: EdgeInsets.only(right: 5, left: 5),
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
              Expanded(
                child: ctr_DropDowenList(
                  hintLable: 'من فرع',
                  padding: EdgeInsets.only(right: 5, left: 0),
                  lstDataSource: company_bloc.instance.LstBranchesAsDataSource,
                  hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                  itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                  menuMaxHeightValue: 300,
                  showClearIcon: false,
                  selectedValue: branchFromID,
                  OnChanged: (returnID) {
                    _branchFromID!.value = branchFromID = returnID;
                    treasure_bloc.instance.add(getListTreasureAsDataSource_Event(branchID: branchFromID));

                    // reset Employee and populate with New branch
                    contEmployee.selectEmployee = null;
                    contEmployee.text = '';
                    employee_bloc.instance.add(getLstEmployeeAsDataSource_Event());
                    ctr_SelectEmployee.branchID = branchFromID;

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

              SizedBox(
                height: 55,
                width: 175,
                child: BlocBuilder<treasure_bloc, definition_state>(
                  builder: (context, state) {
                    bool isState = state is getListTreasureAsDataSource_State ? true : false;
                    List<DropDowenDataSource> lstTreasures = isState
                        ? state.lstTreasureAsDataSource.where((elm) {
                      return elm.branchID == branchFromID;
                    }).toList()
                        : [];

                    return ctr_DropDowenList(
                      hintLable: 'من خزينة - صندوق',
                      padding: EdgeInsets.only(right: 5, left: 0),
                      lstDataSource: lstTreasures,
                      hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                      itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                      menuMaxHeightValue: 300,
                      showClearIcon: false,
                      selectedValue: treasurFromID =
                      lstTreasures.length > 0 && widget.frmMode == en_FormMode.NewMode ? lstTreasures.first.valueMember : treasurFromID,
                      OnChanged: (returnID) {
                        treasurFromID = returnID;
                        contBalanceTreasurFrom.text = '0';
                        return treasurFromID;
                      },
                      OnValidate: (value) {
                        if (value == null) {
                          return 'لابد من إختيار قيمة';
                        }
                        return null;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          // SizedBox(height: 5),
          // Row(
          //   children: [
          //     SizedBox(
          //       height: 50,
          //       width: 180,
          //       child: BlocBuilder<treasure_bloc, definition_state>(
          //         builder: (context, state) {
          //           bool isState = state is getListTreasureAsDataSource_State ? true : false;
          //           List<DropDowenDataSource> lstTreasures = isState
          //               ? state.lstTreasureAsDataSource.where((elm) {
          //                   return elm.branchID == branchFromID;
          //                 }).toList()
          //               : [];
          //
          //           return ctr_DropDowenList(
          //             hintLable: 'من خزينة - صندوق',
          //             padding: EdgeInsets.only(right: 5, left: 0),
          //             lstDataSource: lstTreasures,
          //             hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
          //             itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
          //             menuMaxHeightValue: 300,
          //             showClearIcon: false,
          //             selectedValue: treasurFromID =
          //                 lstTreasures.length > 0 && widget.frmMode == en_FormMode.NewMode ? lstTreasures.first.valueMember : treasurFromID,
          //             OnChanged: (returnID) {
          //               treasurFromID = returnID;
          //               contBalanceTreasurFrom.text = '0';
          //               return treasurFromID;
          //             },
          //             OnValidate: (value) {
          //               if (value == null) {
          //                 return 'لابد من إختيار قيمة';
          //               }
          //               return null;
          //             },
          //           );
          //         },
          //       ),
          //     ),
          //
          //   ],
          // ),
          SizedBox(height: 5),
          Row(
            children: [
              ctr_SelectEmployee(
                Controller: contEmployee,
                padding: EdgeInsets.only(right: 5, left: 0),
                labelText: 'الموظف',
                isOpenSelectorOnTap: true,
                labelStyle: TextStyle(color: Colors.blue[700]),
                colorBorder: Colors.blue[700],
                onSelectEmployee: (Dealing) {
                  contEmployee.selectEmployee = Dealing;
                  employeeID = Dealing.ID;
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
          Divider(
            color: Colors.red,
            thickness: 2,
            indent: 30,
            endIndent: 30,
            height: 20,
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: ctr_DropDowenList(
                  hintLable: 'إلى فرع',
                  padding: EdgeInsets.only(right: 5, left: 0),
                  lstDataSource: company_bloc.instance.LstBranchesAsDataSource,
                  hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                  itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                  menuMaxHeightValue: 300,
                  showClearIcon: false,
                  selectedValue: branchToID,
                  OnChanged: (returnID) {
                    _branchToID!.value = branchToID = returnID;
                    treasure_bloc.instance.add(getListTreasureAsDataSource_Event(branchID: branchToID));

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

              SizedBox(
                height: 55,
                width: 180,
                child: BlocBuilder<treasure_bloc, definition_state>(
                  builder: (context, state) {
                    bool isState = state is getListTreasureAsDataSource_State ? true : false;
                    List<DropDowenDataSource> lstTreasures = isState
                        ? state.lstTreasureAsDataSource.where((elm) {
                      return elm.branchID == branchToID;
                    }).toList()
                        : [];

                    return ctr_DropDowenList(
                      hintLable: 'إلى خزينة - صندوق',
                      padding: EdgeInsets.only(right: 5, left: 0),
                      lstDataSource: lstTreasures,
                      hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                      itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                      menuMaxHeightValue: 300,
                      showClearIcon: false,
                      selectedValue: treasurToID =
                      lstTreasures.length > 0 && widget.frmMode == en_FormMode.NewMode ? lstTreasures.first.valueMember : treasurToID,
                      OnChanged: (returnID) {
                        treasurToID = returnID;
                        contBalanceTreasurTo.text = '0';
                        return treasurToID;
                      },
                      OnValidate: (value) {
                        if (value == null) {
                          return 'لابد من إختيار قيمة';
                        }
                        return null;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          // SizedBox(height: 5),
          // Row(
          //   children: [
          //
          //     Expanded(
          //       child: ctr_TextFormField(
          //         Controller: contBalanceTreasurTo,
          //         padding: EdgeInsets.only(right: 5, left: 5),
          //         Lable: 'رصيد الخزينة',
          //         TextType: const TextInputType.numberWithOptions(decimal: true),
          //         readOnly: true,
          //         textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.blue[800]),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: 5),
          // ctr_TextFormField(
          //   Controller: contValue,
          //   padding: EdgeInsets.only(right: 5, left: 180),
          //   Lable: 'المبلغ',
          //   TextType: const TextInputType.numberWithOptions(decimal: true),
          // ),
          // SizedBox(height: 5),
          ctr_TextFormField(
            Controller: contNote,
            padding: EdgeInsets.only(right: 5, left: 5),
            TextType: TextInputType.multiline,
            TextAlignValue: TextAlign.end,
            Lable: 'البيان',
            autoSelectData: true,
            minLines: 3,
          ),
        ],
      ),
    );
  }

  Widget buildListViewRecipts(BuildContext context) {
    return BlocBuilder<treasurMovement_bloc, financial_state>(
      builder: (context, state) {
        if (state is financialnitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is getListTreasuryMovement_StateDataChanged) {

          List<Fina_TreasuryMovementFull> lstMovement = state.filterdLst_TreasuryMovement.where((elm) => elm.IsTransfere == false).toList();

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 550,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Column Header
                  Container(
                    color: Colors.grey[300],
                    padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                    width: 1050,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(
                            width: 50,
                            child: Text('النوع', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                        SizedBox(
                            width: 100,
                            child: Text('الفرع', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                        SizedBox(
                            width: 100,
                            child: Text('الخزينة', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                        SizedBox(
                            width: 60,
                            child: Text('كود', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                        SizedBox(
                            width: 85,
                            child: Text('التاريخ', textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                        SizedBox(
                            width: 75,
                            child: Text('الساعة', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                        SizedBox(
                            width: 70,
                            child: Text('نوع الجهة', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                        SizedBox(
                            width: 100,
                            child:
                                Text('إسم الحساب', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                        SizedBox(
                            width: 70,
                            child: Text('القيمة', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                        SizedBox(
                            width: 100,
                            child: Text('بند الدفع', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                        SizedBox(
                            width: 200,
                            child: Text('البيان', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                        SizedBox(
                            width: 40,
                            child: Text('تحويل', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),

                  // ListView - Rows
                  Expanded(
                    child: SizedBox(
                      width: 1050,
                      height: 480,
                      child: ListView.separated(
                        // physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                        itemBuilder: (context, index) {
                          return buildListViewItem(lstMovement[index], context);
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 1),
                        itemCount: lstMovement.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  buildListViewItem(Fina_TreasuryMovementFull item, context) {
    return Column(
      children: [
        // Divider(
        //   color: Colors.grey,
        //   thickness: 1,
        // ),
        InkWell(
          onDoubleTap: () => viewRecipt(item),
          child: Container(
            color: item.FinacialTypeID == en_finacialType.finacialTypeExchange.value ? Colors.red[100] : Colors.green[100],
            height: 35,
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(item.FinacialTypeName!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 100,
                  child: Text(item.BranchName!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 100,
                  child: Text(item.TreasurName!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 60,
                  child: Text(item.Code.toString(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 85,
                  child: Text(item.Date!, textAlign: TextAlign.start, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 75,
                  child: Text(item.Time!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 70,
                  child: Text(item.DealingTypeName!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 100,
                  child: Text(item.DealingName!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 70,
                  child: Text(item.Value.toString(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 100,
                  child:
                      Text(item.FinancialClusesName!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 200,
                  child: Text(item.Note!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 40,
                  child: Checkbox(value: item.IsTransfere, onChanged: (value) {}),
                ),
              ],
            ),
          ),
        ),
      ],
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
    bllFina_ClosedTreasure.getMax_firestore(enTable_Fina_ClosedTreasure.Code).then((val) {
      contCode.text = val.toString();
    }).toString();

    contDate.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    contTime.text = sharedFunctions_Dates.convertDateTime_TimeString(DateTime.now());
    chkIsClosed = false;
  }

  void editMode() async {
    if (widget.itemClosedTreasure != null) {
      selectedID = widget.itemClosedTreasure!.ID!;
      contCode.text = widget.itemClosedTreasure!.Code.toString();
      contDate.text = widget.itemClosedTreasure!.Date!;
      contTime.text = widget.itemClosedTreasure!.Time!;

      branchFromID = widget.itemClosedTreasure!.IDBranchFrom;
      _branchFromID = ValueNotifier(branchFromID);
      branchToID = widget.itemClosedTreasure!.IDBranchTo;
      _branchToID = ValueNotifier(branchToID);
      treasure_bloc.instance.add(getListTreasureAsDataSource_Event(branchID: branchFromID));
      treasurFromID = widget.itemClosedTreasure!.IDTreasurFrom!;
      treasurToID = widget.itemClosedTreasure!.IDTreasurTo!;
      contBalanceTreasurFrom.text = widget.itemClosedTreasure!.BalanceTreasurFrom.toString();
      // // treasure_bloc.instance.add(getListTreasureAsDataSource_Event(branchID: branchToID));
      contBalanceTreasurTo.text = widget.itemClosedTreasure!.BalanceTreasurTo.toString();

      employeeID = widget.itemClosedTreasure!.IDEmployee;
      contEmployee.selectEmployee = await bllDealing_Employees.fire_getItem(widget.itemClosedTreasure!.IDEmployee!.toString());
      contEmployee.text = contEmployee.selectEmployee!.Name!;
      ctr_SelectEmployee.branchID = branchFromID;

      contNetValue.text = widget.itemClosedTreasure!.Value.toString();
      contNote.text = widget.itemClosedTreasure!.Note!;
      chkIsClosed = widget.itemClosedTreasure!.IsClosed!;
      
      // get List Recipts Details is closed
      // treasurMovement_bloc.instance.add(event)
    }
  }

  summary() {
    return SizedBox(
      width: 1050,
      height: 35,
      child: Row(
        children: [
          SizedBox(width: 3),
          BlocBuilder<treasurMovement_bloc, financial_state>(
            builder: (context, state) {
              if (state is getListTreasuryMovement_StateDataChanged) {
                contSumExchange.text = state.filterdLst_TreasuryMovement
                    .where((elm) => elm.FinacialTypeID == en_finacialType.finacialTypeExchange.value &&
                    elm.IsTransfere == false)
                    .fold(0.0, (previousValue, element) => previousValue + element.Value!)
                    .toStringAsFixed(2);

                contSumSupplay.text = state.filterdLst_TreasuryMovement
                    .where((elm) => elm.FinacialTypeID == en_finacialType.finacialTypeSupplay.value&&
                    elm.IsTransfere == false)
                    .fold(0.0, (previousValue, element) => previousValue + element.Value!)
                    .toStringAsFixed(2);

                contNetValue.text = (double.parse(contSumSupplay.text) - double.parse(contSumExchange.text)).toStringAsFixed(2);
                return Row(
                  children: [
                    SizedBox(
                      width: 110,
                      child: ctr_TextFormField(
                        Controller: contSumSupplay,
                        Lable: 'المقبوضات',
                        readOnly: true,
                        textStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    SizedBox(width: 5),
                    SizedBox(
                      width: 110,
                      child: ctr_TextFormField(
                        Controller: contSumExchange,
                        Lable: 'المدفوعات',
                        readOnly: true,
                        textStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    SizedBox(width: 5),
                    SizedBox(
                      width: 110,
                      child: ctr_TextFormField(
                        Controller: contNetValue,
                        Lable: 'الصافى',
                        readOnly: true,
                        textStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                );
              } else
                return SizedBox();
            },
          ),
        ],
      ),
    );
  }

  void clearCachedData() {
    ctr_SelectEmployee.branchID = branchFromID = treasurFromID = employeeID = null;
    contCode.text = contDate.text = contTime.text = contBalanceTreasurFrom.text = contNetValue.text = contNote.text = '';
    selectedID = -1;
    chkIsClosed = false;
  }

  bool checkIsSavedClosed() {
    if (widget.frmMode == en_FormMode.EditMode && (widget.itemClosedTreasure!.IsClosed!))
      return true;
    else
      return false;
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      if (widget.frmMode == en_FormMode.NewMode) {
        selectedID = await bllFina_ClosedTreasure.getMaxID_firestore();
      } else if (widget.frmMode == en_FormMode.EditMode) {
        selectedID = widget.itemClosedTreasure!.ID!;
      }
      widget.itemClosedTreasure = Fina_ClosedTreasure();
      widget.itemClosedTreasure!.ID = selectedID;
      widget.itemClosedTreasure!.Code = int.parse(contCode.text);
      widget.itemClosedTreasure!.Date = contDate.text;
      widget.itemClosedTreasure!.Time = contTime.text;
      widget.itemClosedTreasure!.IDBranchFrom = branchFromID;
      widget.itemClosedTreasure!.IDTreasurFrom = treasurFromID;
      widget.itemClosedTreasure!.BalanceTreasurFrom =
          contBalanceTreasurFrom.text.trim().isEmpty ? 0.0 : double.tryParse(contBalanceTreasurFrom.text.trim());
      widget.itemClosedTreasure!.IDEmployee = employeeID;
      widget.itemClosedTreasure!.IDBranchTo = branchToID;
      widget.itemClosedTreasure!.IDTreasurTo = treasurToID;
      widget.itemClosedTreasure!.BalanceTreasurTo =
          contBalanceTreasurTo.text.trim().isEmpty ? 0.0 : double.tryParse(contBalanceTreasurTo.text.trim());
      widget.itemClosedTreasure!.Value = double.tryParse(contNetValue.text);
      widget.itemClosedTreasure!.Note = contNote.text;
      widget.itemClosedTreasure!.IsClosed = chkIsClosed;

      // حفظ بيانات تقفيل الخزينة
      await bllFina_ClosedTreasure.fire_SetItem(selectedID.toString(), widget.itemClosedTreasure!);
      // تحديث سندات الدفع والقبض بأنه تم التحويل
     await treasurMovement_bloc.instance.updateReciptsIsTransfereDone(widget.itemClosedTreasure!);

      Navigator.pop(context, true);
    }
  }

  viewRecipt(Fina_TreasuryMovementFull item) async {
    if (item.FinacialTypeID == en_finacialType.finacialTypeExchange.value) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => scr_ExchangeItem(null, widget.scaffold, en_FormMode.NewMode),
        ),
      );

      //if (result == true) loadDataFromDB();
    } else if (item.FinacialTypeID == en_finacialType.finacialTypeSupplay.value) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => scr_SupplayItem(null, widget.scaffold, en_FormMode.NewMode),
        ),
      );
    }
  }
}

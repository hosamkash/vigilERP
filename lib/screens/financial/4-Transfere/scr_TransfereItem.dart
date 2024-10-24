import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/bllFirebase/bllFina_Transfere.dart';
import 'package:vigil_erp/bll/classModel/Fina_Transfere.dart';
import 'package:vigil_erp/blocManagment/blocDealing/dealing_bloc.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/sharedFunctions.dart';
import 'package:vigil_erp/shared/shared_controls.dart';
import '../../../bll/bllFirebase/bllDealing_Employees.dart';
import '../../../componants/ctr_Date.dart';
import '../../../componants/ctr_SelectEmployee.dart';
import '../../../componants/ctr_Time.dart';

class scr_TransfereItem extends StatefulWidget {
  scr_TransfereItem(this.itemTransfere, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Fina_Transfere? itemTransfere;
  en_FormMode frmMode;

  @override
  State<scr_TransfereItem> createState() => _scr_TransfereItemState();
}

class _scr_TransfereItemState extends State<scr_TransfereItem> {
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
  TextEditingController contValue = TextEditingController();
  TextEditingController contNote = TextEditingController();
  bool chkIsClosed = false;
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
    _branchFromID = ValueNotifier(branchFromID);
    _branchToID = ValueNotifier(branchToID);

    return Form(
      key: frmKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ctr_TextHeaderPage(
              text: 'بيانات تحويل النقدية',
              color: checkIsSavedClosed() ? Colors.red[100] : Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
            ),
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
                    padding: EdgeInsets.only(right: 5, left: 5),
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
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 180,
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
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contBalanceTreasurFrom,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'رصيد الخزينة',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    readOnly: true,
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.blue[800]),
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
                    padding: EdgeInsets.only(right: 5, left: 5),
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
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                SizedBox(
                  height: 50,
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
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contBalanceTreasurTo,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'رصيد الخزينة',
                    TextType: const TextInputType.numberWithOptions(decimal: true),
                    readOnly: true,
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.blue[800]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            ctr_TextFormField(
              Controller: contValue,
              padding: EdgeInsets.only(right: 5, left: 180),
              Lable: 'المبلغ',
              TextType: const TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 5),
            ctr_TextFormField(
              Controller: contNote,
              padding: EdgeInsets.only(right: 5, left: 5),
              TextType: TextInputType.multiline,
              TextAlignValue: TextAlign.end,
              Lable: 'البيان',
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
    bllFina_Transfere.getMax_firestore(enTable_Fina_Transfere.Code).then((val) {
      contCode.text = val.toString();
    }).toString();

    contDate.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    contTime.text = sharedFunctions_Dates.convertDateTime_TimeString(DateTime.now());
    chkIsClosed = false;
  }

  void editMode() async {
    if (widget.itemTransfere != null) {
      selectedID = widget.itemTransfere!.ID!;
      contCode.text = widget.itemTransfere!.Code.toString();
      contDate.text = widget.itemTransfere!.Date!;
      contTime.text = widget.itemTransfere!.Time!;

      branchFromID = widget.itemTransfere!.IDBranchFrom;
      _branchFromID = ValueNotifier(branchFromID);
      branchToID = widget.itemTransfere!.IDBranchTo;
      _branchToID = ValueNotifier(branchToID);
      treasure_bloc.instance.add(getListTreasureAsDataSource_Event(branchID: branchFromID));
      treasurFromID = widget.itemTransfere!.IDTreasurFrom!;
      treasurToID = widget.itemTransfere!.IDTreasurTo!;
      contBalanceTreasurFrom.text = widget.itemTransfere!.BalanceTreasurFrom.toString();
      // // treasure_bloc.instance.add(getListTreasureAsDataSource_Event(branchID: branchToID));
      contBalanceTreasurTo.text = widget.itemTransfere!.BalanceTreasurTo.toString();

      employeeID = widget.itemTransfere!.IDEmployee;
      contEmployee.selectEmployee = await bllDealing_Employees.fire_getItem(widget.itemTransfere!.IDEmployee!.toString());
      contEmployee.text = contEmployee.selectEmployee!.Name!;
      ctr_SelectEmployee.branchID = branchFromID;

      contValue.text = widget.itemTransfere!.Value.toString();
      contNote.text = widget.itemTransfere!.Note!;
      chkIsClosed = widget.itemTransfere!.IsClosed!;
    }
  }

  void clearCachedData() {
    ctr_SelectEmployee.branchID = branchFromID = treasurFromID = employeeID = null;
    contCode.text = contDate.text = contTime.text = contBalanceTreasurFrom.text = contValue.text = contNote.text = '';
    selectedID = -1;
    chkIsClosed = false;
  }

  bool checkIsSavedClosed() {
    if (widget.frmMode == en_FormMode.EditMode && (widget.itemTransfere!.IsClosed!))
      return true;
    else
      return false;
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      if (widget.frmMode == en_FormMode.NewMode) {
        selectedID = await bllFina_Transfere.getMaxID_firestore();
      } else if (widget.frmMode == en_FormMode.EditMode) {
        selectedID = widget.itemTransfere!.ID!;
      }
      widget.itemTransfere = Fina_Transfere();
      widget.itemTransfere!.ID = selectedID;
      widget.itemTransfere!.Code = int.parse(contCode.text);
      widget.itemTransfere!.Date = contDate.text;
      widget.itemTransfere!.Time = contTime.text;
      widget.itemTransfere!.IDBranchFrom = branchFromID;
      widget.itemTransfere!.IDTreasurFrom = treasurFromID;
      widget.itemTransfere!.BalanceTreasurFrom =
          contBalanceTreasurFrom.text.trim().isEmpty ? 0.0 : double.tryParse(contBalanceTreasurFrom.text.trim());
      widget.itemTransfere!.IDEmployee = employeeID;
      widget.itemTransfere!.IDBranchTo = branchToID;
      widget.itemTransfere!.IDTreasurTo = treasurToID;
      widget.itemTransfere!.BalanceTreasurTo = contBalanceTreasurTo.text.trim().isEmpty ? 0.0 : double.tryParse(contBalanceTreasurTo.text.trim());
      widget.itemTransfere!.Value = double.tryParse(contValue.text);
      widget.itemTransfere!.Note = contNote.text;
      widget.itemTransfere!.IsClosed = chkIsClosed;

      await bllFina_Transfere.fire_SetItem(selectedID.toString(), widget.itemTransfere!);
      Navigator.pop(context, true);
    }
  }
}

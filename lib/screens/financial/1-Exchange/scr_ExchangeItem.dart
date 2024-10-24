import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/bllFirebase/bllFina_Exchange.dart';
import 'package:vigil_erp/bll/classModel/Dealing_Clients.dart';
import 'package:vigil_erp/bll/classModel/Dealing_Employees.dart';
import 'package:vigil_erp/bll/classModel/Dealing_Vendors.dart';
import 'package:vigil_erp/bll/classModel/Fina_Exchange.dart';
import 'package:vigil_erp/blocManagment/blocDealing/dealing_bloc.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/blocManagment/blocFixTables/fix_table_bloc.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_SelectDealing.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/screens/invoices/1-Purchase/scr_purchaseItem.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/sharedFunctions.dart';
import 'package:vigil_erp/shared/shared_controls.dart';
import '../../../componants/ctr_Date.dart';
import '../../../componants/ctr_SelectEmployee.dart';
import '../../../componants/ctr_Time.dart';

class scr_ExchangeItem extends StatefulWidget {
  scr_ExchangeItem(this.itemExchange, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Fina_Exchange? itemExchange;
  en_FormMode frmMode;

  @override
  State<scr_ExchangeItem> createState() => _scr_ExchangeItemState();
}

class _scr_ExchangeItemState extends State<scr_ExchangeItem> {
  int selectedID = -1;
  int? branchID;
  TextEditingController contCode = TextEditingController();
  TextEditingController contSerial = TextEditingController();
  TextEditingController contDate = TextEditingController();
  TextEditingController contTime = TextEditingController();
  TimeOfDay? timeWorkFrom;
  int? treasurID;
  TextEditingController contTreasureBalanceBefor = TextEditingController();
  int? dealingTypeID;
  en_DealingType? dealingType;
  int? dealingID;
  TextEditingController_Dealing contDealing = TextEditingController_Dealing();
  TextEditingController contDealingBalanceBefor = TextEditingController();
  int? financialClusesID;
  TextEditingController contValue = TextEditingController();
  TextEditingController contNote = TextEditingController();
  bool chkIsBindeDocument = false;
  bool chkIsAccountedByRepresent = false;
  bool chkIsClosedTreasure = false;
  bool chkIsClosedEdit = false;
  var frmKey = GlobalKey<FormState>();
  ValueNotifier<int?>? _branchID ;

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
     _branchID = ValueNotifier(branchID);

    return Form(
      key: frmKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ctr_TextHeaderPage(
              text: 'بيانات سند الدفع',
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
                      _branchID!.value = branchID = returnID;
                      treasure_bloc.instance.add(getListTreasureAsDataSource_Event(branchID: branchID));
                      setDealingTypeByID();
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
                Expanded(
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
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contSerial,
                    padding: EdgeInsets.only(right: 5, left: 5),
                    Lable: 'السريال',
                    TextType: TextInputType.text,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
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
                SizedBox(
                  height: 50,
                  width: 180,
                  child: BlocBuilder<treasure_bloc, definition_state>(
                    builder: (context, state) {
                      bool isState = state is getListTreasureAsDataSource_State ? true : false;
                      List<DropDowenDataSource> lstTreasures = isState
                          ? state.lstTreasureAsDataSource.where((elm) {
                              return elm.branchID == branchID;
                            }).toList()
                          : [];

                      return ctr_DropDowenList(
                        hintLable: 'الخزينة - الصندوق',
                        padding: EdgeInsets.only(right: 5, left: 0),
                        lstDataSource: lstTreasures,
                        hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                        itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                        menuMaxHeightValue: 300,
                        showClearIcon: false,
                        selectedValue: treasurID =
                            lstTreasures.length > 0 && widget.frmMode == en_FormMode.NewMode ? lstTreasures.first.valueMember : treasurID,
                        OnChanged: (returnID) {
                          treasurID = returnID;
                          contTreasureBalanceBefor.text = '0';
                          return treasurID;
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
                    Controller: contTreasureBalanceBefor,
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
                SizedBox(
                  width: 185,
                  height: 50,
                  child: ctr_DropDowenList(
                    hintLable: 'نوع الجهه',
                    padding: EdgeInsets.only(right: 5, left: 5),
                    lstDataSource: dealingType_bloc.instance.lstDealingTypeAsDataSource,
                    hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                    itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                    menuMaxHeightValue: 300,
                    showClearIcon: false,
                    selectedValue: dealingTypeID,
                    OnChanged: (returnID) {
                      setState(() {
                        dealingTypeID = returnID;
                        setDealingTypeByID();
                      });
                      return dealingTypeID;
                    },
                    OnValidate: (value) {
                      if (value == null) {
                        return 'لابد من إختيار قيمة';
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: contDealingBalanceBefor,
                    padding: EdgeInsets.only(right: 0, left: 5),
                    Lable: 'رصيد ${dealingType_bloc.instance.getNameByID(dealingTypeID)}',
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
                ValueListenableBuilder<int?>(
                  valueListenable: _branchID!,
                  builder: (context, value, child) {
                    return ctr_SelectDealing(
                      Controller: contDealing,
                      dealingType: dealingType,
                      currentBranchID: _branchID!.value,
                      padding: EdgeInsets.only(right: 5, left: 0),
                      labelText: 'الحساب - الجهه',
                      isOpenSelectorOnTap: true,
                      labelStyle: TextStyle(color: Colors.blue[700]),
                      colorBorder: Colors.blue[700],
                      onSelectDealing: (dynamic dealing) {
                        setDealingOnSelected(dealing);
                      },
                      OnValidate: (employee) {
                        if (employee != null && employee.isEmpty) {
                          return 'لابد من إختيار قيمة';
                        }
                        return null;
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 5),
            ctr_DropDowenList(
              hintLable: 'بند الدفع',
              padding: EdgeInsets.only(right: 5, left: 5),
              lstDataSource: financialCluses_bloc.instance.LstFinancialClusesAsDataSource,
              hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
              itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
              menuMaxHeightValue: 300,
              showClearIcon: false,
              selectedValue: financialClusesID,
              OnChanged: (returnID) {
                financialClusesID = returnID;
                return financialClusesID;
              },
              OnValidate: (value) {
                if (value == null) {
                  return 'لابد من إختيار قيمة';
                }
                return null;
              },
            ),
            SizedBox(height: 5),
            ctr_TextFormField(
              Controller: contValue,
              padding: EdgeInsets.only(right: 5, left: 170),
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
            Row(
              children: [
                Checkbox(
                    value: chkIsClosed,
                    onChanged: (value) {
                      // setState(() {
                      //   chkIsClosed = !chkIsClosed;
                      // });
                    }),
                const Text('مغلق', style: TextStyle(fontSize: 17)),
                Checkbox(
                    value: chkIsBindeDocument,
                    onChanged: (value) {
                      // setState(() {
                      //   chkIsClosed = !chkIsClosed;
                      // });
                    }),
                const Text('مرتبط بمستند', style: TextStyle(fontSize: 17)),
                Checkbox(
                    value: chkIsAccountedByRepresent,
                    onChanged: (value) {
                      // setState(() {
                      //   chkIsClosed = !chkIsClosed;
                      // });
                    }),
                const Text('تم التحويل', style: TextStyle(fontSize: 17)),
              ],
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
                    chkIsClosedEdit = true;
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
    bllFina_Exchange.getMax_firestore(enTable_Fina_Exchange.Code).then((val) {
      contCode.text = val.toString();
    }).toString();

    contDate.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    contTime.text = sharedFunctions_Dates.convertDateTime_TimeString(DateTime.now());
    chkIsClosed = false;
  }

  void editMode() async {
    if (widget.itemExchange != null) {
      selectedID = widget.itemExchange!.ID!;
      branchID = widget.itemExchange!.IDBranch;
      _branchID = ValueNotifier(branchID);
     // _branchID!.value = branchID  ;
      treasure_bloc.instance.add(getListTreasureAsDataSource_Event(branchID: branchID));

      treasurID = widget.itemExchange!.IDTreasur;
      contCode.text = widget.itemExchange!.Code.toString();
      contDate.text = widget.itemExchange!.Date!;
      contTime.text = widget.itemExchange!.Time!;

      dealingTypeID = widget.itemExchange!.DealingTypeID;
      setDealingTypeByID();
      dealingID = widget.itemExchange!.DealingID;
      setDealingByID();

      contDealingBalanceBefor.text = widget.itemExchange!.BalanceBefor.toString();
      contValue.text = widget.itemExchange!.Value.toString();
      financialClusesID = widget.itemExchange!.IDFinancialCluses;
      contNote.text = widget.itemExchange!.Note!;
      chkIsBindeDocument = widget.itemExchange!.IsBindeDocument!;
      chkIsAccountedByRepresent = widget.itemExchange!.IsAccountedByRepresent!;
      chkIsClosedTreasure = widget.itemExchange!.IsClosedTreasure!;
      chkIsClosedEdit = widget.itemExchange!.IsClosedEdit!;
    }
  }

  void clearCachedData() {
    ctr_SelectEmployee.branchID = branchID = treasurID = dealingTypeID = dealingID = financialClusesID = null;
    contCode.text = contSerial.text = contDate.text = contTime.text = contTreasureBalanceBefor.text = contValue.text = contNote.text = '';
    selectedID = -1;
    chkIsBindeDocument = chkIsAccountedByRepresent = chkIsClosedTreasure = chkIsClosedEdit = false;
  }

  bool checkIsSavedClosed() {
    if (widget.frmMode == en_FormMode.EditMode && (widget.itemExchange!.IsClosedEdit!))
      return true;
    else
      return false;
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      if (widget.frmMode == en_FormMode.NewMode) {
        selectedID = await bllFina_Exchange.getMaxID_firestore();
      } else if (widget.frmMode == en_FormMode.EditMode) {
        selectedID = widget.itemExchange!.ID!;
      }
      widget.itemExchange = Fina_Exchange();
      widget.itemExchange!.ID = selectedID;
      widget.itemExchange!.IDBranch = branchID;
      widget.itemExchange!.Code = int.parse(contCode.text);
      widget.itemExchange!.Date = contDate.text;
      widget.itemExchange!.Time = contTime.text;
      widget.itemExchange!.IDTreasur = treasurID;
      widget.itemExchange!.DealingTypeID = dealingTypeID;
      widget.itemExchange!.DealingID = dealingID;
      widget.itemExchange!.BalanceBefor = double.tryParse(contDealingBalanceBefor.text);
      widget.itemExchange!.Value = double.tryParse(contValue.text);
      widget.itemExchange!.IDFinancialCluses = financialClusesID;
      widget.itemExchange!.Note = contNote.text;
      widget.itemExchange!.IsBindeDocument = chkIsBindeDocument;
      widget.itemExchange!.IsAccountedByRepresent = chkIsAccountedByRepresent;
      widget.itemExchange!.IsClosedTreasure = chkIsClosedTreasure;
      widget.itemExchange!.IsClosedEdit = chkIsClosedEdit;

      await bllFina_Exchange.fire_SetItem(selectedID.toString(), widget.itemExchange!);
      Navigator.pop(context, true);
    }
  }

  void setDealingTypeByID() {
    if (dealingTypeID == en_DealingType.Cliens.value) {
      dealingType = en_DealingType.Cliens;
    } else if (dealingTypeID == en_DealingType.Vendors.value) {
      dealingType = en_DealingType.Vendors;
    } else if (dealingTypeID == en_DealingType.Employees.value) {
      dealingType = en_DealingType.Employees;
    }

    contDealing.selectClient = null;
    contDealing.selectVendor = null;
    contDealing.selectEmployee = null;
    contDealing.branch = branchID;
    contDealing.text = '';
  }

  void setDealingByID() async {
    dynamic dealing;
    if (dealingType == en_DealingType.Cliens) {
      dealing = await client_bloc.instance.getClientByID(dealingID);
    } else if (dealingType == en_DealingType.Vendors) {
      dealing = await vendor_bloc.instance.getVendorByID(dealingID);
    } else if (dealingType == en_DealingType.Employees) {
      dealing = await employee_bloc.instance.getEmployeeByID(dealingID);
    }
    setDealingOnSelected(dealing);
  }

  void setDealingOnSelected(dealing) {
    if (dealingType == en_DealingType.Cliens) {
      contDealing.selectClient = (dealing as Dealing_Clients);
      contDealing.text = contDealing.selectClient!.Name!;
      dealingID = contDealing.selectClient!.ID!;
    } else if (dealingType == en_DealingType.Vendors) {
      contDealing.selectVendor = (dealing as Dealing_Vendors);
      contDealing.text = contDealing.selectVendor!.Name!;
      dealingID = contDealing.selectVendor!.ID!;
    } else if (dealingType == en_DealingType.Employees) {
      contDealing.selectEmployee = (dealing as Dealing_Employees);
      contDealing.text = contDealing.selectEmployee!.Name!;
      dealingID = contDealing.selectEmployee!.ID!;
    }
  }
}

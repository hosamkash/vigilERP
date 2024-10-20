import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/bllFirebase/bllInv_RecivedQty.dart';
import 'package:vigil_erp/bll/bllFirebase/bllInv_Transfer.dart';
import 'package:vigil_erp/bll/classModel/Def_ProductStructure.dart';
import 'package:vigil_erp/bll/classModel/Def_Units.dart';
import 'package:vigil_erp/bll/classModel/Inv_RecivedQty.dart';
import 'package:vigil_erp/bll/classModel/Inv_RecivedQtyDetails.dart';
import 'package:vigil_erp/bll/classModel/Inv_Transfer.dart';
import 'package:vigil_erp/blocManagment/blocDealing/dealing_bloc.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/blocManagment/blocFixTables/fix_table_bloc.dart';
import 'package:vigil_erp/blocManagment/blocInventory/inv_bloc.dart';
import 'package:vigil_erp/componants/ctr_Date.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_SelectEmployee.dart';
import 'package:vigil_erp/componants/ctr_SelectProduct.dart';
import 'package:vigil_erp/componants/ctr_TabBar.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/componants/ctr_Time.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/sharedFunctions.dart';
import 'package:vigil_erp/shared/sharedHive.dart';
import 'package:vigil_erp/shared/shared_controls.dart';
import '../../../bll/bllFirebase/ManageBLL.dart';
import '../../../bll/bllFirebase/bllDealing_Employees.dart';
import '../../../bll/bllFirebase/bllInv_ProductsQty.dart';
import '../../../bll/classModel/Def_Stocks.dart';
import '../../../bll/classModel/Inv_ProductsQty.dart';
import '../../../bll/classModel/Inv_TransferDetails.dart';

class scr_RecivedQtyItem extends StatefulWidget {
  scr_RecivedQtyItem(this.itemRecived, this.frmMode, {super.key, this.itemTransferQty});

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Inv_Transfer? itemTransferQty;
  Inv_RecivedQty? itemRecived;
  en_FormMode frmMode;

  @override
  State<scr_RecivedQtyItem> createState() => _scr_RecivedQtyItemState();
}

var frmKey = GlobalKey<FormState>();

List<Inv_RecivedQtyDetails> lstDetailsDeleted = [];
int selectedID = -1;
int? branchIDFromRecived;
int? branchIDToRecived;
int? stockIDFromRecived;
int? stockIDToRecived;
TextEditingController_Employee contEmployee = TextEditingController_Employee();
TextEditingController contCode = TextEditingController();
TextEditingController contDate = TextEditingController();
TextEditingController contTime = TextEditingController();
TimeOfDay? timeWorkFrom;
int? requestStatusID;
TextEditingController contNote = TextEditingController();
TextEditingController contTotalValueFrom = TextEditingController();
TextEditingController contTotalValueTo = TextEditingController();

List<Inv_ProductsQty> lstProductsQty = [];
TextEditingController contFilter = TextEditingController();

class _scr_RecivedQtyItemState extends State<scr_RecivedQtyItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
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
      // endDrawer: buildDrawerProductsInvoice(context),
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
              text: 'بيانات إستلام التحويل',
              color: checkIsSentDocument() ? Colors.red[100] : Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: ctr_TextFormField(
                    Controller: contCode,
                    padding: EdgeInsets.only(right: 5, left: 0, top: 5, bottom: 5),
                    Lable: 'الكود',
                    TextType: TextInputType.number,
                    OnValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'لابد من إدخال قيمة';
                      }
                      return null;
                    },
                    readOnly: true,
                  ),
                ),

                Expanded(
                  child:
                      // BlocBuilder<cubitGeneral, cubitStates>(
                      //   builder: (context, state) {
                      //     if (state is requestStatus_StateChanged) {
                      //       return
                      ctr_DropDowenList(
                    hintLable: 'حالة الطلب',
                    padding: EdgeInsets.only(right: 5, left: 0),
                    lstDataSource: requestStatus_bloc.instance.lstRequestStatusAsDataSource.where((elm) {
                      return elm.valueMember == en_RequestStatus.ReceivedReview.value ||
                          elm.valueMember == en_RequestStatus.ReviewError.value ||
                          elm.valueMember == en_RequestStatus.Received.value;
                    }).toList(),
                    hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                    itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                    menuMaxHeightValue: 300,
                    showClearIcon: true,
                    selectedValue: requestStatusID,
                    // selectedValue: requestStatusID =
                    //     requestStatus_bloc.instance.lstRequestStatusAsDataSource.length > 0 && widget.frmMode == en_FormMode.NewMode
                    //         ? requestStatus_bloc.instance.lstRequestStatusAsDataSource.first.valueMember
                    //         : requestStatusID,
                    OnChanged: (returnID) {
                      requestStatusID = returnID;
                      return requestStatusID;
                    },
                    OnValidate: (value) {
                      if (value == null) {
                        return 'لابد من إختيار قيمة';
                      }
                      return null;
                    },
                  ),
                  //   } else
                  //     return SizedBox();
                  // },
                ),
                // ),
              ],
            ),
            SizedBox(height: 5),
            SizedBox(
              height: 530,
              child: Card(
                color: Colors.grey[100],
                child: ctr_TabBar(
                  LstTabBarViewHeaderWidget: [
                    Text('البيانات الأساسية', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text('الأصناف', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                  LstTabBarViewWidget: [
                    BuildMasterData(),
                    BuildDetailsProduct_SumValues(),
                  ],
                ),
              ),
            ),
            buildCalcSummtion(),
          ],
        ),
      ),
    );
  }

  Widget BuildMasterData() {
    return SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      // SizedBox(height: 5),
      Row(
        children: [
          Expanded(
            child: ctr_Date(
              text: 'التاريخ',
              dtController: contDate,
              padding: EdgeInsets.only(right: 5, left: 0, top: 10, bottom: 5),
              // height: 55,
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
            width: 160,
            child: ctr_Time(
              text: 'الساعة',
              dtController: contTime,
              padding: EdgeInsets.only(right: 5, left: 0, top: 10, bottom: 5),
              // height: 55,
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
      ctr_DropDowenList(
        hintLable: 'من فرع',
        padding: EdgeInsets.only(right: 5, left: 5),
        lstDataSource: company_bloc.instance.LstBranchesAsDataSource,
        hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
        itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
        menuMaxHeightValue: 300,
        showClearIcon: true,
        selectedValue: branchIDFromRecived,
        readOnly: true,
        OnChanged: (returnID) {
          branchIDFromRecived = returnID;
          // reset Employee and populate with New branch
          contEmployee.selectEmployee = null;
          contEmployee.text = '';
          employee_bloc.instance.add(getLstEmployeeAsDataSource_Event());
          ctr_SelectEmployee.branchID = branchIDFromRecived;

          // reset Stock and populate with New branch
          stockIDFromRecived = null;
          stock_bloc.instance.add(
            getLstStocksAsDataSource_Event(
              branchID: branchIDFromRecived,
              branchID2: branchIDToRecived,
              condions: [
                BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchIDFromRecived),
                BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchIDToRecived),
              ],
            ),
          );

          stockIDFromRecived =
              stock_bloc.instance.LstStocksAsDataSource.length > 0 ? stock_bloc.instance.LstStocksAsDataSource.first.valueMember : stockIDFromRecived;
          return null;
        },
        OnValidate: (value) {
          if (value == null) {
            return 'لابد من إختيار قيمة';
          }
          return null;
        },
      ),
      SizedBox(height: 5),
      BlocBuilder<stock_bloc, definition_state>(
        builder: (context, state) {
          bool isStockState = state is getLstStocksAsDataSource_State;
          List<DropDowenDataSource> lstStocks = branchIDFromRecived != null && isStockState ? state.LstStocksAsDataSource : [];

          return ctr_DropDowenList(
            hintLable: 'من مخزن',
            padding: EdgeInsets.only(right: 5, left: 0),
            lstDataSource: lstStocks,
            hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
            itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
            menuMaxHeightValue: 300,
            showClearIcon: true,
            readOnly: true,
            selectedValue: stockIDFromRecived =
                lstStocks.length > 0 && widget.frmMode == en_FormMode.NewMode ? lstStocks.first.valueMember : stockIDFromRecived,
            OnChanged: (returnID) {
              stockIDFromRecived = returnID;
              return stockIDFromRecived;
            },
            OnValidate: (value) {
              stockIDFromRecived = value;
              if (value == null || stockIDFromRecived == null) {
                return 'لابد من إختيار قيمة';
              }
              return null;
            },
          );
        },
      ),
      SizedBox(height: 5),
      Row(
        children: [
          ctr_SelectEmployee(
            Controller: contEmployee,
            padding: EdgeInsets.only(right: 5, left: 0),
            labelText: 'القائم بالطلب',
            isOpenSelectorOnTap: true,
            // branchID: branchID,
            onSelectEmployee: (Dealing) {
              print(Dealing.Name);
              contEmployee.selectEmployee = Dealing;
            },
            OnValidate: (employee) {
              if (employee == null || employee.isEmpty) {
                return 'لابد من إختيار قيمة';
              }
              return null;
            },
          ),
        ],
      ),
      Divider(color: Colors.grey, thickness: 3),

      ctr_DropDowenList(
        hintLable: 'إلى فرع',
        padding: EdgeInsets.only(right: 5, left: 5),
        lstDataSource: company_bloc.instance.LstBranchesAsDataSource,
        hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
        itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
        menuMaxHeightValue: 300,
        showClearIcon: true,
        readOnly: true,
        selectedValue: branchIDToRecived,
        OnChanged: (returnID) {
          branchIDToRecived = returnID;
          // reset Stock and populate with New branch
          stockIDToRecived = null;
          stock_bloc.instance.add(
            getLstStocksAsDataSource_Event(
              branchID: branchIDFromRecived,
              branchID2: branchIDToRecived,
              condions: [
                BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchIDFromRecived),
                BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchIDToRecived),
              ],
            ),
          );
          stockIDToRecived =
              stock_bloc.instance.LstStocksAsDataSource2.length > 0 ? stock_bloc.instance.LstStocksAsDataSource2.first.valueMember : stockIDToRecived;
          return null;
        },
        OnValidate: (value) {
          if (value == null) {
            return 'لابد من إختيار قيمة';
          }
          return null;
        },
      ),
      SizedBox(height: 5),
      BlocBuilder<stock_bloc, definition_state>(
        builder: (context, state) {
          bool isStockStateTo = state is getLstStocksAsDataSource_State;
          List<DropDowenDataSource> lstStocksTo = branchIDToRecived != null && isStockStateTo ? state.LstStocksAsDataSource2 : [];

          return ctr_DropDowenList(
            hintLable: 'إلى مخزن',
            padding: EdgeInsets.only(right: 5, left: 0),
            lstDataSource: lstStocksTo,
            hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
            itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
            menuMaxHeightValue: 300,
            showClearIcon: true,
            readOnly: true,
            selectedValue: stockIDToRecived =
                lstStocksTo.length > 0 && widget.frmMode == en_FormMode.NewMode ? lstStocksTo.first.valueMember : stockIDToRecived,
            OnChanged: (returnID) {
              stockIDToRecived = returnID;
              return stockIDToRecived;
            },
            OnValidate: (value) {
              stockIDToRecived = value;
              if (value == null || stockIDToRecived == null) {
                return 'لابد من إختيار قيمة';
              }
              return null;
            },
          );
        },
      ),

      SizedBox(height: 5),
      ctr_TextFormField(
        Controller: contNote,
        padding: EdgeInsets.only(right: 5, left: 0),
        Lable: 'ملاحظات',
      ),

      if (!checkIsSentDocument())
        ElevatedButton.icon(
          label: Text(
            'تم إستلام طلب التحويل',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.blue[800]),
          ),
          icon: Icon(Icons.done_outline),
          style: ElevatedButton.styleFrom(elevation: 3, backgroundColor: Colors.white),
          onPressed: () {
            sharedControls.confirmDialog(context, 'تأكيد الإستلام',
                'فى حالة تأكيد إستلام طلب التحويل سيتم التأثير على رصيد المخزن بالزيادة وإغلاق المستند ولا يمكن التعديل فيه نهائياً', () {
              requestStatusID = en_RequestStatus.Received.value;
              saveData();
              saveProductsQty();
              // تحديث مستند التحويل عشان مينفعش يتفتح تاني
              widget.itemTransferQty!.IDRequestStatus = requestStatusID;
              bllInv_Transfer.fire_SetItem(widget.itemTransferQty!.ID.toString(), widget.itemTransferQty!);
            });
          },
        ),
    ]));
  }

  Widget BuildListView(BuildContext context) {
    return BlocBuilder<recived_bloc, inv_state>(
      builder: (context, state) {
        if (state is recivedDetails_StateInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is recivedDetails_StateDataChanged) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                // Filter
                SizedBox(
                  height: 60,
                  width: 910,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 300,
                        child: ctr_TextFormField(
                          Controller: contFilter,
                          PrefixIcon: const Icon(Icons.search),
                          padding: const EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 0),
                          OnChanged: (value) {
                            if (value != null) {
                              recived_bloc.instance.add(filterAnyRecivedDetails_Event(filterData: value.trim()));
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          contFilter.clear();
                          recived_bloc.instance.add(resetFilterRecivedDetails_Event());
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ],
                  ),
                ),

                // Column Header
                Container(
                  color: Colors.grey[300],
                  width: 910,
                  height: 30,
                  child: Row(
                    children: [
                      SizedBox(
                          width: 60,
                          child: Text('باركود', textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 120,
                          child: Text('الصــــنف', textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 90,
                          child: Text('التصنيف', textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 90,
                          child: Text('فئة السعر', textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 220,
                          child: Text('الكمية والسعر المحول',
                              textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 220,
                          child: Text('الكميات المستلمة فعليا',
                              textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red[700]))),
                      SizedBox(
                          width: 90,
                          child: Text(
                            '',
                          )),
                    ],
                  ),
                ),

                // ListView - Rows
                Expanded(
                  child: SizedBox(
                    width: 910,
                    height: 500,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(right: 2, left: 2),
                      itemBuilder: (context, index) {
                        return buildListViewItem(state.filterdLst_RecivedDetails[index], context, index);
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 1),
                      itemCount: state.filterdLst_RecivedDetails.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  buildListViewItem(Inv_RecivedQtyDetails itemDetails, context, int index) {
    return InkWell(
      onDoubleTap: () => recivedQtyDetails(itemDetails, index),
      child: Container(
        padding: const EdgeInsets.only(top: 0, right: 0, bottom: 0, left: 0),
        color: Colors.white,
        height: itemDetails.isBigUnit! ? 62 : 42, // لو الصنف بوحدة كبيرة يكبر إرتفاع السطر
        child: Column(
          children: [
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text('${itemDetails.Barcode}', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    sharedFunctions_String.RemoveStringWords(product_bloc.instance.getNameByID(itemDetails.IDProduct)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Text('${categories_bloc.instance.getNameByID(itemDetails.IDClassefication)}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 90,
                  child: Text('${priceType_bloc.instance.getNameByID(itemDetails.PriceType)}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 220,
                  child: Column(
                    children: [
                      // يظهر السطر فى حالة اضافة وحدة كبري
                      if (itemDetails.isBigUnit!)
                        Row(
                          children: [
                            Text('${itemDetails.UnitBig_Qty} ${unit_bloc.instance.getNameByID(itemDetails.UnitBig_ID)}',
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            Text(' x ', style: const TextStyle(fontSize: 14)),
                            Text('${itemDetails.UnitBig_Price}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            Text(' = ', style: const TextStyle(fontSize: 14)),
                            Text('${itemDetails.TotalPrice!.toStringAsFixed(2)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      // خاص ببيانات الوحدة الصغري
                      Row(
                        children: [
                          Text('${itemDetails.UnitSmall_Qty} ${unit_bloc.instance.getNameByID(itemDetails.UnitSmall_ID)}',
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(' x ', style: const TextStyle(fontSize: 14)),
                          Text('${itemDetails.UnitSmall_Price}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(' = ', style: const TextStyle(fontSize: 14)),
                          Text('${itemDetails.TotalPrice!.toStringAsFixed(2)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                // الكميات المستلمة فعليا
                SizedBox(
                  width: 220,
                  child: Column(
                    children: [
                      // يظهر السطر فى حالة اضافة وحدة كبري
                      if (itemDetails.RecivedisBigUnit != null && itemDetails.RecivedisBigUnit!)
                        Row(
                          children: [
                            Text('${itemDetails.RecivedUnitBig_Qty} ${unit_bloc.instance.getNameByID(itemDetails.RecivedUnitBig_ID)}',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red[700])),
                            Text(' x ', style: const TextStyle(fontSize: 14)),
                            Text('${itemDetails.RecivedUnitBig_Price}',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red[700])),
                            Text(' = ', style: const TextStyle(fontSize: 14)),
                            Text('${itemDetails.RecivedTotalPrice!.toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red[700])),
                          ],
                        ),
                      // خاص ببيانات الوحدة الصغري
                      if (itemDetails.RecivedisBigUnit != null)
                        Row(
                          children: [
                            Text('${itemDetails.RecivedUnitSmall_Qty} ${unit_bloc.instance.getNameByID(itemDetails.RecivedUnitSmall_ID)}',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red[700])),
                            Text(' x ', style: const TextStyle(fontSize: 14)),
                            Text('${itemDetails.RecivedUnitSmall_Price}',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red[700])),
                            Text(' = ', style: const TextStyle(fontSize: 14)),
                            Text('${itemDetails.RecivedTotalPrice!.toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red[700])),
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Row(
                    children: [
                      InkWell(
                        child: const Row(
                          children: [
                            Icon(Icons.edit, color: Colors.blue),
                          ],
                        ),
                        onTap: () async {
                          recivedQtyDetails(itemDetails, index);
                        },
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red[700]),
                          ],
                        ),
                        onTap: () {
                          deletItemDetails(itemDetails);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildDetailsProduct_SumValues() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 0, right: 5, bottom: 10, left: 0),
            child: BuildListView(context),
          ),
        ),
      ],
    );
  }

  Widget buildCalcSummtion() {
    return Container(
      color: Colors.yellow[200],
      child: BlocBuilder<recived_bloc, inv_state>(
        builder: (context, state) {
          if (state is recivedDetails_StateDataChanged) {
            contTotalValueFrom.text =
                state.filterdLst_RecivedDetails.fold(0.0, (previousValue, element) => previousValue + element.TotalPrice!).toStringAsFixed(2);

            return Row(
              children: [
                Text('العدد:', style: const TextStyle(fontSize: 14)),
                Text('${state.filterdLst_RecivedDetails.length}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('   الكمية :', style: const TextStyle(fontSize: 14)),
                Text('${state.filterdLst_RecivedDetails.fold(0, (previousValue, element) => previousValue + element.UnitSmall_Qty!)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('    الإجمالى:', style: const TextStyle(fontSize: 14)),
                Text(
                    '${state.filterdLst_RecivedDetails.fold(0.0, (previousValue, element) => previousValue + element.TotalPrice!).toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            );
          } else
            return SizedBox();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    product_bloc.instance.add(getListProduct_Event([BLLCondions(enTable_Def_ProductStructure.IsActive.name, en_CondionsWhere.isEqualTo, true)]));
    requestStatus_bloc.instance.getLst_requestStatusAsDataSource();
    priceType_bloc.instance.getLst_PriceTypeAsDataSource();
    // categories_bloc.instance.add(getListCategories_Event([BLLCondions(enTable_Def_Categories.IsActive.name, en_CondionsWhere.isEqualTo, true)]));
    categories_bloc.instance.getList_CategoryAsDataSource();
    unit_bloc.instance.add(getListUnit_Event([BLLCondions(enTable_Def_Units.IsActive.name, en_CondionsWhere.isEqualTo, true)]));
    clearCachedData();

    // if (widget.frmMode == en_FormMode.NewMode && widget.itemTransferQty == null)
    //   newMode();
    // لو كنت فى تحويل المخازن وبعمل استلام تحويل
    if (widget.frmMode == en_FormMode.NewMode && widget.itemTransferQty != null)
      newModeWithTransferQty(widget.itemTransferQty);
    else if (widget.frmMode == en_FormMode.EditMode) {
      editMode();
    }
  }

  Widget buildCustomBar() {
    return Row(
      children: [
        if (!checkIsSentDocument())
          IconButton(
            onPressed: () {
              saveData();
              // تحديث مستند التحويل عشان مينفعش يتفتح تاني
              widget.itemTransferQty!.IDRequestStatus = requestStatusID;
              bllInv_Transfer.fire_SetItem(widget.itemTransferQty!.ID.toString(), widget.itemTransferQty!);
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

  @override
  void dispose() {
    super.dispose();
  }

  void clearCachedData() {
    branchIDFromRecived = branchIDToRecived =
        stockIDToRecived = stockIDFromRecived = contEmployee.selectEmployee = ctr_SelectEmployee.branchID = requestStatusID = null;
    contEmployee.text = '';
    employee_bloc.instance.add(resetFilterEmployee_Event());
    lstDetailsDeleted.clear();
    lstProductsQty.clear();
    recived_bloc.instance.add(clearRecivedDetails_Event());
    contTotalValueFrom.text = contTotalValueTo.text = '';
  }

  void calcSumValue() {
    contTotalValueFrom.text =
        recived_bloc.instance.filterdLst_RecivedDetails.fold(0.0, (previousValue, element) => previousValue + element.TotalPrice!).toStringAsFixed(2);
    contTotalValueTo.text = '0';
    //recived_bloc.instance.filterdLst_RecivedDetails
    //     .fold(0.0, (previousValue, element) => previousValue + element.TotalPriceTo!)
    //     .toStringAsFixed(2);
  }

  void newMode() async {
    bllInv_RecivedQty.getMax_firestore(enTable_Inv_RecivedQty.Code).then((val) {
      contCode.text = val.toString();
    }).toString();
    contDate.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    contTime.text = sharedFunctions_Dates.convertDateTime_TimeString(DateTime.now());
  }

  void newModeWithTransferQty(Inv_Transfer? itemTransfer) async {
    // selectedID = itemTransfer!.ID!;
    bllInv_RecivedQty.getMax_firestore(enTable_Inv_RecivedQty.Code).then((val) {
      contCode.text = val.toString();
    }).toString();
    contDate.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    contTime.text = sharedFunctions_Dates.convertDateTime_TimeString(DateTime.now());

    // contCode.text = itemTransfer.Code!.toString();
    // contDate.text = itemTransfer.Date!;
    // contTime.text = itemTransfer.Time!;
    requestStatusID = en_RequestStatus.ReceivedReview.value;

    branchIDFromRecived = itemTransfer!.IDBranchFrom;
    branchIDToRecived = itemTransfer.IDBranchTo;
    stock_bloc.instance.add(
      getLstStocksAsDataSource_Event(
        branchID: branchIDFromRecived,
        branchID2: branchIDToRecived,
        condions: [
          BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchIDFromRecived),
          BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchIDToRecived),
        ],
      ),
    );
    stockIDFromRecived = itemTransfer.IDStockFrom!;
    stockIDToRecived = itemTransfer.IDStockTo!;
    contEmployee.selectEmployee = await bllDealing_Employees.fire_getItem(itemTransfer.IDEmployee!.toString());
    contEmployee.text = contEmployee.selectEmployee!.Name!;
    ctr_SelectEmployee.branchID = branchIDFromRecived;

    // contNote.text = itemTransfer.Note!;
    contTotalValueFrom.text = itemTransfer.TotalValueFrom.toString();
    contTotalValueTo.text = itemTransfer.TotalValueTo.toString();

    //********************** Details ******************************
    // List<BLLCondions> cond = [
    //   BLLCondions(enTable_Inv_ProductsQty.IDDocumentType.name, en_CondionsWhere.isEqualTo, en_DocumentType.transfer.value),
    //   BLLCondions(enTable_Inv_ProductsQty.IDDocument.name, en_CondionsWhere.isEqualTo, selectedID),
    // ];
    List<Inv_TransferDetails> lstTransferDetails = [];
    await transfer_bloc.instance.getList_transferDetails(itemTransfer.ID!).then((val) {
      lstTransferDetails = val;
    });
    lstTransferDetails.forEach((elm) {
      recived_bloc.instance.filterdLst_RecivedDetails.add(Inv_RecivedQtyDetails(
        ID: recived_bloc.instance.filterdLst_RecivedDetails.length + 1,
        IDProduct: elm.IDProduct,
        Barcode: elm.Barcode,
        IDClassefication: elm.IDClassefication,
        IDProductionCompanies: elm.IDProductionCompanies,
        PriceType: elm.PriceType,
        UnitBig_ID: elm.UnitBig_ID,
        UnitBig_Qty: elm.UnitBig_Qty,
        UnitBig_Price: elm.UnitBig_Price,
        isBigUnit: elm.isBigUnit,
        UnitCountOf: elm.UnitCountOf,
        UnitSmall_ID: elm.UnitSmall_ID,
        UnitSmall_Qty: elm.UnitSmall_Qty,
        UnitSmall_Price: elm.UnitSmall_Price,
        TotalPrice: elm.TotalPrice,
        RecivedTotalPrice: 0,
        RecivedUnitBig_Price: 0,
        RecivedUnitSmall_Price: 0,
        RecivedUnitBig_ID: elm.UnitBig_ID,
        RecivedUnitBig_Qty: elm.UnitBig_Qty,
        RecivedUnitSmall_ID: elm.UnitSmall_ID,
        RecivedUnitSmall_Qty: elm.UnitSmall_Qty,
        RecivedisBigUnit: elm.isBigUnit,
      ));
    });
    // لتحديث اللسته بعد التعبئة وعرضها فى الشاشة
    recived_bloc.instance.add(refreshRecivedDetails_Event());
  }

  void editMode() async {
    selectedID = widget.itemRecived!.ID!;
    contCode.text = widget.itemRecived!.Code.toString();
    contDate.text = widget.itemRecived!.Date!;
    contTime.text = widget.itemRecived!.Time!;
    requestStatusID = widget.itemRecived!.IDRequestStatus;

    branchIDFromRecived = widget.itemRecived!.IDBranchFrom;
    branchIDToRecived = widget.itemRecived!.IDBranchTo;
    stock_bloc.instance.add(
      getLstStocksAsDataSource_Event(
        branchID: branchIDFromRecived,
        branchID2: branchIDToRecived,
        condions: [
          BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchIDFromRecived),
          BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchIDToRecived),
        ],
      ),
    );
    stockIDFromRecived = widget.itemRecived!.IDStockFrom!;
    stockIDToRecived = widget.itemRecived!.IDStockTo!;
    contEmployee.selectEmployee = await bllDealing_Employees.fire_getItem(widget.itemRecived!.IDEmployee!.toString());
    contEmployee.text = contEmployee.selectEmployee!.Name!;
    ctr_SelectEmployee.branchID = branchIDFromRecived;

    contNote.text = widget.itemRecived!.Note!;
    contTotalValueFrom.text = widget.itemRecived!.TotalValueFrom.toString();
    contTotalValueTo.text = widget.itemRecived!.TotalValueTo.toString();
    recived_bloc.instance.add(getListRecivedDetails_Event(widget.itemRecived!.ID!));

    List<BLLCondions> cond = [
      BLLCondions(enTable_Inv_ProductsQty.IDDocumentType.name, en_CondionsWhere.isEqualTo, en_DocumentType.recivedQty.value),
      BLLCondions(enTable_Inv_ProductsQty.IDDocument.name, en_CondionsWhere.isEqualTo, selectedID),
    ];
    lstProductsQty = await bllInv_ProductsQty.fire_getListWithConditions(conditions: cond);
  }

  bool checkIsSentDocument() {
    if (widget.frmMode == en_FormMode.EditMode &&
        (widget.itemRecived!.IDRequestStatus == en_RequestStatus.Sent.value ||
            widget.itemRecived!.IDRequestStatus == en_RequestStatus.ReceivedReview.value ||
            widget.itemRecived!.IDRequestStatus == en_RequestStatus.ReviewError.value ||
            widget.itemRecived!.IDRequestStatus == en_RequestStatus.Received.value))
      return true;
    else
      return false;
  }

  recivedQtyDetails(Inv_RecivedQtyDetails itemDetails, int index) async {
    itemDetails.RecivedisBigUnit = itemDetails.RecivedisBigUnit ?? itemDetails.isBigUnit!;
    itemDetails.RecivedUnitSmall_Qty = itemDetails.RecivedUnitSmall_Qty ?? itemDetails.UnitSmall_Qty!;
    itemDetails.RecivedUnitBig_Qty = itemDetails.RecivedUnitBig_Qty ?? itemDetails.UnitBig_Qty!;

    await ctr_SelectProduct(onAddProduct: (c) {})
      ..editProduct(
        context,
        itemDetails.IDProduct!,
        itemDetails.PriceType!,
        itemDetails.isBigUnit!,
        itemDetails.RecivedisBigUnit! ? itemDetails.UnitBig_Price! : itemDetails.UnitSmall_Price!,
        itemDetails.RecivedisBigUnit! ? itemDetails.RecivedUnitBig_Qty! : itemDetails.RecivedUnitSmall_Qty!,
        // index,
      ).then((cProduct) {
        if (cProduct != null) {
          recived_bloc.instance.add(editRowRecivedDetails_Event(itemCustomProduct: cProduct, index: index));
        }
      });
  }

  void deletItemDetails(Inv_RecivedQtyDetails itemDetails) {
    sharedControls.confirmDelete(
      context,
      product_bloc.instance.getNameByID(itemDetails.IDProduct),
      () {
        recived_bloc.instance.add(deleteItemRecivedDetails_Event(itemDetails: itemDetails));
        lstDetailsDeleted.add(itemDetails);
        calcSumValue();
      },
    );
  }

  bool otherValidate() {
    String errorMessage = '';

    if (contEmployee.selectEmployee == null) {
      errorMessage = 'لابد من إختيار القائم بالطلب';
    } else if (contEmployee.selectEmployee == null) {
      errorMessage = 'لابد من إختيار القائم بالطلب';
    }

    if (errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          errorMessage,
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.red[800],
      ));
      return false;
    }
    return true;
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate() && otherValidate()) {
      //********************************************************************
      if (widget.frmMode == en_FormMode.NewMode) {
        selectedID = await bllInv_RecivedQty.getMaxID_firestore();
        widget.itemRecived = Inv_RecivedQty();
      } else if (widget.frmMode == en_FormMode.EditMode) {
        selectedID = widget.itemRecived!.ID!;
      }
      widget.itemRecived!.ID = selectedID;
      widget.itemRecived!.Code = int.tryParse(contCode.text);
      widget.itemRecived!.Date = contDate.text;
      widget.itemRecived!.Time = contTime.text;
      widget.itemRecived!.IDRequestStatus = requestStatusID;
      widget.itemRecived!.IDBranchFrom = branchIDFromRecived;
      widget.itemRecived!.IDStockFrom = stockIDFromRecived;
      widget.itemRecived!.IDEmployee = contEmployee.selectEmployee!.ID;
      widget.itemRecived!.IDBranchTo = branchIDToRecived;
      widget.itemRecived!.IDStockTo = stockIDToRecived;
      widget.itemRecived!.Note = contNote.text;
      widget.itemRecived!.UID = sharedHive.UID;
      widget.itemRecived!.TotalValueFrom = double.parse(contTotalValueFrom.text);
      widget.itemRecived!.TotalValueTo = double.parse(contTotalValueTo.text);

      // حفظ الاساسي والتفاصيل مره واحده
      await bllInv_RecivedQty.fire_setListMaster_And_Details(
        insertdDocID: selectedID.toString(),
        itemInv_RecivedQty: widget.itemRecived!,
        collectionDetailsName: en_TablesName.Inv_RecivedQtyDetails.name,
        columnNameAsDocumentDetails: enTable_Inv_RecivedQtyDetails.ID.name,
        detais: recived_bloc.instance.filterdLst_RecivedDetails.map((elm) => elm.toMap()).toList(),
        deletedItemsDetais: lstDetailsDeleted.map((elm) => elm.toMap()).toList(),
      );

      Navigator.pop(context, true);
    }
  }

  void saveProductsQty() {
    // حذف الأصناف من الجرد
    if (lstDetailsDeleted.length > 0) {
      List<BLLCondions> cond = [];
      lstDetailsDeleted.forEach((del) {
        cond = [
          BLLCondions(enTable_Inv_ProductsQty.IDProduct.name, en_CondionsWhere.isEqualTo, del.IDProduct),
          BLLCondions(enTable_Inv_ProductsQty.LineNumber.name, en_CondionsWhere.isEqualTo, del.ID),
          BLLCondions(enTable_Inv_ProductsQty.IDDocumentType.name, en_CondionsWhere.isEqualTo, en_DocumentType.recivedQty.value),
          BLLCondions(enTable_Inv_ProductsQty.IDDocument.name, en_CondionsWhere.isEqualTo, selectedID),
        ];
      });
      bllInv_ProductsQty.fire_DeleteListMaster(cond);
    }

    // اللف على تفاصيل الفاتورة لأخذ بيانات الأصناف وحفظها فى الجرد
    int index = 1;
    Inv_ProductsQty? itemProductsQty;

    for (var itemDetails in recived_bloc.instance.filterdLst_RecivedDetails) {
      itemProductsQty = lstProductsQty.where((itm) {
        return itm.LineNumber == itemDetails.ID && itm.IDDocument == selectedID && itm.IDDocumentType == en_DocumentType.recivedQty.value;
      }).firstOrNull;

      // لو فاضي يبقي صنف جديد
      if (itemProductsQty == null) {
        itemProductsQty = Inv_ProductsQty();
        itemProductsQty.ID = '${itemDetails.IDProduct}-${index}-${en_TablesName.Inv_RecivedQty.name}-${selectedID}';
        lstProductsQty.add(itemProductsQty);
      }
      itemProductsQty.DateInserted = contDate.text;
      itemProductsQty.IDDocument = selectedID;
      itemProductsQty.IDDocumentType = en_DocumentType.recivedQty.value;
      itemProductsQty.DocumentTypeName = en_DocumentType.recivedQty .name;;
      itemProductsQty.IDStock = stockIDFromRecived;
      itemProductsQty.StockName = stock_bloc.instance.getNameByID(stockIDFromRecived);
      itemProductsQty.LineNumber = index;
      itemProductsQty.BarCode = itemDetails.Barcode;
      itemProductsQty.IDProduct = itemDetails.IDProduct;
      itemProductsQty.ProductName = product_bloc.instance.getNameByID(itemDetails.IDProduct);
      itemProductsQty.IDClassefications = itemDetails.IDClassefication;
      itemProductsQty.ClasseficationsName = categories_bloc.instance.getNameByID(itemDetails.IDClassefication);
      itemProductsQty.IDProductionCompanies = itemDetails.IDProductionCompanies;
      itemProductsQty.ProductionCompaniesName = productionCom_bloc.instance.getNameByID(itemDetails.IDProductionCompanies);
      itemProductsQty.IDUnit = itemDetails.UnitSmall_ID;
      itemProductsQty.UnitName = unit_bloc.instance.getNameByID(itemDetails.UnitSmall_ID);
      itemProductsQty.QtyBefore = 0;
      itemProductsQty.Qty = itemDetails.UnitSmall_Qty! * -1;
      itemProductsQty.QtyRepresents = 0;
      itemProductsQty.TotalQty = itemProductsQty.Qty;
      itemProductsQty.QtyAfter = 0;
      itemProductsQty.Price = itemDetails.UnitSmall_Price;
      itemProductsQty.TotalPrice = itemDetails.TotalPrice;
      itemProductsQty.IDPriceType = itemDetails.PriceType;
      itemProductsQty.PriceTypeName = priceType_bloc.instance.getNameByID(itemDetails.PriceType);
      index++;
    }
    bllInv_ProductsQty.fire_setListMaster(lstInv_ProductsQty: lstProductsQty);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/bllFirebase/bllDef_Stocks.dart';
import 'package:vigil_erp/bll/classModel/Def_ProductStructure.dart';
import 'package:vigil_erp/bll/classModel/Def_Units.dart';

import 'package:vigil_erp/blocManagment/blocDealing/dealing_bloc.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/blocManagment/blocFixTables/fix_table_bloc.dart';
import 'package:vigil_erp/blocManagment/blocInventory/inv_bloc.dart';
import 'package:vigil_erp/blocManagment/general/cubitGeneral.dart';
import 'package:vigil_erp/blocManagment/general/cubitStates.dart';
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
import '../../../bll/bllFirebase/bllInv_Transfer.dart';
import '../../../bll/classModel/Def_Categories.dart';
import '../../../bll/classModel/Def_Stocks.dart';
import '../../../bll/classModel/Inv_ProductsQty.dart';
import '../../../bll/classModel/Inv_Transfer.dart';
import '../../../bll/classModel/Inv_TransferDetails.dart';
import '../../../bll/classModel/Inv_Transfer.dart';

class scr_TransferItem extends StatefulWidget {
  scr_TransferItem(this.itemTransfer, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Inv_Transfer? itemTransfer;
  en_FormMode frmMode;

  @override
  State<scr_TransferItem> createState() => _scr_TransferItemState();
}

var frmKey = GlobalKey<FormState>();

List<Inv_TransferDetails> lstDetailsDeleted = [];
int selectedID = -1;
int? branchIDFrom;
int? branchIDTo;
int? stockIDFrom;
int? stockIDTo;
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

class _scr_TransferItemState extends State<scr_TransferItem> {
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
      endDrawer: buildDrawerProductsInvoice(context),
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
              text: 'بيانات تحويل الأصناف',
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
                    lstDataSource: requestStatus_bloc.instance.lstRequestStatusAsDataSource,
                    hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                    itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                    menuMaxHeightValue: 300,
                    showClearIcon: true,
                    selectedValue: requestStatusID =
                        requestStatus_bloc.instance.lstRequestStatusAsDataSource.length > 0 && widget.frmMode == en_FormMode.NewMode
                            ? requestStatus_bloc.instance.lstRequestStatusAsDataSource.first.valueMember
                            : requestStatusID,
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
                    Row(
                      children: [
                        Text('الأصناف', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        SizedBox(width: 20),
                        IconButton(
                            onPressed: () {
                              if (stockIDFrom == null) {
                                sharedControls.toastNotification('لابد من إختيار الفرع والمخزن أولاً لإضافة الأصناف', false);
                                return;
                              }

                              if (widget.scaffoldKey.currentState != null) {
                                widget.scaffoldKey.currentState!.openEndDrawer();
                              }
                            },
                            icon: Icon(
                              Icons.production_quantity_limits,
                              color: Colors.red,
                              size: 35,
                            ))
                      ],
                    )
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
        selectedValue: branchIDFrom,
        OnChanged: (returnID) {
          branchIDFrom = returnID;
          // reset Employee and populate with New branch
          contEmployee.selectEmployee = null;
          contEmployee.text = '';
          employee_bloc.instance.add(getLstEmployeeAsDataSource_Event());
          ctr_SelectEmployee.branchID = branchIDFrom;

          // reset Stock and populate with New branch
          stockIDFrom = null;
          stock_bloc.instance.add(
            getLstStocksAsDataSource_Event(
              branchID: branchIDFrom,
              branchID2: branchIDTo,
              condions: [
                BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchIDFrom),
                BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchIDTo),
              ],
            ),
          );

          stockIDFrom =
              stock_bloc.instance.LstStocksAsDataSource.length > 0 ? stock_bloc.instance.LstStocksAsDataSource.first.valueMember : stockIDFrom;
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
          List<DropDowenDataSource> lstStocks =
              branchIDFrom != null && isStockState ? (state as getLstStocksAsDataSource_State).LstStocksAsDataSource : [];

          return ctr_DropDowenList(
            hintLable: 'من مخزن',
            padding: EdgeInsets.only(right: 5, left: 0),
            lstDataSource: lstStocks,
            hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
            itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
            menuMaxHeightValue: 300,
            showClearIcon: true,
            selectedValue: stockIDFrom = lstStocks.length > 0 && widget.frmMode == en_FormMode.NewMode ? lstStocks.first.valueMember : stockIDFrom,
            OnChanged: (returnID) {
              stockIDFrom = returnID;
              return stockIDFrom;
            },
            OnValidate: (value) {
              stockIDFrom = value;
              if (value == null || stockIDFrom == null) {
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
        selectedValue: branchIDTo,
        OnChanged: (returnID) {
          branchIDTo = returnID;
          // reset Stock and populate with New branch
          stockIDTo = null;
          stock_bloc.instance.add(
            getLstStocksAsDataSource_Event(
              branchID: branchIDFrom,
              branchID2: branchIDTo,
              condions: [
                BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchIDFrom),
                BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchIDTo),
              ],
            ),
          );
          stockIDTo =
              stock_bloc.instance.LstStocksAsDataSource2.length > 0 ? stock_bloc.instance.LstStocksAsDataSource2.first.valueMember : stockIDTo;
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
          List<DropDowenDataSource> lstStocksTo =
              branchIDTo != null && isStockStateTo ? (state as getLstStocksAsDataSource_State).LstStocksAsDataSource2 : [];

          return ctr_DropDowenList(
            hintLable: 'إلى مخزن',
            padding: EdgeInsets.only(right: 5, left: 0),
            lstDataSource: lstStocksTo,
            hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
            itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
            menuMaxHeightValue: 300,
            showClearIcon: true,
            selectedValue: stockIDTo = lstStocksTo.length > 0 && widget.frmMode == en_FormMode.NewMode ? lstStocksTo.first.valueMember : stockIDTo,
            OnChanged: (returnID) {
              stockIDTo = returnID;
              return stockIDTo;
            },
            OnValidate: (value) {
              stockIDTo = value;
              if (value == null || stockIDTo == null) {
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
            'تم الإرسال',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.blue[800]),
          ),
          icon: Icon(Icons.done_outline),
          style: ElevatedButton.styleFrom(elevation: 3, backgroundColor: Colors.white),
          onPressed: () {
            sharedControls.confirmDialog(
                context, 'تأكيد إرسال', 'فى حالة تأكيد الإرسال سيتم التأثير على رصيد المخزن وإغلاق المستند ولا يمكن التعديل فيه نهائياً', () {
              requestStatusID = en_RequestStatus.Sent.value;
              saveData();
              saveProductsQty();
            });
          },
        ),
    ]));
  }

  Widget BuildListView(BuildContext context) {
    return BlocBuilder<transfer_bloc, inv_state>(
      builder: (context, state) {
        if (state is transferDetails_StateInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is transferDetails_StateDataChanged) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                // Filter
                SizedBox(
                  height: 60,
                  width: 690,
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
                              transfer_bloc.instance.add(filterAnyTransferDetails_Event(filterData: value.trim()));
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          contFilter.clear();
                          transfer_bloc.instance.add(resetFilterTransferDetails_Event());
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ],
                  ),
                ),

                // Column Header
                Container(
                  color: Colors.grey[300],
                  width: 690,
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
                          child:
                              Text('الكمية والسعر', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
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
                    width: 690,
                    height: 500,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(right: 2, left: 2),
                      itemBuilder: (context, index) {
                        return buildListViewItem(state.filterdLst_TransferDetails[index], context, index);
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 1),
                      itemCount: state.filterdLst_TransferDetails.length,
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

  buildListViewItem(Inv_TransferDetails itemDetails, context, int index) {
    return InkWell(
      onDoubleTap: () => editItemDetails(itemDetails, index),
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
                          editItemDetails(itemDetails, index);
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

  Widget buildDrawerProductsInvoice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Drawer(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, right: 5, bottom: 10, left: 0),
                child: ctr_SelectProduct(
                  onAddProduct: (customProductItem prod) {
                    transfer_bloc.instance.add(addNewTransferDetails_Event(itemCustomProduct: prod, stockID: stockIDFrom));
                    calcSumValue();
                  },
                  priceTypeID: en_PriceType.salesPrice1.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCalcSummtion() {
    return Container(
      color: Colors.yellow[200],
      child: BlocBuilder<transfer_bloc, inv_state>(
        builder: (context, state) {
          if (state is transferDetails_StateDataChanged) {
            contTotalValueFrom.text =
                state.filterdLst_TransferDetails.fold(0.0, (previousValue, element) => previousValue + element.TotalPrice!).toStringAsFixed(2);

            return Row(
              children: [
                Text('العدد:', style: const TextStyle(fontSize: 14)),
                Text('${state.filterdLst_TransferDetails.length}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('   الكمية :', style: const TextStyle(fontSize: 14)),
                Text('${state.filterdLst_TransferDetails.fold(0, (previousValue, element) => previousValue + element.UnitSmall_Qty!)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('    الإجمالى:', style: const TextStyle(fontSize: 14)),
                Text(
                    '${state.filterdLst_TransferDetails.fold(0.0, (previousValue, element) => previousValue + element.TotalPrice!).toStringAsFixed(2)}',
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

    if (widget.frmMode == en_FormMode.NewMode)
      NewMode();
    else if (widget.frmMode == en_FormMode.EditMode) {
      EditMode();
    }
  }

  Widget buildCustomBar() {
    return Row(
      children: [
        if (!checkIsSentDocument())
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

  @override
  void dispose() {
    super.dispose();
  }

  void clearCachedData() {
    branchIDFrom = branchIDTo = stockIDTo = stockIDFrom = contEmployee.selectEmployee = ctr_SelectEmployee.branchID = requestStatusID = null;
    contEmployee.text = '';
    employee_bloc.instance.add(resetFilterEmployee_Event());
    lstDetailsDeleted.clear();
    lstProductsQty.clear();
    transfer_bloc.instance.add(clearTransferDetails_Event());
    contTotalValueFrom.text = contTotalValueTo.text = '';
  }

  void calcSumValue() {
    contTotalValueFrom.text = transfer_bloc.instance.filterdLst_TransferDetails
        .fold(0.0, (previousValue, element) => previousValue + element.TotalPrice!)
        .toStringAsFixed(2);
    contTotalValueTo.text = '0';
    //transfer_bloc.instance.filterdLst_TransferDetails
    //     .fold(0.0, (previousValue, element) => previousValue + element.TotalPriceTo!)
    //     .toStringAsFixed(2);
  }

  void NewMode() async {
    bllInv_Transfer.getMax_firestore(enTable_Inv_Transfer.Code).then((val) {
      contCode.text = val.toString();
    }).toString();
    contDate.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    contTime.text = sharedFunctions_Dates.convertDateTime_TimeString(DateTime.now());
  }

  void EditMode() async {
    selectedID = widget.itemTransfer!.ID!;
    contCode.text = widget.itemTransfer!.Code.toString();
    contDate.text = widget.itemTransfer!.Date!;
    contTime.text = widget.itemTransfer!.Time!;
    requestStatusID = widget.itemTransfer!.IDRequestStatus;

    branchIDFrom = widget.itemTransfer!.IDBranchFrom;
    branchIDTo = widget.itemTransfer!.IDBranchTo;
    stock_bloc.instance.add(
      getLstStocksAsDataSource_Event(
        branchID: branchIDFrom,
        branchID2: branchIDTo,
        condions: [
          BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchIDFrom),
          BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchIDTo),
        ],
      ),
    );
    stockIDFrom = widget.itemTransfer!.IDStockFrom!;
    stockIDTo = widget.itemTransfer!.IDStockTo!;
    contEmployee.selectEmployee = await bllDealing_Employees.fire_getItem(widget.itemTransfer!.IDEmployee!.toString());
    contEmployee.text = contEmployee.selectEmployee!.Name!;
    ctr_SelectEmployee.branchID = branchIDFrom;

    contNote.text = widget.itemTransfer!.Note!;
    contTotalValueFrom.text = widget.itemTransfer!.TotalValueFrom.toString();
    contTotalValueTo.text = widget.itemTransfer!.TotalValueTo.toString();
    transfer_bloc.instance.add(getListTransferDetails_Event(widget.itemTransfer!.ID!));

    List<BLLCondions> cond = [
      BLLCondions(enTable_Inv_ProductsQty.IDDocumentType.name, en_CondionsWhere.isEqualTo, en_DocumentType.transfer.value),
      BLLCondions(enTable_Inv_ProductsQty.IDDocument.name, en_CondionsWhere.isEqualTo, selectedID),
    ];
    lstProductsQty = await bllInv_ProductsQty.fire_getListWithConditions(conditions: cond);
  }

  bool checkIsSentDocument() {
    if (widget.frmMode == en_FormMode.EditMode && widget.itemTransfer!.IDRequestStatus == en_RequestStatus.Sent.value)
      return true;
    else
      return false;
  }

  void editItemDetails(Inv_TransferDetails itemDetails, index) async {
    await ctr_SelectProduct(onAddProduct: (c) {})
      ..editProduct(
        context,
        itemDetails.IDProduct!,
        itemDetails.PriceType!,
        itemDetails.isBigUnit!,
        itemDetails.isBigUnit! ? itemDetails.UnitBig_Price! : itemDetails.UnitSmall_Price!,
        itemDetails.isBigUnit! ? itemDetails.UnitBig_Qty! : itemDetails.UnitSmall_Qty!,
        // index,
      ).then((cProduct) {
        if (cProduct != null) {
          transfer_bloc.instance.add(editRowTransferDetails_Event(itemCustomProduct: cProduct, index: index));
        }
      });
  }

  void deletItemDetails(Inv_TransferDetails itemDetails) {
    sharedControls.confirmDelete(
      context,
      product_bloc.instance.getNameByID(itemDetails.IDProduct),
      () {
        transfer_bloc.instance.add(deleteItemTransferDetails_Event(itemDetails: itemDetails));
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
        selectedID = await bllInv_Transfer.getMaxID_firestore();
        widget.itemTransfer = Inv_Transfer();
      } else if (widget.frmMode == en_FormMode.EditMode) {
        selectedID = widget.itemTransfer!.ID!;
      }

      widget.itemTransfer!.ID = selectedID;
      widget.itemTransfer!.Code = int.tryParse(contCode.text);
      widget.itemTransfer!.Date = contDate.text;
      widget.itemTransfer!.Time = contTime.text;
      widget.itemTransfer!.IDRequestStatus = requestStatusID;

      widget.itemTransfer!.IDBranchFrom = branchIDFrom;
      widget.itemTransfer!.IDStockFrom = stockIDFrom;
      widget.itemTransfer!.IDEmployee = contEmployee.selectEmployee!.ID;

      widget.itemTransfer!.IDBranchTo = branchIDTo;
      widget.itemTransfer!.IDStockTo = stockIDTo;

      widget.itemTransfer!.Note = contNote.text;
      widget.itemTransfer!.UID = sharedHive.UID;
      widget.itemTransfer!.TotalValueFrom = double.parse(contTotalValueFrom.text);
      widget.itemTransfer!.TotalValueTo = double.parse(contTotalValueTo.text);

      // حفظ الاساسي والتفاصيل مره واحده
      await bllInv_Transfer.fire_setListMaster_And_Details(
        insertdDocID: selectedID.toString(),
        itemInv_Transfer: widget.itemTransfer!,
        collectionDetailsName: en_TablesName.Inv_TransferDetails.name,
        columnNameAsDocumentDetails: enTable_Inv_TransferDetails.ID.name,
        detais: transfer_bloc.instance.filterdLst_TransferDetails.map((elm) => elm.toMap()).toList(),
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
          BLLCondions(enTable_Inv_ProductsQty.IDDocumentType.name, en_CondionsWhere.isEqualTo, en_DocumentType.transfer.value),
          BLLCondions(enTable_Inv_ProductsQty.IDDocument.name, en_CondionsWhere.isEqualTo, selectedID),
        ];
      });
      bllInv_ProductsQty.fire_DeleteListMaster(cond);
    }

    // اللف على تفاصيل الفاتورة لأخذ بيانات الأصناف وحفظها فى الجرد
    int index = 1;
    Inv_ProductsQty? itemProductsQty;

    for (var itemDetails in transfer_bloc.instance.filterdLst_TransferDetails) {
      itemProductsQty = lstProductsQty.where((itm) {
        return itm.LineNumber == itemDetails.ID && itm.IDDocument == selectedID && itm.IDDocumentType == en_DocumentType.transfer.value;
      }).firstOrNull;

      // لو فاضي يبقي صنف جديد
      if (itemProductsQty == null) {
        itemProductsQty = Inv_ProductsQty();
        itemProductsQty.ID = '${itemDetails.IDProduct}-${index}-${en_TablesName.Inv_Transfer.name}-${selectedID}';
        lstProductsQty.add(itemProductsQty);
      }
      itemProductsQty.DateInserted = contDate.text;
      itemProductsQty.IDDocument = selectedID;
      itemProductsQty.IDDocumentType = en_DocumentType.transfer.value;
      itemProductsQty.DocumentTypeName = requestStatus_bloc.instance.getNameByID(en_DocumentType.transfer.value);
      itemProductsQty.IDStock = stockIDFrom;
      itemProductsQty.StockName = stock_bloc.instance.getNameByID(stockIDFrom);
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

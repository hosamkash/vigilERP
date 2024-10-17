import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/classModel/Def_ProductStructure.dart';
import 'package:vigil_erp/bll/classModel/Def_Units.dart';
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
import '../../../bll/bllFirebase/bllInv_PermissionDiscount.dart';
import '../../../bll/bllFirebase/bllInv_ProductsQty.dart';
import '../../../bll/classModel/Def_Categories.dart';
import '../../../bll/classModel/Def_Stocks.dart';
import '../../../bll/classModel/Inv_PermissionDiscount.dart';
import '../../../bll/classModel/Inv_PermissionDiscountDetails.dart';
import '../../../bll/classModel/Inv_ProductsQty.dart';

class scr_PermissionDiscountItem extends StatefulWidget {
  scr_PermissionDiscountItem(this.itemPermissionDiscount, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Inv_PermissionDiscount? itemPermissionDiscount;
  en_FormMode frmMode;

  @override
  State<scr_PermissionDiscountItem> createState() => _scr_PermissionDiscountItemState();
}

var frmKey = GlobalKey<FormState>();
List<Inv_PermissionDiscountDetails> lstDetailsDeleted = [];
int selectedID = -1;
int? branchID;
int? stockID;
TextEditingController_Employee contEmployee = TextEditingController_Employee();
TextEditingController contCode = TextEditingController();
TextEditingController contDate = TextEditingController();
TextEditingController contTime = TextEditingController();
TimeOfDay? timeWorkFrom;
int? requestStatusID;
TextEditingController contNote = TextEditingController();
TextEditingController contValue = TextEditingController();

final TextEditingController contQty = TextEditingController();
final TextEditingController contPrice = TextEditingController();
bool? isBigUnit;
// List<DropDowenDataSource> lstStocksAsDataSource = [];
List<Inv_ProductsQty> lstProductsQty = [];
TextEditingController controllerfilter = TextEditingController();

class _scr_PermissionDiscountItemState extends State<scr_PermissionDiscountItem> {
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
      body: SingleChildScrollView(
        child: buildPageContent(),
      ),
    );
  }

  Widget buildPageContent() {
    return Form(
      key: frmKey,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            ctr_TextHeaderPage(
              text: 'بيانات إذن الخصم',
              color: checkIsRecivedDocument() ? Colors.red[100] : Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            ctr_DropDowenList(
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

                // reset Stock and populate with New branch
                stockID = null;
                stock_bloc.instance.add(getLstStocksAsDataSource_Event(
                    branchID: branchID, condions: [BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchID)]));

                // stockID = stock_bloc.instance.LstStocksAsDataSource.length > 0 && widget.frmMode == en_FormMode.NewMode
                //     ? stock_bloc.instance.LstStocksAsDataSource.first.valueMember
                //     : stockID;
                return null;
              },
              OnValidate: (value) {
                if (value == null) {
                  return 'لابد من إختيار قيمة';
                }
                return null;
              },
            ),
            SizedBox(
              height: 600,
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
                              print('00000000000000000000');
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
          ],
        ),
      ),
    );
  }

  Widget BuildMasterData() {
    return SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [

      BlocBuilder<stock_bloc, definition_state>(
        builder: (context, state) {
          bool isStockState = state is getLstStocksAsDataSource_State;
          List<DropDowenDataSource> lstStocks =
              branchID != null && isStockState ? (state as getLstStocksAsDataSource_State).LstStocksAsDataSource : [];

          return ctr_DropDowenList(
            hintLable: 'المخزن',
            padding: EdgeInsets.only(right: 5, left: 5),
            lstDataSource: lstStocks,
            hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
            itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
            menuMaxHeightValue: 300,
            showClearIcon: true,
            selectedValue: stockID = lstStocks.length > 0 && widget.frmMode == en_FormMode.NewMode ? lstStocks.first.valueMember : stockID,
            OnChanged: (returnID) {
              stockID = returnID;
              return stockID;
            },
            OnValidate: (value) {
              stockID = value;
              if (value == null || stockID == null) {
                return 'لابد من إختيار قيمة';
              }
              return null;
            },
          );
        },
      ),
      Row(
        children: [
          ctr_SelectEmployee(
            Controller: contEmployee,
            padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
            labelText: 'القائم بالطلب',
            isOpenSelectorOnTap: true,
            // branchID: branchID,
            onSelectEmployee: (Dealing) {
              print(Dealing.Name);
              contEmployee.selectEmployee = Dealing;
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
      Row(
        children: [
          SizedBox(
            width: 80,
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
          Expanded(
            child: ctr_DropDowenList(
              hintLable: 'حالة الطلب',
              padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
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
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: ctr_Date(
              text: 'التاريخ',
              dtController: contDate,
              padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
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
              padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
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

          SizedBox(height: 20),
          if(!checkIsRecivedDocument())
          ElevatedButton.icon(

            label: Text(
              'تم الإستلام',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.blue[800]),
            ),
            icon: Icon(Icons.done_outline),
            style: ElevatedButton.styleFrom(elevation: 3, backgroundColor: Colors.white),
            onPressed: () {
              sharedControls.confirmDialog(
                  context,'تأكيد الإستلام' ,
                  'فى حالة تأكيد الإستلام سيتم التأثير على رصيد المخزن وإغلاق المستند ولا يمكن التعديل فيه نهائياً',
                      () {
                    requestStatusID = en_RequestStatus.Received.value;
                    saveData();
                    saveProductsQty();
                  });
            },
          ),

    ]));
  }

  BuildListView(BuildContext context) {
    return BlocBuilder<permissionDiscount_bloc, inv_state>(
      builder: (context, state) {
        if (state is permissionDiscountDetails_StateInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is permissionDiscountDetails_StateDataChanged) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                // Filter
                SizedBox(
                  height: 60,
                  width: 670,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 300,
                        child: ctr_TextFormField(
                          Controller: controllerfilter,
                          PrefixIcon: const Icon(Icons.search),
                          padding: const EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 0),
                          OnChanged: (value) {
                            if (value != null) {
                              permissionDiscount_bloc.instance.add(filterAnyPermissionDiscountDetails_Event(filterData: value.trim()));
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controllerfilter.clear();
                          permissionDiscount_bloc.instance.add(resetFilterPermissionDiscountDetails_Event());
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ],
                  ),
                ),

                // Column Header
                Container(
                  color: Colors.grey[300],
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                  width: 670,
                  height: 30,
                  child: Row(
                    children: [
                      SizedBox(
                          width: 60,
                          child: Text('باركود', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 120,
                          child: Text('الصنف', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 90,
                          child: Text('تصنيف', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 90,
                          child: Text('فئة السعر', textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 220,
                          child:
                              Text('الكمية والسعر', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 90,
                          child: Text('  ', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),

                // ListView - Rows
                Expanded(
                  child: SizedBox(
                    width: 670,
                    height: 500,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildListViewItem(state.filterdLst_PermissionDiscountDetails[index], context, index);
                      },
                      itemCount: state.filterdLst_PermissionDiscountDetails.length,
                    ),
                  ),
                ),

                // Summary
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  buildListViewItem(Inv_PermissionDiscountDetails itemDetails, context, int index) {
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
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Text('${categories_bloc.instance.getNameByID(itemDetails.IDClassefication)}',
                      textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 90,
                  child: Text('${priceType_bloc.instance.getNameByID(itemDetails.PriceType)}',
                      textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  width: 60,
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
          child: Padding(
            padding: const EdgeInsets.only(top: 0, right: 5, bottom: 10, left: 0),
            child: BuildListView(context),
          ),
        ),

        // ***************  Summtion
        Container(
          color: Colors.yellow[200],
          child: BlocBuilder<permissionDiscount_bloc, inv_state>(
            builder: (context, state) {
              if (state is permissionDiscountDetails_StateDataChanged) {
                contValue.text = state.filterdLst_PermissionDiscountDetails
                    .fold(0.0, (previousValue, element) => previousValue + element.TotalPrice!)
                    .toStringAsFixed(2);

                return Row(
                  children: [
                    Text('العدد:', style: const TextStyle(fontSize: 14)),
                    Text('${state.filterdLst_PermissionDiscountDetails.length}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('   الكمية :', style: const TextStyle(fontSize: 14)),
                    Text('${state.filterdLst_PermissionDiscountDetails.fold(0, (previousValue, element) => previousValue + element.UnitSmall_Qty!)}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('    الإجمالى:', style: const TextStyle(fontSize: 14)),
                    Text(
                        '${state.filterdLst_PermissionDiscountDetails.fold(0.0, (previousValue, element) => previousValue + element.TotalPrice!).toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                );
              } else
                return SizedBox();
            },
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
                    permissionDiscount_bloc.instance.add(addNewPermissionDiscountDetails_Event(itemCustomProduct: prod));
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

  @override
  void initState() {
    super.initState();
    // List<BLLCondions>? condions=[
    //   BLLCondions(enTable_Def_Categories.IsActive.name, en_CondionsWhere.isEqualTo, true),
    // ];

    product_bloc.instance.add(getListProduct_Event([BLLCondions(enTable_Def_ProductStructure.IsActive.name, en_CondionsWhere.isEqualTo, true)]));
    requestStatus_bloc.instance.getLst_requestStatusAsDataSource();
    priceType_bloc.instance.getLst_PriceTypeAsDataSource();
    categories_bloc.instance.add(getListCategories_Event([BLLCondions(enTable_Def_Categories.IsActive.name, en_CondionsWhere.isEqualTo, true)]));
    categories_bloc.instance
        .getList_CategoryAsDataSource(condions: [BLLCondions(enTable_Def_Categories.IsActive.name, en_CondionsWhere.isEqualTo, true)]);
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
        if(!checkIsRecivedDocument())
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
    stockID = null;
    contEmployee.selectEmployee = null;
    contEmployee.text = '';
    ctr_SelectEmployee.branchID = branchID = null;
    employee_bloc.instance.add(resetFilterEmployee_Event());
    lstDetailsDeleted.clear();
    lstProductsQty.clear();
    permissionDiscount_bloc.instance.add(clearPermissionDiscountDetails_Event());
    requestStatusID = null;
  }

  void NewMode() async {
    bllInv_PermissionDiscount.getMax_firestore(enTable_Inv_PermissionDiscount.Code).then((val) {
      contCode.text = val.toString();
    }).toString();
    contDate.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    contTime.text = sharedFunctions_Dates.convertDateTime_TimeString(DateTime.now());
  }

  void EditMode() async {
    selectedID = widget.itemPermissionDiscount!.ID!;
    branchID = widget.itemPermissionDiscount!.IDBranch;
     stock_bloc.instance.add(getLstStocksAsDataSource_Event(condions: [BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchID)]));
    // stock_bloc.instance.getLstStockAsDataSource(condions: [BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchID)]);

    stockID = widget.itemPermissionDiscount!.IDStock!;
    requestStatusID = widget.itemPermissionDiscount!.IDRequestStatus!;
    contCode.text = widget.itemPermissionDiscount!.Code.toString();
    contEmployee.selectEmployee = await bllDealing_Employees.fire_getItem(widget.itemPermissionDiscount!.IDEmployee!.toString());
    contEmployee.text = contEmployee.selectEmployee!.Name!;
    ctr_SelectEmployee.branchID = branchID;
    contDate.text = widget.itemPermissionDiscount!.Date!;
    contTime.text = widget.itemPermissionDiscount!.Time!;
    contNote.text = widget.itemPermissionDiscount!.Note!;
    contValue.text = widget.itemPermissionDiscount!.Value.toString();
    permissionDiscount_bloc.instance.add(getListPermissionDiscountDetails_Event(widget.itemPermissionDiscount!.ID!));

    List<BLLCondions> cond = [
      BLLCondions(enTable_Inv_ProductsQty.IDDocumentType.name, en_CondionsWhere.isEqualTo, en_DocumentType.permissionDiscount.value),
      BLLCondions(enTable_Inv_ProductsQty.IDDocument.name, en_CondionsWhere.isEqualTo, selectedID),
    ];
    lstProductsQty = await bllInv_ProductsQty.fire_getListWithConditions(conditions: cond);
  }

  bool checkIsRecivedDocument() {
    if (widget.frmMode == en_FormMode.EditMode &&
        widget.itemPermissionDiscount!.IDRequestStatus == en_RequestStatus.Received.value)
      return true;
    else
      return false;
  }

  void editItemDetails(Inv_PermissionDiscountDetails itemDetails, index) async {
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
          permissionDiscount_bloc.instance.add(editRowPermissionDiscountDetails_Event(itemCustomProduct: cProduct, index: index));
        }
      });
  }

  void deletItemDetails(Inv_PermissionDiscountDetails itemDetails) {
    sharedControls.confirmDelete(
      context,
      product_bloc.instance.getNameByID(itemDetails.IDProduct),
      () {
        permissionDiscount_bloc.instance.add(deleteItemPermissionDiscountDetails_Event(itemDetails: itemDetails));
        lstDetailsDeleted.add(itemDetails);
      },
    );
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      //********************************************************************
      if (widget.frmMode == en_FormMode.NewMode) {
        selectedID = await bllInv_PermissionDiscount.getMaxID_firestore();
        widget.itemPermissionDiscount = Inv_PermissionDiscount();
      } else if (widget.frmMode == en_FormMode.EditMode) {
        selectedID = widget.itemPermissionDiscount!.ID!;
      }

      widget.itemPermissionDiscount!.ID = selectedID;
      widget.itemPermissionDiscount!.IDBranch = branchID;
      widget.itemPermissionDiscount!.Code = int.tryParse(contCode.text);
      widget.itemPermissionDiscount!.IDStock = stockID;
      widget.itemPermissionDiscount!.Date = contDate.text;
      widget.itemPermissionDiscount!.Time = contTime.text;
      widget.itemPermissionDiscount!.IDEmployee = contEmployee.selectEmployee!.ID;
      widget.itemPermissionDiscount!.IDRequestStatus = requestStatusID;
      widget.itemPermissionDiscount!.Note = contNote.text;
      widget.itemPermissionDiscount!.Value = contValue.text.isNotEmpty ? double.parse(contValue.text) : 0;
      widget.itemPermissionDiscount!.UID = sharedHive.UID;

      // حفظ الاساسي والتفاصيل مره واحده
      await bllInv_PermissionDiscount.fire_setListMaster_And_Details(
        insertdDocID: selectedID.toString(),
        itemInv_PermissionDiscount: widget.itemPermissionDiscount!,
        collectionDetailsName: en_TablesName.Inv_PermissionDiscountDetails.name,
        columnNameAsDocumentDetails: enTable_Inv_PermissionDiscountDetails.ID.name,
        detais: permissionDiscount_bloc.instance.filterdLst_permissionDiscountDetails.map((elm) => elm.toMap()).toList(),
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
          BLLCondions(enTable_Inv_ProductsQty.IDDocumentType.name, en_CondionsWhere.isEqualTo, en_DocumentType.permissionDiscount.value),
          BLLCondions(enTable_Inv_ProductsQty.IDDocument.name, en_CondionsWhere.isEqualTo, selectedID),
        ];
      });
      bllInv_ProductsQty.fire_DeleteListMaster(cond);
    }

    // اللف على تفاصيل الفاتورة لأخذ بيانات الأصناف وحفظها فى الجرد
    int index = 1;
    Inv_ProductsQty? itemProductsQty;

    for (var itemDetails in permissionDiscount_bloc.instance.filterdLst_permissionDiscountDetails) {
      itemProductsQty = lstProductsQty.where((itm) {
        return itm.LineNumber == itemDetails.ID && itm.IDDocument == selectedID && itm.IDDocumentType == en_DocumentType.permissionDiscount.value;
      }).firstOrNull;

      // لو فاضي يبقي صنف جديد
      if (itemProductsQty == null) {
        itemProductsQty = Inv_ProductsQty();
        itemProductsQty.ID = '${itemDetails.IDProduct}-${index}-${en_TablesName.Inv_PermissionDiscount.name}-${selectedID}';
        lstProductsQty.add(itemProductsQty);
      }
      itemProductsQty.DateInserted = contDate.text;
      itemProductsQty.IDDocument = selectedID;
      itemProductsQty.IDDocumentType = en_DocumentType.permissionDiscount.value;
      itemProductsQty.DocumentTypeName = requestStatus_bloc.instance.getNameByID(en_DocumentType.permissionDiscount.value);
      itemProductsQty.IDStock = stockID;
      itemProductsQty.StockName = stock_bloc.instance.getNameByID(stockID);
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
      itemProductsQty.TotalQty = itemDetails.UnitSmall_Qty! * -1;
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

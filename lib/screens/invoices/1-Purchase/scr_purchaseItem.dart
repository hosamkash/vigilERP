import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/bllFirebase/bllInvoices_Purchase.dart';
import 'package:vigil_erp/bll/classModel/Def_Categories.dart';
import 'package:vigil_erp/bll/classModel/Def_ProductStructure.dart';
import 'package:vigil_erp/bll/classModel/Def_Stocks.dart';
import 'package:vigil_erp/bll/classModel/Def_Units.dart';
import 'package:vigil_erp/bll/classModel/Invoices_Purchase.dart';
import 'package:vigil_erp/bll/classModel/Invoices_PurchaseDetails.dart';
import 'package:vigil_erp/blocManagment/blocDealing/dealing_bloc.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/blocManagment/blocFixTables/fix_table_bloc.dart';
import 'package:vigil_erp/blocManagment/blocInvoices/invoic_bloc.dart';
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
import '../../../bll/classModel/Inv_ProductsQty.dart';

class scr_purchaseItem extends StatefulWidget {
  scr_purchaseItem(this.itemPurchase, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Invoices_Purchase? itemPurchase;
  en_FormMode frmMode;

  @override
  State<scr_purchaseItem> createState() => _scr_purchaseItemState();
}

var frmKey = GlobalKey<FormState>();
List<Invoices_PurchaseDetails> lstDetailsDeleted = [];
List<Inv_ProductsQty> lstProductsQty = [];
TextEditingController controllerfilter = TextEditingController();

int selectedID = -1;
TextEditingController contCode = TextEditingController();
TextEditingController contDate = TextEditingController();
TextEditingController contTime = TextEditingController();
TimeOfDay? timeWorkFrom;
int? branchID;
int? stockID;
TextEditingController_Employee contEmployee = TextEditingController_Employee();
int? vendorID;
TextEditingController contVendorSerial = TextEditingController();

TextEditingController contTotalValue = TextEditingController(text: '0.0');
TextEditingController contDiscountValue = TextEditingController(text: '0.0');
TextEditingController contDiscountPercent = TextEditingController(text: '0.0');
TextEditingController contNetValue = TextEditingController(text: '0.0');

bool chkIsClosed = false;
TextEditingController contNote = TextEditingController(text: '');
TextEditingController contCurrentBalance = TextEditingController(text: '0.0');
bool? isBigUnit;

class _scr_purchaseItemState extends State<scr_purchaseItem> {
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
      body: SingleChildScrollView(child: buildPageContent()),
    );
  }

  Widget buildPageContent() {
    return Form(
      key: frmKey,
      child: Column(
        children: [
          ctr_TextHeaderPage(
            text: 'بيانات فاتورة المشتريات',
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

                    // reset Stock and populate with New branch
                    stockID = null;
                    stock_bloc.instance.add(getLstStocksAsDataSource_Event(
                        branchID: branchID, condions: [BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchID)]));
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
              Checkbox(
                  value: chkIsClosed,
                  onChanged: (value) {
                    // setState(() {
                    //   chkIsClosed = !chkIsClosed;
                    // });
                  }),
              const Text('مغلقة', style: TextStyle(fontSize: 17)),
            ],
          ),
          SizedBox(
            height: 515,
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
                  BuildDetailsProduct(),
                ],
              ),
            ),
          ),
          BuildSumValues(),
        ],
      ),
    );
  }

  Widget BuildMasterData() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 5),
          Row(
            children: [
              SizedBox(
                width: 175,
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
              SizedBox(
                width: 175,
                child: ctr_TextFormField(
                  Controller: contVendorSerial,
                  padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                  Lable: 'سريال المورد',
                  TextType: TextInputType.text,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 175,
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
                width: 175,
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
          BlocBuilder<stock_bloc, definition_state>(
            builder: (context, state) {
              bool isStockState = state is getLstStocksAsDataSource_State;
              List<DropDowenDataSource> lstStocks = branchID != null && isStockState ? state.LstStocksAsDataSource : [];

              return ctr_DropDowenList(
                hintLable: 'المخزن',
                padding: EdgeInsets.only(right: 5, left: 0),
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
          const SizedBox(height: 5),
          BlocBuilder<vendor_bloc, dealing_state>(
            builder: (context, state) {
              bool isState = state is getListVendorAsDataSource_StateDataChanged;
              List<DropDowenDataSource> lstVendors = isState ? state.filterdLst_VendorAsDataSource : [];

              return ctr_DropDowenList(
                hintLable: 'المورد',
                padding: EdgeInsets.only(right: 5, left: 5),
                lstDataSource: lstVendors,
                hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                menuMaxHeightValue: 300,
                showClearIcon: true,
                selectedValue: vendorID,
                OnChanged: (returnID) {
                  vendorID = returnID;
                  return vendorID;
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
          SizedBox(height: 5),
          ctr_TextFormField(
            Controller: contCurrentBalance,
            padding: EdgeInsets.only(right: 5, left: 0),
            Lable: 'الرصيد الحالى',
            TextType: TextInputType.number,
            OnValidate: (value) {
              if (value == null || value.isEmpty) {
                return 'لابد من إدخال قيمة';
              }
              return null;
            },
          ),
          SizedBox(height: 5),
          Row(
            children: [
              ctr_SelectEmployee(
                Controller: contEmployee,
                padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                labelText: 'القائم بالطلب',
                isOpenSelectorOnTap: true,
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
          ctr_TextFormField(
            Controller: contNote,
            padding: EdgeInsets.only(right: 5, left: 0),
            Lable: 'ملاحظات',
          ),
          // SizedBox(height: 5),

          // حفظ وغلق الفاتورة
          if (!checkIsSavedClosed())
            ElevatedButton.icon(
              label: Text(
                'حفظ وغلق الفاتورة',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.blue[800]),
              ),
              icon: Icon(Icons.done_outline),
              style: ElevatedButton.styleFrom(elevation: 3, backgroundColor: Colors.white),
              onPressed: () {
                sharedControls.confirmDialog(context, 'حفظ وإغلاق', 'فى حالة التأكيد سيتم غلق الفاتورة ولا يمكن التعديل فيها نهائياً', () {
                  chkIsClosed = true;
                  saveData();
                  saveProductsQty();
                });
              },
            ),
        ],
      ),
    );
  }

  BuildListView(BuildContext context) {
    return BlocBuilder<purchase_bloc, invoic_state>(
      builder: (context, state) {
        if (state is purchaseDetails_StateInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is purchaseDetails_StateDataChanged) {
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
                                purchase_bloc.instance.add(filterAnyPurchaseDetails_Event(filterData: value.trim()));
                              }
                              return null;
                            },
                          )),
                      IconButton(
                        onPressed: () {
                          controllerfilter.clear();
                          purchase_bloc.instance.add(resetFilterPurchaseDetails_Event());
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
                        return buildListViewItem(state.filterdLst_PurchaseDetails[index], context, index);
                      },
                      itemCount: state.filterdLst_PurchaseDetails.length,
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

  buildListViewItem(Invoices_PurchaseDetails itemDetails, context, int index) {
    return InkWell(
      onDoubleTap: () => editItemDetails(itemDetails, index),
      child: Container(
        padding: const EdgeInsets.only(top: 0, right: 0),
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

  Widget BuildDetailsProduct() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, right: 5, bottom: 10, left: 0),
            child: BuildListView(context),
          ),
        ),
      ],
    );
  }

  Widget BuildSumValues() {
    return InkWell(
      onDoubleTap: () {
        editCalcSumValues(context);
      },
      child: Container(
        color: Colors.yellow[200],
        child: BlocBuilder<purchase_bloc, invoic_state>(
          builder: (context, state) {
            if (state is purchaseDetails_StateDataChanged) {
              contTotalValue.text =
                  state.filterdLst_PurchaseDetails.fold(0.0, (previousValue, element) => previousValue + element.TotalPrice!).toStringAsFixed(2);
              calcSumValues(context);
              return Column(
                children: [
                  Row(
                    children: [
                      Text('العدد:', style: const TextStyle(fontSize: 14)),
                      Text('${state.filterdLst_PurchaseDetails.length}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('   الكمية :', style: const TextStyle(fontSize: 14)),
                      Text('${state.filterdLst_PurchaseDetails.fold(0, (previousValue, element) => previousValue + element.UnitSmall_Qty!)}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      // الإجمالى
                      Text('    الإجمالى:', style: const TextStyle(fontSize: 14)),
                      Text(contTotalValue.text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      Text('الخصم:', style: const TextStyle(fontSize: 14)),
                      Text(contDiscountValue.text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('   الخصم% :', style: const TextStyle(fontSize: 14)),
                      Text(contDiscountPercent.text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      // الصافى
                      Text('    الصافى:', style: const TextStyle(fontSize: 14)),
                      Text(contNetValue.text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              );
            } else
              return SizedBox();
          },
        ),
      ),
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
                    purchase_bloc.instance.add(addNewPurchaseDetails_Event(itemCustomProduct: prod));
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
    priceType_bloc.instance.getLst_PriceTypeAsDataSource();
    categories_bloc.instance.add(getListCategories_Event([BLLCondions(enTable_Def_Categories.IsActive.name, en_CondionsWhere.isEqualTo, true)]));
    vendor_bloc.instance.add(getListVendorAsDataSource_Event());
    categories_bloc.instance
        .getList_CategoryAsDataSource(condions: [BLLCondions(enTable_Def_Categories.IsActive.name, en_CondionsWhere.isEqualTo, true)]);
    unit_bloc.instance.add(getListUnit_Event([BLLCondions(enTable_Def_Units.IsActive.name, en_CondionsWhere.isEqualTo, true)]));
    clearCachedData();

    if (widget.frmMode == en_FormMode.NewMode)
      newMode();
    else if (widget.frmMode == en_FormMode.EditMode) {
      editMode();
    }
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

    // branchID = null;
    // stockID = null;
    // contEmployee.selectEmployee = null;
    // contEmployee.text = '';
    // ctr_SelectEmployee.branchID = null;
    // stock_bloc.instance.add(resetFilterStock_Event());
    // employee_bloc.instance.add(resetFilterEmployee_Event());
    //
    // // purchase_bloc.instance.filterdLst_PurchaseDetails.clear();
    // // مسح البيانات من التفاصيل عشان التعريف الجديد القادم
    // purchase_bloc.instance.add(clearPurchaseDetails_Event());
  }

  void clearCachedData() {
    stockID = null;

    ctr_SelectEmployee.branchID = branchID = contEmployee.selectEmployee = null;
    contNote.text = contCurrentBalance.text =
        contTotalValue.text = contDiscountPercent.text = contDiscountValue.text = contNetValue.text = contEmployee.text = '';
    employee_bloc.instance.add(resetFilterEmployee_Event());

    lstDetailsDeleted.clear();
    lstProductsQty.clear();
    purchase_bloc.instance.add(clearPurchaseDetails_Event());
  }

  void newMode() async {
    bllInvoices_Purchase.getMax_firestore(enTable_Invoices_Purchase.Code).then((val) {
      contCode.text = val.toString();
    }).toString();
    contDate.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    contTime.text = sharedFunctions_Dates.convertDateTime_TimeString(DateTime.now());
  }

  void editMode() async {
    selectedID = widget.itemPurchase!.ID!;
    branchID = widget.itemPurchase!.IDBranch;
    // stock_bloc.instance.getLstStockAsDataSource();
    stock_bloc.instance
        .add(getLstStocksAsDataSource_Event(condions: [BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchID)]));
    // stock_bloc.instance.getLstStockAsDataSource(condions: [BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchID)]);
    stockID = widget.itemPurchase!.IDStock!;

    contCode.text = widget.itemPurchase!.Code.toString();
    contEmployee.selectEmployee = await bllDealing_Employees.fire_getItem(widget.itemPurchase!.IDEmployee!.toString());
    contEmployee.text = contEmployee.selectEmployee!.Name!;
    ctr_SelectEmployee.branchID = branchID;
    contDate.text = widget.itemPurchase!.Date!;
    contTime.text = widget.itemPurchase!.Time!;
    chkIsClosed = widget.itemPurchase!.IsClosed!;
    vendorID = widget.itemPurchase!.IDVendor;

    contNote.text = widget.itemPurchase!.Note!;
    contCurrentBalance.text = widget.itemPurchase!.CurrentBalance.toString();
    purchase_bloc.instance.add(getListPurchaseDetails_Event(widget.itemPurchase!.ID!));

    List<BLLCondions> cond = [
      BLLCondions(enTable_Inv_ProductsQty.IDDocumentType.name, en_CondionsWhere.isEqualTo, en_DocumentType.purchase.value),
      BLLCondions(enTable_Inv_ProductsQty.IDDocument.name, en_CondionsWhere.isEqualTo, selectedID),
    ];
    lstProductsQty = await bllInv_ProductsQty.fire_getListWithConditions(conditions: cond);
  }

  void editItemDetails(Invoices_PurchaseDetails itemDetails, index) async {
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
          purchase_bloc.instance.add(editRowPurchaseDetails_Event(itemCustomProduct: cProduct, index: index));
        }
      });
  }

  void editCalcSumValues(context) {
    sharedControls
        .showEditSummtionInvoice(
            context, en_TablesName.Invoices_Purchase, contTotalValue.text, contDiscountValue.text, contDiscountPercent.text, contNetValue.text)
        .then((retValues) {
      if (retValues != null) {
        contTotalValue.text = retValues[0] as String;
        contDiscountValue.text = retValues[1] as String;
        contDiscountPercent.text = retValues[2] as String;
        contNetValue.text = retValues[3] as String;
      }
    });
  }

  void calcSumValues(context) {
    contDiscountPercent.text = contDiscountPercent.text.isNotEmpty ? contDiscountPercent.text : '0.0';
    contDiscountValue.text = contDiscountValue.text.isNotEmpty ? contDiscountValue.text : '0.0';

    contDiscountValue.text = ((double.parse(contTotalValue.text) * double.parse(contDiscountPercent.text)) / 100).toStringAsFixed(2);
    //contDiscountPercent.text = ((double.parse(contDiscountValue.text) * 100) / double.parse(contTotalValue.text)).toStringAsFixed(2);
    contNetValue.text = (double.parse(contTotalValue.text) - double.parse(contDiscountValue.text)).toStringAsFixed(2);
  }

  void deletItemDetails(Invoices_PurchaseDetails itemDetails) {
    sharedControls.confirmDelete(
      context,
      product_bloc.instance.getNameByID(itemDetails.IDProduct),
      () {
        purchase_bloc.instance.add(deleteItemPurchaseDetails_Event(itemDetails: itemDetails));
        lstDetailsDeleted.add(itemDetails);
      },
    );
  }

  bool checkIsSavedClosed() {
    if (widget.frmMode == en_FormMode.EditMode && (widget.itemPurchase!.IsClosed!))
      return true;
    else
      return false;
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      //********************************************************************
      if (widget.frmMode == en_FormMode.NewMode) {
        selectedID = await bllInvoices_Purchase.getMaxID_firestore();
        widget.itemPurchase = Invoices_Purchase();
      } else if (widget.frmMode == en_FormMode.EditMode) {
        selectedID = widget.itemPurchase!.ID!;
      }

      widget.itemPurchase!.ID = selectedID;
      widget.itemPurchase!.IDBranch = branchID;
      widget.itemPurchase!.Code = int.tryParse(contCode.text);
      widget.itemPurchase!.IDStock = stockID;
      widget.itemPurchase!.Date = contDate.text;
      widget.itemPurchase!.Time = contTime.text;
      widget.itemPurchase!.IDEmployee = contEmployee.selectEmployee!.ID;
      widget.itemPurchase!.IDVendor = vendorID;
      widget.itemPurchase!.VendorSerial = contVendorSerial.text;

      widget.itemPurchase!.TotalValue = contTotalValue.text.isNotEmpty ? double.parse(contTotalValue.text) : 0.0;
      widget.itemPurchase!.DiscountValue = contDiscountValue.text.isNotEmpty ? double.parse(contDiscountValue.text) : 0.0;
      widget.itemPurchase!.DiscountPercent = contDiscountPercent.text.isNotEmpty ? double.parse(contDiscountPercent.text) : 0.0;
      widget.itemPurchase!.NetValue = contNetValue.text.isNotEmpty ? double.parse(contNetValue.text) : 0.0;
      widget.itemPurchase!.IsClosed = chkIsClosed;
      widget.itemPurchase!.Note = contNote.text;
      widget.itemPurchase!.CurrentBalance = contCurrentBalance.text.isNotEmpty ? double.parse(contCurrentBalance.text) : 0.0;
      widget.itemPurchase!.UID = sharedHive.UID;

      // حفظ الاساسي والتفاصيل مره واحده
      await bllInvoices_Purchase.fire_setListMaster_And_Details(
        insertdDocID: selectedID.toString(),
        itemInvoices_Purchase: widget.itemPurchase!,
        collectionDetailsName: en_TablesName.Invoices_PurchaseDetails.name,
        columnNameAsDocumentDetails: enTable_Invoices_PurchaseDetails.ID.name,
        detais: purchase_bloc.instance.filterdLst_PurchaseDetails.map((elm) => elm.toMap()).toList(),
        deletedItemsDetais: lstDetailsDeleted.map((elm) => elm.toMap()).toList(),
      );
      saveProductsQty();
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
          BLLCondions(enTable_Inv_ProductsQty.IDDocumentType.name, en_CondionsWhere.isEqualTo, en_DocumentType.purchase.value),
          BLLCondions(enTable_Inv_ProductsQty.IDDocument.name, en_CondionsWhere.isEqualTo, selectedID),
        ];
      });
      bllInv_ProductsQty.fire_DeleteListMaster(cond);
    }

    // اللف على تفاصيل الفاتورة لأخذ بيانات الأصناف وحفظها فى الجرد
    int index = 1;
    Inv_ProductsQty? itemProductsQty;

    for (var itemDetails in purchase_bloc.instance.filterdLst_PurchaseDetails) {
      itemProductsQty = lstProductsQty.where((itm) {
        return itm.LineNumber == itemDetails.ID && itm.IDDocument == selectedID && itm.IDDocumentType == en_DocumentType.purchase.value;
      }).firstOrNull;

      // لو فاضي يبقي صنف جديد
      if (itemProductsQty == null) {
        itemProductsQty = Inv_ProductsQty();
        itemProductsQty.ID = '${itemDetails.IDProduct}-${index}-${en_TablesName.Invoices_Purchase.name}-${selectedID}';
        lstProductsQty.add(itemProductsQty);
      }
      itemProductsQty.DateInserted = contDate.text;
      itemProductsQty.IDDocument = selectedID;
      itemProductsQty.IDDocumentType = en_DocumentType.purchase.value;
      itemProductsQty.DocumentTypeName = requestStatus_bloc.instance.getNameByID(en_DocumentType.purchase.value);
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
      itemProductsQty.Qty = itemDetails.UnitSmall_Qty;
      itemProductsQty.QtyRepresents = 0;
      itemProductsQty.TotalQty = itemDetails.UnitSmall_Qty;
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

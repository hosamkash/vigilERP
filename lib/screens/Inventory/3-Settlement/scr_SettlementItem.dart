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
import '../../../bll/bllFirebase/bllInv_ProductsQty.dart';
import '../../../bll/bllFirebase/bllInv_Settlement.dart';
import '../../../bll/classModel/Def_Stocks.dart';
import '../../../bll/classModel/Inv_ProductsQty.dart';
import '../../../bll/classModel/Inv_Settlement.dart';
import '../../../bll/classModel/Inv_SettlementDetails.dart';

class scr_SettlementItem extends StatefulWidget {
  scr_SettlementItem(this.itemSettlement, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Inv_Settlement? itemSettlement;
  en_FormMode frmMode;

  @override
  State<scr_SettlementItem> createState() => _scr_SettlementItemState();
}

var frmKey = GlobalKey<FormState>();
List<Inv_SettlementDetails> lstDetailsDeleted = [];
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
TextEditingController contSettlementAddValue = TextEditingController();
TextEditingController contSettlementDiscountValue = TextEditingController();
TextEditingController contNetValue = TextEditingController();

final TextEditingController contQty = TextEditingController();
final TextEditingController contPrice = TextEditingController();

bool? isBigUnit;
List<Inv_ProductsQty> lstProductsQty = [];
TextEditingController contFilter = TextEditingController();

class _scr_SettlementItemState extends State<scr_SettlementItem> {
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
              text: 'بيانات تسوية الأصناف',
              color: Colors.grey[300],
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
                stockID = stock_bloc.instance.LstStocksAsDataSource.length > 0 ? stock_bloc.instance.LstStocksAsDataSource.first.valueMember : stockID;
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
                              if (stockID == null) {
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
              branchID != null && isStockState ? state  .LstStocksAsDataSource : [];
          // عند تغيير المخزن لابد من تغيير الكمية الدفترية
          stockID = lstStocks.length > 0 ? lstStocks.first.valueMember : stockID;
          settlement_bloc.instance.add(updateSettlementProductQtyByStock_Event(stockID: stockID));
          // settlement_bloc.instance.updateSettlementProductQtyByStock(stockID);
          // settlement_bloc.instance.add(refreshDetails_Event());

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
              // عند تغيير المخزن لابد من تغيير الكمية الدفترية
              settlement_bloc.instance.add(updateSettlementProductQtyByStock_Event(stockID: stockID));
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
              if (employee == null || employee.isEmpty) {
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
      ctr_TextFormField(
        Controller: contNote,
        padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
        Lable: 'ملاحظات',
      ),
      SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0.75),
              height: 40,
              child: TextFormField(
                controller: contSettlementAddValue,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 17, color: Colors.red, fontWeight: FontWeight.bold, height: 0.5),
                decoration: InputDecoration(
                  label: Text('الزيادة'),
                  labelStyle: const TextStyle(fontSize: 17, color: Colors.red),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0.75),
              height: 40,
              child: TextFormField(
                controller: contSettlementDiscountValue,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 17, color: Colors.red, fontWeight: FontWeight.bold, height: 0.5),
                decoration: InputDecoration(
                  label: Text('النواقص'),
                  labelStyle: const TextStyle(fontSize: 17, color: Colors.red),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0.75),
              height: 40,
              child: TextFormField(
                controller: contNetValue,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 17, color: Colors.red, fontWeight: FontWeight.bold, height: 0.5),
                decoration: InputDecoration(
                  label: Text('الصافي'),
                  labelStyle: const TextStyle(fontSize: 17, color: Colors.red),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
    ]));
  }

  Widget BuildListView(BuildContext context) {
    return BlocBuilder<settlement_bloc, inv_state>(
      builder: (context, state) {
        if (state is settlementDetails_StateInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is settlementDetails_StateDataChanged) {
          return Card(
            color: Colors.white,
            elevation: 3,
            child: Column(
              children: [
                // Filter
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                          child: ctr_TextFormField(
                        Controller: contFilter,
                        PrefixIcon: const Icon(Icons.search),
                        padding: const EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 0),
                        OnChanged: (value) {
                          if (value != null) {
                            settlement_bloc.instance.add(filterAnySettlementDetails_Event(filterData: value.trim()));
                          }
                          return null;
                        },
                      )),
                      IconButton(
                        onPressed: () {
                          contFilter.clear();
                          settlement_bloc.instance.add(resetFilterSettlementDetails_Event());
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ],
                  ),
                ),

                // Column Header
                Container(
                  color: Colors.grey[300],
                  child: Row(
                    children: [
                      SizedBox(
                          width: 140,
                          child: Text('الصــــنف', textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 45,
                          child: Text('دفتري', textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 45,
                          child: Text('فعلى', textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 45,
                          child: Text('نواقص', textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 45,
                          child: Text('زيادة', textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),

                // ListView - Rows
                Expanded(
                  child: SizedBox(
                    width: 700,
                    height: 500,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(right: 2, left: 2),
                      itemBuilder: (context, index) {
                        return buildListViewItem(state.filterdLst_SettlementDetails[index], context, index);
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 1),
                      itemCount: state.filterdLst_SettlementDetails.length,
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

  buildListViewItem(Inv_SettlementDetails itemDetails, context, int index) {
    return GestureDetector(
      onTapDown: (detail) {
        openMenuOption(detail.globalPosition, itemDetails, index);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 0, right: 5, bottom: 0, left: 5),
        color: itemDetails.AddQty != 0 ? Colors.white : Colors.yellow[100],
        child: Column(
          children: [
            Divider(
              color: Colors.grey,
              thickness: 1,
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 140,
                  child: Text(
                    sharedFunctions_String.RemoveStringWords(product_bloc.instance.getNameByID(itemDetails.IDProduct), countWords: 4),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    itemDetails.BookingQty.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    itemDetails.ActualQty.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 45,
                  child: Text(
                    itemDetails.DiffQty.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 45,
                  child: Text(
                    itemDetails.AddQty.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),

                // Text('باركود:', style: const TextStyle(fontSize: 14)),
                // Text('${itemDetails.Barcode}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                Text('${priceType_bloc.instance.getNameByID(itemDetails.PriceType)}', style: const TextStyle(fontSize: 14)),
                SizedBox(width: 30),
                Text('السعر: ', style: const TextStyle(fontSize: 14)),
                Text('${itemDetails.Price!}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(width: 15),
                Text('الإجمالى: ', style: const TextStyle(fontSize: 14)),
                Text('${itemDetails.AddQty! != 0 ? itemDetails.AddTotalPrice : itemDetails.DiffTotalPrice}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            // const Divider(height: 5, color: Colors.grey, thickness: 2, indent: 15, endIndent: 15),
          ],
        ),
      ),
    );
  }

  openMenuOption(Offset globalPosition, Inv_SettlementDetails itemDetails, int index) {
    showMenu(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(globalPosition.dx, globalPosition.dy, globalPosition.dx, globalPosition.dy),
      items: [
        PopupMenuItem(
          child: Center(
            child: Column(
              children: [
                Text(product_bloc.instance.getNameByID(itemDetails.IDProduct), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.blue),
              Text('تعديل', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue)),
            ],
          ),
          onTap: () async {
            await ctr_SelectProduct(onAddProduct: (c) {})
              ..editProduct(
                context,
                itemDetails.IDProduct!,
                itemDetails.PriceType!,
                false,
                showUseBigUnit: false,
                itemDetails.Price!,
                itemDetails.ActualQty!,
                // index,
              ).then((cProduct) {
                if (cProduct != null) {
                  settlement_bloc.instance.add(editRowSettlementDetails_Event(itemCustomProduct: cProduct, index: index));
                  calcSumValue();
                }
              });
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red[700]),
              Text('حذف', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red[700])),
            ],
          ),
          onTap: () {
            deletItemDetails(itemDetails);
          },
        ),
      ],
    );
  }

  Widget BuildDetailsProduct_SumValues() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, right: 0, bottom: 5, left: 0),
            child: BuildListView(context),
          ),
        ),

        // ***************  Summtion
        Container(
          color: Colors.yellow[200],
          child: BlocBuilder<settlement_bloc, inv_state>(
            builder: (context, state) {
              if (state is settlementDetails_StateDataChanged) {
                return Row(
                  children: [
                    Text('العدد:', style: const TextStyle(fontSize: 14)),
                    Text('${state.filterdLst_SettlementDetails.length}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('   إجمالى النواقص :', style: const TextStyle(fontSize: 14)),
                    Text('${state.filterdLst_SettlementDetails.fold(0, (previousValue, element) => previousValue + element.DiffQty!)}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('    إجمالى الزيادة:', style: const TextStyle(fontSize: 14)),
                    Text('${state.filterdLst_SettlementDetails.fold(0, (previousValue, element) => previousValue + element.AddQty!)}',
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
                    settlement_bloc.instance.add(addNewSettlementDetails_Event(itemCustomProduct: prod, stockID: stockID));
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
    settlement_bloc.instance.add(clearSettlementDetails_Event());
    requestStatusID = null;
    contSettlementAddValue.text = contSettlementDiscountValue.text = contNetValue.text = '';
  }

  void calcSumValue() {
    contSettlementDiscountValue.text = settlement_bloc.instance.filterdLst_SettlementDetails
        .fold(0.0, (previousValue, element) => previousValue + element.DiffTotalPrice!)
        .toStringAsFixed(2);
    contSettlementAddValue.text = settlement_bloc.instance.filterdLst_SettlementDetails
        .fold(0.0, (previousValue, element) => previousValue + element.AddTotalPrice!)
        .toStringAsFixed(2);
    contNetValue.text = (double.parse(contSettlementDiscountValue.text) + double.parse(contSettlementAddValue.text)).toStringAsFixed(2);
  }

  void NewMode() async {
    bllInv_Settlement.getMax_firestore(enTable_Inv_Settlement.Code).then((val) {
      contCode.text = val.toString();
    }).toString();
    contDate.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    contTime.text = sharedFunctions_Dates.convertDateTime_TimeString(DateTime.now());
  }

  void EditMode() async {
    selectedID = widget.itemSettlement!.ID!;
    branchID = widget.itemSettlement!.IDBranch;
    // stock_bloc.instance.getLstStockAsDataSource();
    // stock_bloc.instance.getLstStockAsDataSource(condions: [BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchID)]);
    stock_bloc.instance
        .add(getLstStocksAsDataSource_Event(condions: [BLLCondions(enTable_Def_Stocks.IDBranch.name, en_CondionsWhere.isEqualTo, branchID)])); stockID = widget.itemSettlement!.IDStock!;
    requestStatusID = widget.itemSettlement!.IDRequestStatus;

    contCode.text = widget.itemSettlement!.Code.toString();
    contEmployee.selectEmployee = await bllDealing_Employees.fire_getItem(widget.itemSettlement!.IDEmployee!.toString());
    contEmployee.text = contEmployee.selectEmployee!.Name!;
    ctr_SelectEmployee.branchID = branchID;
    contDate.text = widget.itemSettlement!.Date!;
    contTime.text = widget.itemSettlement!.Time!;
    contNote.text = widget.itemSettlement!.Note!;
    contSettlementAddValue.text = widget.itemSettlement!.SettlementAddValue.toString();
    contSettlementDiscountValue.text = widget.itemSettlement!.SettlementDiscountValue.toString();
    contNetValue.text = widget.itemSettlement!.NetValue.toString();
    settlement_bloc.instance.add(getListSettlementDetails_Event(widget.itemSettlement!.ID!));

    List<BLLCondions> cond = [
      BLLCondions(enTable_Inv_ProductsQty.IDDocumentType.name, en_CondionsWhere.isEqualTo, en_DocumentType.settlement.value),
      BLLCondions(enTable_Inv_ProductsQty.IDDocument.name, en_CondionsWhere.isEqualTo, selectedID),
    ];
    lstProductsQty = await bllInv_ProductsQty.fire_getListWithConditions(conditions: cond);
  }

  void deletItemDetails(Inv_SettlementDetails itemDetails) {
    sharedControls.confirmDelete(
      context,
      product_bloc.instance.getNameByID(itemDetails.IDProduct),
      () {
        settlement_bloc.instance.add(deleteItemSettlementDetails_Event(itemDetails: itemDetails));
        lstDetailsDeleted.add(itemDetails);
        calcSumValue();
      },
    );
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      //********************************************************************
      if (widget.frmMode == en_FormMode.NewMode) {
        selectedID = await bllInv_Settlement.getMaxID_firestore();
        widget.itemSettlement = Inv_Settlement();
      } else if (widget.frmMode == en_FormMode.EditMode) {
        selectedID = widget.itemSettlement!.ID!;
      }

      widget.itemSettlement!.ID = selectedID;
      widget.itemSettlement!.IDBranch = branchID;
      widget.itemSettlement!.Code = int.tryParse(contCode.text);
      widget.itemSettlement!.IDStock = stockID;
      widget.itemSettlement!.Date = contDate.text;
      widget.itemSettlement!.Time = contTime.text;
      widget.itemSettlement!.IDEmployee = contEmployee.selectEmployee!.ID;
      widget.itemSettlement!.IDRequestStatus = requestStatusID;
      widget.itemSettlement!.Note = contNote.text;
      widget.itemSettlement!.UID = sharedHive.UID;
      widget.itemSettlement!.SettlementAddValue = double.parse(contSettlementAddValue.text);
      widget.itemSettlement!.SettlementDiscountValue = double.parse(contSettlementDiscountValue.text);
      widget.itemSettlement!.NetValue = double.parse(contNetValue.text);

      // حفظ الاساسي والتفاصيل مره واحده
      await bllInv_Settlement.fire_setListMaster_And_Details(
        insertdDocID: selectedID.toString(),
        itemInv_Settlement: widget.itemSettlement!,
        collectionDetailsName: en_TablesName.Inv_SettlementDetails.name,
        columnNameAsDocumentDetails: enTable_Inv_SettlementDetails.ID.name,
        detais: settlement_bloc.instance.filterdLst_SettlementDetails.map((elm) => elm.toMap()).toList(),
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
          BLLCondions(enTable_Inv_ProductsQty.IDDocumentType.name, en_CondionsWhere.isEqualTo, en_DocumentType.settlement.value),
          BLLCondions(enTable_Inv_ProductsQty.IDDocument.name, en_CondionsWhere.isEqualTo, selectedID),
        ];
      });
      bllInv_ProductsQty.fire_DeleteListMaster(cond);
    }

    // اللف على تفاصيل الفاتورة لأخذ بيانات الأصناف وحفظها فى الجرد
    int index = 1;
    Inv_ProductsQty? itemProductsQty;

    for (var itemDetails in settlement_bloc.instance.filterdLst_SettlementDetails) {
      itemProductsQty = lstProductsQty.where((itm) {
        return itm.LineNumber == itemDetails.ID && itm.IDDocument == selectedID && itm.IDDocumentType == en_DocumentType.settlement.value;
      }).firstOrNull;

      // لو فاضي يبقي صنف جديد
      if (itemProductsQty == null) {
        itemProductsQty = Inv_ProductsQty();
        itemProductsQty.ID = '${itemDetails.IDProduct}-${index}-${en_TablesName.Inv_Settlement.name}-${selectedID}';
        lstProductsQty.add(itemProductsQty);
      }
      itemProductsQty.DateInserted = contDate.text;
      itemProductsQty.IDDocument = selectedID;
      itemProductsQty.IDDocumentType = en_DocumentType.settlement.value;
      itemProductsQty.DocumentTypeName = en_DocumentType.settlement .name;;
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
      // itemProductsQty.QtyBefore = itemDetails.AddQty != 0 ? itemDetails.AddQty : itemDetails.DiffQty;
      itemProductsQty.QtyRepresents = 0;
      itemProductsQty.IDUnit = itemDetails.IDUnit;
      itemProductsQty.UnitName = unit_bloc.instance.getNameByID(itemDetails.IDUnit);

      productQty_bloc.instance.getproductQtyByStockID_OrAllStocks(stockID, itemDetails.IDProduct!).then((val) {
        itemProductsQty!.QtyBefore = val;
      });
      itemProductsQty.Qty = itemDetails.AddQty != 0 ? itemDetails.AddQty : itemDetails.DiffQty;
      itemProductsQty.QtyAfter = (itemProductsQty.Qty ?? 0) + (itemProductsQty.QtyBefore ?? 0);
      itemProductsQty.IDPriceType = itemDetails.PriceType;
      itemProductsQty.PriceTypeName = priceType_bloc.instance.getNameByID(itemDetails.PriceType);
      itemProductsQty.Price = itemDetails.Price;
      itemProductsQty.TotalPrice = double.parse((itemProductsQty.Qty! * itemProductsQty.Price!).toStringAsFixed(2));

      index++;
    }
    bllInv_ProductsQty.fire_setListMaster(lstInv_ProductsQty: lstProductsQty);
  }
}

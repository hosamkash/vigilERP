import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/classModel/Def_CompanyStructure.dart';
import 'package:vigil_erp/bll/classModel/Def_Stocks.dart';

import 'package:vigil_erp/blocManagment/blocDealing/dealing_bloc.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/blocManagment/blocFixTables/fix_table_bloc.dart';
import 'package:vigil_erp/blocManagment/blocInventory/inv_bloc.dart';
import 'package:vigil_erp/blocManagment/tablesCondions.dart';
import 'package:vigil_erp/componants/ctr_AlertDialog.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/screens/Inventory/1-PermissionAdd/scr_PermissionAddItem.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/sharedFunctions.dart';
import 'package:vigil_erp/shared/sharedHive.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/ManageBLL.dart';
import '../../../bll/classModel/Inv_PermissionAdd.dart';
import '../../../bll/classModel/Inv_ProductsQty.dart';

class scr_PermissionAddView extends StatefulWidget {
  scr_PermissionAddView({super.key});

  @override
  State<scr_PermissionAddView> createState() => _scr_PermissionAddViewState();
}

class _scr_PermissionAddViewState extends State<scr_PermissionAddView> {
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  TextEditingController controllerfilter = TextEditingController();
  TextEditingController contDateTo = TextEditingController();
  TextEditingController contDateFrom = TextEditingController();
  TextEditingController contTotalValue = TextEditingController();
  bool isGetAllDates = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,

      //******************************* App Bar *************************************
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: buildCustomBar(),
        titleSpacing: 20,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_forward)),
        ],
      ),
      drawer: sharedControls.buildMainMenu(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () async {
          newItem();
        },
      ),
      body: buildPageContent(),
    );
  }

  Widget buildPageContent() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ctr_TextHeaderPage(
                text: 'عرض أذون الإضافة',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
              ),
              BlocBuilder<permissionAdd_bloc, inv_state>(
                builder: (context, state) {
                  if (state is permissionAdd_StateDataChanged) {
                    return ctr_TextHeaderPage(
                      text: state.filterdLst_PermissionAdd.length.toString(),
                      color: Colors.grey[300],
                      borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          )),

          SizedBox(
            height: 60,
            child: Row(
              children: [
                Expanded(
                    child: ctr_TextFormField(
                  Controller: controllerfilter,
                  PrefixIcon: const Icon(Icons.search),
                  padding: const EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 0),
                  OnChanged: (value) {
                    if (value != null) {
                      permissionAdd_bloc.instance.add(filterAnyPermissionAdd_Event(filterData: value.trim()));
                    }
                    return null;
                  },
                )),
                IconButton(
                  onPressed: () {
                    controllerfilter.clear();
                    permissionAdd_bloc.instance.add(resetFilterPermissionAdd_Event());
                  },
                  icon: const Icon(Icons.clear),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 10),
          Expanded(
            child: buildListView(context),
          ),
        ],
      ),
    );
  }

  Widget buildListView(BuildContext context) {
    return BlocBuilder<permissionAdd_bloc, inv_state>(
      builder: (context, state) {
        if (state is permissionAdd_StateInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is permissionAdd_StateDataChanged) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                // Column Header
                Container(
                  color: Colors.grey[300],
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                  width: 935,
                  height: 30,
                  child: Row(
                    children: [
                      SizedBox(
                          width: 60,
                          child: Text('كود', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 90,
                          child: Text('التاريخ', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 70,
                          child: Text('الساعة', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 120,
                          child: Text('الفرع', textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 120,
                          child: Text('المخزن', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 120,
                          child:
                              Text('القائم بالطلب', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 80,
                          child: Text('القيمة', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 150,
                          child: Text('الحالة', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 110,
                          child: Text('  ', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),

                // ListView - Rows
                Expanded(
                  child: SizedBox(
                    width: 935,
                    height: 480,
                    child: ListView.separated(
                      // physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                      itemBuilder: (context, index) {
                        return buildListViewItem(state.filterdLst_PermissionAdd[index], context);
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 1),
                      itemCount: state.filterdLst_PermissionAdd.length,
                    ),
                  ),
                ),

                // Summary
                SizedBox(
                  width: 930,
                  height: 35,
                  child: Row(
                    children: [
                      SizedBox(width: 100),
                      BlocBuilder<permissionAdd_bloc, inv_state>(
                        builder: (context, state) {
                          if (state is permissionAdd_StateDataChanged) {
                            contTotalValue.text = state.filterdLst_PermissionAdd
                                .fold(0.0, (previousValue, element) => previousValue + element.Value!)
                                .toStringAsFixed(2);
                            return SizedBox(
                              width: 200,
                              child: ctr_TextFormField(
                                Controller: contTotalValue,
                                Lable: 'الإجمالى',
                                readOnly: true,
                                textStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            );
                          } else
                            return SizedBox();
                        },
                      ),
                    ],
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

  buildListViewItem(Inv_PermissionAdd item, context) {
    return Column(
      children: [
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        InkWell(
          onDoubleTap: () => editItem(item),
          child: SizedBox(
            height: 25,
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    item.Code.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: Text(
                    item.Date ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 70,
                  child: Text(
                    item.Time ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    company_bloc.instance.getNameByID(item.IDBranch),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    stock_bloc.instance.getNameByID(item.IDStock),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    employee_bloc.instance.getNameByID(item.IDEmployee),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    item.Value.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    requestStatus_bloc.instance.getNameByID(item.IDRequestStatus),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      InkWell(
                        child: Icon(Icons.edit, color: Colors.blue),
                        onTap: () => editItem(item),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        child: Icon(Icons.delete, color: Colors.red[700]),
                        onTap: () => deleteItem(item),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        child: Icon(Icons.share, color: Colors.green[700]),
                        onTap: () => shareItem(item),
                      ),
                    ],
                  ),
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

    company_bloc.instance.add(getListCompany_Event([BLLCondions(enTable_Def_CompanyStructure.isActive.name, en_CondionsWhere.isEqualTo, true)]));
    stock_bloc.instance.add(getLstStocksAsDataSource_Event());
    employee_bloc.instance.add(getListEmployee_Event());

    loadDataFromDB();
  }

  Widget buildCustomBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            sharedControls
                .showFormFilterByDates(context, en_TablesName.Inv_PermissionAdd, branchID, contDateFrom, contDateTo, isGetAllDates)
                .then((retValues) {
              if (retValues != null) {
                isGetAllDates = retValues[0] as bool;
                contDateFrom.text = retValues[1] as String;
                contDateTo.text = retValues[2] as String;
                branchID = retValues[3] as int?;
              }
            });
          },
          icon: Icon(
            Icons.filter_alt,
            color: Colors.blue[900],
            size: 30,
          ),
          padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 0),
        ),
        IconButton(
          onPressed: () {
            tablesCondions
                .createCondionsByDates(en_TablesName.Inv_PermissionAdd, branchID, contDateFrom, contDateTo, isGetAllDates)
                .then((cond) => permissionAdd_bloc.instance.add(getListPermissionAdd_Event(condions: cond)));
          },
          icon: Icon(
            Icons.cloud_download_rounded,
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

  Future loadDataFromDB() async {
    await stock_bloc.instance.getLstStockAsDataSource(condions: [BLLCondions(enTable_Def_Stocks.IsActive.name, en_CondionsWhere.isEqualTo, true)]);
    await employee_bloc.instance.getLstEmployeeAsDataSource();
    await requestStatus_bloc.instance.getLst_requestStatusAsDataSource();

    contDateFrom.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    contDateTo.text = contDateFrom.text;

    List<BLLCondions>? cond =
        await tablesCondions.createCondionsByDates(en_TablesName.Inv_PermissionAdd, sharedHive.currentBranch!.ID, contDateFrom, contDateTo, false);
    permissionAdd_bloc.instance.add(getListPermissionAdd_Event(condions: cond));

    if (controllerfilter.text.trim().isNotEmpty) {
      permissionAdd_bloc.instance.add(filterAnyPermissionAdd_Event(filterData: controllerfilter.text.trim()));
    }
  }

  void newItem() async {
     await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => scr_PermissionAddItem(null, en_FormMode.NewMode),
      ),
    );
    loadDataFromDB();
  }

  void editItem(Inv_PermissionAdd item) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => scr_PermissionAddItem(item, en_FormMode.EditMode),
      ),
    );

    if (result == null) {
      permissionAdd_bloc.instance.add(refreshPermissionAdd_Event());
    } else if (result == true) {
      loadDataFromDB();
    }
  }

  void deleteItem(Inv_PermissionAdd item) {
    print('حذف ${item.Code}  -  ID ${item.ID}');

    ctr_AlertDialog.showListFilter(
      context,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ctr_TextHeaderPage(
            text: 'هل تريد تأكيد حذف : \n ${item.Code}',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              ElevatedButton.icon(
                label: const Text(
                  'حذف',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                icon: const Icon(Icons.delete_forever),
                iconAlignment: IconAlignment.end,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
                onPressed: () {
                  delete(item);
                },
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                label: const Text(
                  'الغاء',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                icon: const Icon(Icons.cancel),
                iconAlignment: IconAlignment.end,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void delete(Inv_PermissionAdd item) async {
    // الحذف من جدول الفواتير
    permissionAdd_bloc.instance.add(deletePermissionAdd_Event(deleteID: item.ID!));

    // الحذف للمستند كامل من الجرد
    List<BLLCondions> cond = [
      BLLCondions(enTable_Inv_ProductsQty.IDDocumentType.name, en_CondionsWhere.isEqualTo, en_DocumentType.permissionAdd.value),
      BLLCondions(enTable_Inv_ProductsQty.IDDocument.name, en_CondionsWhere.isEqualTo, item.ID!),
    ];

    productQty_bloc.instance.deleteByCondition(cond);

    // الرجوع للشاشة الرئيسية
    Navigator.of(context).pop();
  }

  void shareItem(Inv_PermissionAdd item) async {
    print('مشاركة  ${item.Code}  -  ID ${item.ID}');
  }
}

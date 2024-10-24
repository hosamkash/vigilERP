import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/bllFirebase/ManageBLL.dart';
import 'package:vigil_erp/bll/classModel/Def_FinancialCluses.dart';
import 'package:vigil_erp/blocManagment/blocDealing/dealing_bloc.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/blocManagment/blocFixTables/fix_table_bloc.dart';
import 'package:vigil_erp/blocManagment/bloc_Financial/financial_bloc.dart';
import 'package:vigil_erp/blocManagment/tablesCondions.dart';
import 'package:vigil_erp/componants/ctr_AlertDialog.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/screens/financial/2-Supplay/scr_SupplayItem.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/shared_controls.dart';
import '../../../bll/bllFirebase/bllFina_Supplay.dart';
import '../../../bll/classModel/Fina_Supplay.dart';

class scr_SupplayView extends StatefulWidget {
  scr_SupplayView({super.key});

  @override
  State<scr_SupplayView> createState() => _scr_SupplayViewState();
}

class _scr_SupplayViewState extends State<scr_SupplayView> {
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  TextEditingController controllerfilter = TextEditingController();
  TextEditingController contTotalValue = TextEditingController();
  TextEditingController contDateTo = TextEditingController();
  TextEditingController contDateFrom = TextEditingController();
  bool isGetAllDates = false;
  int? branchID;

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
    return SingleChildScrollView(
      child: Container(
        // height: 500,
        color: Colors.white,
        child: Column(
          children: [
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ctr_TextHeaderPage(
                  text: 'عرض سندات القبض',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                BlocBuilder<supplay_bloc, financial_state>(
                  builder: (context, state) {
                    if (state is getListSupplay_StateDataChanged)
                      return ctr_TextHeaderPage(
                        text: state.filterdLst_Supplay.length.toString(),
                        color: Colors.grey[300],
                        borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      );
                    else
                      return SizedBox();
                  },
                ),
              ],
            )),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: ctr_TextFormField(
                    Controller: controllerfilter,
                    PrefixIcon: const Icon(Icons.search),
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    OnChanged: (value) {
                      if (value != null) {
                        supplay_bloc.instance.add(filterAnySupplay_Event(filterData: value.trim()));
                      }
                      return null;
                    },
                  )),
                  IconButton(
                    onPressed: () {
                      controllerfilter.clear();
                      supplay_bloc.instance.add(resetFilterSupplay_Event());
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            buildListView(context),
          ],
        ),
      ),
    );
  }

  Widget buildListView(BuildContext context) {
    return BlocBuilder<supplay_bloc, financial_state>(
      builder: (context, state) {
        if (state is financialnitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is getListSupplay_StateDataChanged) {
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
                    width: 1200,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(
                            width: 120,
                            child: Text('الفرع', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                        SizedBox(
                            width: 120,
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
                            width: 90,
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
                            child: Text('بند القبض', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),

                        SizedBox(
                            width: 200,
                            child: Text('البيان', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                        SizedBox(
                            width: 40,
                            child: Text('مغلقة', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                        SizedBox(
                            width: 110,
                            child: Text('  ', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),

                  // ListView - Rows
                  Expanded(
                    child: SizedBox(
                      width: 1200,
                      height: 480,
                      child: ListView.separated(
                        // physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                        itemBuilder: (context, index) {
                          return buildListViewItem(state.filterdLst_Supplay[index], context);
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 1),
                        itemCount: state.filterdLst_Supplay.length,
                      ),
                    ),
                  ),

                  // Summary
                  SizedBox(
                    width: 1200,
                    height: 35,
                    child: Row(
                      children: [
                        SizedBox(width: 100),
                        BlocBuilder<supplay_bloc, financial_state>(
                          builder: (context, state) {
                            if (state is getListSupplay_StateDataChanged) {
                              contTotalValue.text =
                                  state.filterdLst_Supplay.fold(0.0, (previousValue, element) => previousValue + element.Value!).toStringAsFixed(2);
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
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  buildListViewItem(Fina_Supplay item, context) {
    return Column(
      children: [
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        InkWell(
          onDoubleTap: () => editItem(item),
          child: Container(
            color: item.IsClosedEdit! ? Colors.yellow[100] : Colors.white,
            height: 30,
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(company_bloc.instance.getNameByID(item.IDBranch),
                      textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 120,
                  child: Text(treasure_bloc.instance.getNameByID(item.IDTreasur),
                      textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                  width: 90,
                  child: Text(dealingType_bloc.instance.getNameByID(item.DealingTypeID),
                      textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 100,
                  child: Text(getDealingNameByID(item.DealingTypeID, item.DealingID),
                      textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 70,
                  child: Text(item.Value.toString(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 100,
                  child: Text(financialCluses_bloc.instance.getNameByID(item.IDFinancialCluses),
                      textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 200,
                  child: Text(item.Note!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 40,
                  child: Checkbox(value: item.IsClosedEdit, onChanged: (value) {}),
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

    loadDataFromDB();
  }

  Future loadDataFromDB() async {
    await company_bloc.instance.getLstBranchesAsDataSource();
    await treasure_bloc.instance.getList_TreasureAsDataSource();
    await dealingType_bloc.instance.getLst_dealingTypeAsDataSource();
    await financialCluses_bloc.instance.getLstFinancialAsDataSource(condions: [
      BLLCondions(enTable_Def_FinancialCluses.IsActive.name, en_CondionsWhere.isEqualTo, true),
      BLLCondions(enTable_Def_FinancialCluses.IDFinancialType.name, en_CondionsWhere.isEqualTo, en_finacialType.finacialTypeSupplay.value),
    ]);
    // await supplayType_bloc.instance.add(getListSupplayTypeAsDataSource_Event());
    client_bloc.instance.add(getListClient_Event());
    vendor_bloc.instance.add(getListVendor_Event());
    employee_bloc.instance.add(getListEmployee_Event());

    supplay_bloc.instance.add(getListSupplay_Event());
    if (controllerfilter.text.trim().isNotEmpty) {
      supplay_bloc.instance.add(filterAnySupplay_Event(filterData: controllerfilter.text.trim()));
    }
  }

  void newItem() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => scr_SupplayItem(null, scaffold, en_FormMode.NewMode),
      ),
    );

    if (result == true) loadDataFromDB();
  }

  void editItem(Fina_Supplay item) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => scr_SupplayItem(item, scaffold, en_FormMode.EditMode),
      ),
    );

    if (result == true) loadDataFromDB();
  }

  Widget buildCustomBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            sharedControls
                .showFormFilterByDates(context, en_TablesName.Fina_Supplay, branchID, contDateFrom, contDateTo, isGetAllDates)
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
                .createCondionsByDates(en_TablesName.Invoices_Sales, branchID, contDateFrom, contDateTo, isGetAllDates)
                .then((cond) => supplay_bloc.instance.add(getListSupplay_Event(conditions: cond)));
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

  void deleteItem(Fina_Supplay item) {
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
                  bllFina_Supplay.fire_DeleteItem(item.ID.toString());
                  loadDataFromDB();
                  Navigator.of(context).pop();
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

  void shareItem(Fina_Supplay item) async {
    print('مشاركة  ${item.Code}  -  ID ${item.ID}');
  }

  String getDealingNameByID(int? dealingTypeID, int? dealingID) {
    if (dealingTypeID == en_DealingType.Cliens.value)
      return client_bloc.instance.getNameByID(dealingID);
    else if (dealingTypeID == en_DealingType.Vendors.value)
      return vendor_bloc.instance.getNameByID(dealingID);
    else if (dealingTypeID == en_DealingType.Employees.value)
      return employee_bloc.instance.getNameByID(dealingID);
    else
      return '';
  }
}

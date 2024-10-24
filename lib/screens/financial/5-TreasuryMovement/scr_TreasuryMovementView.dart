import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/bllFirebase/ManageBLL.dart';
import 'package:vigil_erp/blocManagment/blocDealing/dealing_bloc.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/blocManagment/blocFixTables/fix_table_bloc.dart';
import 'package:vigil_erp/blocManagment/bloc_Financial/financial_bloc.dart';
import 'package:vigil_erp/blocManagment/tablesCondions.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/sharedHive.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/classModel/Fina_TreasuryMovementFull.dart';
import '../../../shared/sharedFunctions.dart';
import '../6-ClosedTreasure/scr_ClosedTreasureItem.dart';

class scr_TreasuryMovementView extends StatefulWidget {
  scr_TreasuryMovementView({super.key});

  @override
  State<scr_TreasuryMovementView> createState() => _scr_TreasuryMovementViewState();
}

class _scr_TreasuryMovementViewState extends State<scr_TreasuryMovementView> {
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  TextEditingController controllerfilter = TextEditingController();
  TextEditingController contSumExchange = TextEditingController();
  TextEditingController contSumSupplay = TextEditingController();
  TextEditingController contNetValue = TextEditingController();
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

      body: buildPageContent(),
    );
  }

  Widget buildPageContent() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ctr_TextHeaderPage(
                  text: 'حركة الخزينة',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                BlocBuilder<treasurMovement_bloc, financial_state>(
                  builder: (context, state) {
                    if (state is getListTreasuryMovement_StateDataChanged)
                      return ctr_TextHeaderPage(
                        text: state.filterdLst_TreasuryMovement.length.toString(),
                        color: Colors.grey[300],
                        borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      );
                    else
                      return SizedBox();
                  },
                ),
                ElevatedButton.icon(
                  label: Text(
                    'تقفيل',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[900]),
                  ),
                  icon: Icon(Icons.attach_money_outlined, color: Colors.blue[900]),
                  style: ElevatedButton.styleFrom(elevation: 2, backgroundColor: Colors.white),
                  onPressed: () {
                    closedTreasureRecipts();
                    // sharedControls.confirmDialog(context, 'تقفيل خزينة (يومية)', ' سيتم إنشاء مستند تقفيل خزينة (يومية) بالإيصالات المعروضة ', () {
                    //   closedTreasureRecipts();
                    // });
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
                        treasurMovement_bloc.instance.add(filterAnyTreasuryMovementMony_Event(filterData: value.trim()));
                      }
                      return null;
                    },
                  )),
                  IconButton(
                    onPressed: () {
                      controllerfilter.clear();
                      treasurMovement_bloc.instance.add(resetFilterTreasuryMovementMony_Event());
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
    return BlocBuilder<treasurMovement_bloc, financial_state>(
      builder: (context, state) {
        if (state is financialnitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is getListTreasuryMovement_StateDataChanged) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 540,
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
                          return buildListViewItem(state.filterdLst_TreasuryMovement[index], context);
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 1),
                        itemCount: state.filterdLst_TreasuryMovement.length,
                      ),
                    ),
                  ),

                  // Summary
                  SizedBox(
                    width: 1050,
                    height: 35,
                    child: Row(
                      children: [
                        SizedBox(width: 3),
                        BlocBuilder<treasurMovement_bloc, financial_state>(
                          builder: (context, state) {
                            if (state is getListTreasuryMovement_StateDataChanged) {
                              contSumExchange.text = state.filterdLst_TreasuryMovement
                                  .where((elm) => elm.FinacialTypeID == en_finacialType.finacialTypeExchange.value)
                                  .fold(0.0, (previousValue, element) => previousValue + element.Value!)
                                  .toStringAsFixed(2);

                              contSumSupplay.text = state.filterdLst_TreasuryMovement
                                  .where((elm) => elm.FinacialTypeID == en_finacialType.finacialTypeSupplay.value)
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
          onDoubleTap: () => editItem(item),
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
                  child: Text(item.BranchName ?? '', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 100,
                  child: Text(item.TreasurName ?? '', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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

    loadDataFromDB();
  }

  Future loadDataFromDB() async {
    await company_bloc.instance.getLstBranchesAsDataSource();
    await treasure_bloc.instance.getList_TreasureAsDataSource();
    await dealingType_bloc.instance.getLst_dealingTypeAsDataSource();
    await financialCluses_bloc.instance.getLstFinancialAsDataSource();

    client_bloc.instance.add(getListClient_Event());
    vendor_bloc.instance.add(getListVendor_Event());
    employee_bloc.instance.add(getListEmployee_Event());

    // هنا يتم تنفيذ الفلتر على سندات الدفع والقبض بتاريخ اليوم
    contDateFrom.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    contDateTo.text = sharedFunctions_Dates.convertToShortDateString(DateTime.now());
    var cond = await tablesCondions.createCondionsByDates(en_TablesName.Fina_TreasurMovement, null, contDateFrom, contDateTo, isGetAllDates);
    treasurMovement_bloc.instance.add(getListTreasuryMovementMony_Event(conditions: cond));
    if (controllerfilter.text.trim().isNotEmpty) {
      treasurMovement_bloc.instance.add(filterAnyTreasuryMovementMony_Event(filterData: controllerfilter.text.trim()));
    }
  }

  void closedTreasureRecipts() async {
    if (treasurMovement_bloc.instance.filterdLst_TreasuryMovementFull.where((elm) => elm.IsTransfere == false).length == 0) {
      sharedControls.toastNotification('لا توجد سندات نقدية فى الخزينة لم يتم تقفيلها', false);
      return;
    }

    // sharedControls.showScreenAsDialog(
    //   context,
    //   scr_ClosedTreasureItem(
    //     null,
    //     scaffold,
    //     en_FormMode.NewMode,
    //     lstTreasuryMovement: treasurMovement_bloc.instance.filterdLst_TreasuryMovementFull,
    //   ),
    // );
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => scr_ClosedTreasureItem(
          null,
          scaffold,
          en_FormMode.NewMode,
        ),
      ),
    );

    if (result == true) loadDataFromDB();
  }

  void editItem(Fina_TreasuryMovementFull item) async {
    // final result = await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => scr_TreasuryMovementItem(item, scaffold, en_FormMode.EditMode),
    //   ),
    // );
    //
    // if (result == true) loadDataFromDB();
  }

  Widget buildCustomBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            sharedControls
                // مفيش جدول لحركة الخزينة بيعبي أوفلاين من الدفع والقبض
                // بقي ناخد نفس الشروط ونفلتر بيها الدفع والقبض
                .showFormFilterByDates(context, en_TablesName.Fina_TreasurMovement, branchID, contDateFrom, contDateTo, isGetAllDates)
                .then((retValues) {
              if (retValues != null) {
                // isGetAllDates = retValues[0] as bool;
                // contDateFrom.text = retValues[1] as String;
                // contDateTo.text = retValues[2] as String;
                // branchID = retValues[3] as int?;
                // List<BLLCondions>
                // هنا يتم تنفيذ الفلتر على سندات الدفع والقبض
                treasurMovement_bloc.instance.add(getListTreasuryMovementMony_Event(conditions:retValues ));


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
                .then((cond) => treasurMovement_bloc.instance.add(getListTreasuryMovementMony_Event(conditions: cond)));
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
}

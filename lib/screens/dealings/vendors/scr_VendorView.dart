import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/blocManagment/blocDealing/dealing_bloc.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/blocManagment/blocFixTables/fix_table_bloc.dart';
import 'package:vigil_erp/componants/ctr_AlertDialog.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/screens/dealings/vendors/scr_vendorItem.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/sharedFunctions.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/bllDealing_Vendors.dart';
import '../../../bll/classModel/Dealing_Vendors.dart';

class scr_VendorView extends StatefulWidget {
  scr_VendorView({super.key});

  @override
  State<scr_VendorView> createState() => _scr_VendorViewState();
}

class _scr_VendorViewState extends State<scr_VendorView> {
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  TextEditingController controllerfilter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,

      //******************************* App Bar *************************************
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              loadDataFromDB();
            },
            icon: const Icon(Icons.cloud_download_rounded),
          ),
          const SizedBox(width: 210),
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
                text: 'الموردين',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
              ),
              BlocBuilder<vendor_bloc, dealing_state>(
                builder: (context, state) {
                  if (state is getListVendor_StateDataChanged)
                    return ctr_TextHeaderPage(
                      text: state.filterdLst_Vendor.length.toString(),
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
                      vendor_bloc.instance.add(filterAnyVendor_Event(filterData: value.trim()));
                    }
                    return null;
                  },
                )),
                IconButton(
                  onPressed: () {
                    controllerfilter.clear();
                    vendor_bloc.instance.add(resetFilterVendor_Event());
                  },
                  icon: const Icon(Icons.clear),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: buildListView(context),
          ),
        ],
      ),
    );
  }

  Widget buildListView(BuildContext context) {
    return BlocBuilder<vendor_bloc, dealing_state>(
      builder: (context, state) {
        if (state is vendor_StateInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is getListVendor_StateDataChanged) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Container(
                  color: Colors.grey[300],
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                  width: 970,
                  height: 30,
                  child: Row(
                    children: [
                      SizedBox(
                          width: 60,
                          child: Text('كود', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 120,
                          child: Text('الإســم', textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 100,
                          child: Text('الفرع', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 110,
                          child: Text('موبيل', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 110,
                          child: Text('هاتف', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 150,
                          child: Text('عنوان', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 80,
                          child:
                              Text('الرصيد الحالي', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 70, child: Text('', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 40,
                          child: Text('نشط', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 110,
                          child: Text('  ', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 970,
                    height: 480,
                    child: ListView.separated(
                      // physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                      itemBuilder: (context, index) {
                        return buildListViewItem(state.filterdLst_Vendor[index], context);
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 1),
                      itemCount: state.filterdLst_Vendor.length,
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

  buildListViewItem(Dealing_Vendors item, context) {
    return Column(
      children: [
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        InkWell(
          onDoubleTap: () => editItem(item),
          child: SizedBox(
            height: 30,
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
                  width: 120,
                  child: Text(
                    sharedFunctions_String.RemoveStringWords(item.Name ?? ''),
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    company_bloc.instance.getNameByID(item.IDBranch),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Text(
                    item.Mobile ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Text(
                    item.Phone ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    item.Address ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    item.CurrentBalance.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 70,
                  child: Text(
                    balanceType_bloc.instance.getNameByID(item.BalanceType),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Checkbox(value: item.IsActive, onChanged: (value) {}),
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
    company_bloc.instance.getLstBranchesAsDataSource();
    priceType_bloc.instance.getLst_PriceTypeAsDataSource();
    balanceType_bloc.instance.getLst_balanceTypeAsDataSource();
    loadDataFromDB();
  }

  Future loadDataFromDB() async {
    vendor_bloc.instance.add(getListVendor_Event());
    if (controllerfilter.text.trim().isNotEmpty) {
      vendor_bloc.instance.add(filterAnyVendor_Event(filterData: controllerfilter.text.trim()));
    }
  }

  void newItem() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => scr_VendorItem(null, scaffold, en_FormMode.NewMode),
      ),
    );

    if (result == true) loadDataFromDB();
  }

  void editItem(Dealing_Vendors item) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => scr_VendorItem(item, scaffold, en_FormMode.EditMode),
      ),
    );

    if (result == true) loadDataFromDB();
  }

  void deleteItem(Dealing_Vendors item) {
    print('حذف ${item.Name}  -  ID ${item.ID}');

    ctr_AlertDialog.showListFilter(
      context,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ctr_TextHeaderPage(
            text: 'هل تريد تأكيد حذف : \n ${item.Name}',
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
                  bllDealing_Vendors.fire_DeleteItem(item.ID.toString());
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

  void shareItem(Dealing_Vendors item) async {
    print('مشاركة  ${item.Name}  -  ID ${item.ID}');
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/componants/ctr_AlertDialog.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/screens/definitions/company/scr_CompanyItem.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/sharedFunctions.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/ManageBLL.dart';
import '../../../bll/bllFirebase/bllDef_CompanyStructure.dart';
import '../../../bll/classModel/Def_CompanyStructure.dart';

class scr_CompanyView extends StatefulWidget {
  scr_CompanyView({super.key});

  @override
  State<scr_CompanyView> createState() => _scr_CompanyViewState();
}

class _scr_CompanyViewState extends State<scr_CompanyView> {
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
                text: 'فروع الشركة',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
              ),
              BlocBuilder<company_bloc, definition_state>(
                builder: (context, state) {
                  if (state is getListCompany_StateDataChanged)
                    return ctr_TextHeaderPage(
                      text: state.filterdLst_Company.length.toString(),
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
                  PrefixIcon: Icon(Icons.search),
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  OnChanged: (value) {
                    if (value != null) {
                      company_bloc.instance.add(filterAnyCompany_Event(filterData: value.trim()));
                    } else {
                      return null;
                    }
                    return null;
                  },
                )),
                IconButton(
                  onPressed: () {
                    controllerfilter.clear();
                    company_bloc.instance.add(resetFilterCompany_Event());
                  },
                  icon: Icon(Icons.clear),
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
    return BlocBuilder<company_bloc, definition_state>(
      builder: (context, state) {
        if (state is getListCompany_StateInitial) {
          const LinearProgressIndicator(minHeight: 6);
          return const Center(child: CircularProgressIndicator());
        } else if (state is getListCompany_StateDataChanged) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Container(
                  color: Colors.grey[300],
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                  width: 780,
                  height: 30,
                  child: Row(
                    children: [
                      SizedBox(
                          width: 50,
                          child: Text('كود', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 120,
                          child: Text('الإســم', textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 200,
                          child: Text('العنوان', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 110,
                          child: Text('هاتف', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 110,
                          child: Text('موبيل', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 40,
                          child: Text('نشط', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 40,
                          child: Text('رئيسي', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 110,
                          child: Text('  ', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 780,
                    height: 500,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                      itemBuilder: (context, index) {
                        return buildListViewItem(state.filterdLst_Company[index], context);
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 1),
                      itemCount: state.filterdLst_Company.length,
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

  buildListViewItem(Def_CompanyStructure item, context) {
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
                  width: 50,
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
                  width: 200,
                  child: Text( sharedFunctions_String.RemoveStringWords(item.Adress ?? '',countWords: 4),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Text( item.Phone ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Text( item.Mobile ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(
                  width: 40,
                  child: Checkbox(value: item.isActive, onChanged: (value) {}),
                ),
                SizedBox(
                  width: 40,
                  child: Checkbox(value: item.isOwner, onChanged: (value) {}),
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

  buildBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          // width: double.infinity,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ctr_TextHeaderPage(
                    text: 'بيانات البحث',
                    color: Colors.grey[300],
                    borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    loadDataFromDB();
  }

  Future loadDataFromDB() async {
    company_bloc.instance.add(getListCompany_Event([BLLCondions(enTable_Def_CompanyStructure.isActive.name, en_CondionsWhere.isEqualTo, true)]));
    if (controllerfilter.text.trim().isNotEmpty) {
      company_bloc.instance.add(filterAnyCompany_Event(filterData: controllerfilter.text.trim()));
    }
  }

  void newItem() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => scr_CompanyItem(null, scaffold, en_FormMode.NewMode),
      ),
    );

    if (result == true) {
      loadDataFromDB();
    }
  }

  void editItem(Def_CompanyStructure item) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => scr_CompanyItem(item, scaffold, en_FormMode.EditMode),
      ),
    );

    if (result == true) loadDataFromDB();
  }

  void deleteItem(Def_CompanyStructure item) {
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
                  bllDef_CompanyStructure.fire_DeleteItem(item.ID.toString());
                  loadDataFromDB();
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(width: 10),
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

  void shareItem(Def_CompanyStructure item) async {
    print('مشاركة  ${item.Name}  -  ID ${item.ID}');
  }
}

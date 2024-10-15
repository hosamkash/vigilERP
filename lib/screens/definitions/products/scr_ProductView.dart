import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/classModel/Def_Units.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/componants/ctr_AlertDialog.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/screens/definitions/products/scr_ProductItem.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/sharedFunctions.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/ManageBLL.dart';
import '../../../bll/bllFirebase/bllDef_ProductStructure.dart';
import '../../../bll/classModel/Def_Categories.dart';
import '../../../bll/classModel/Def_ProductStructure.dart';

class scr_ProductView extends StatefulWidget {
  scr_ProductView({super.key});

  @override
  State<scr_ProductView> createState() => _scr_ProductViewState();
}

class _scr_ProductViewState extends State<scr_ProductView> {
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  TextEditingController contFilter = TextEditingController();
  int? categoryID;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ctr_TextHeaderPage(
                text: 'الأصناف',
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 0),
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
              ),
              BlocBuilder<product_bloc, definition_state>(
                builder: (context, state) {
                  if (state is getListProduct_StateDataChanged)
                    return ctr_TextHeaderPage(
                      text: state.filterdLst_Product.length.toString(),
                      color: Colors.grey[300],
                      borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    );
                  else
                    return SizedBox();
                },
              ),
            ],
          ),
          BlocBuilder<categories_bloc, definition_state>(builder: (context, state) {
            if (state is categories_StateInitial) {
              const LinearProgressIndicator(minHeight: 6);
              return const Center(child: CircularProgressIndicator());
            } else if (state is getListCategories_StateDataChanged) {
              return ctr_DropDowenList(
                hintLable: 'التصنيف',
                padding: const EdgeInsets.only(left: 0, right: 10, bottom: 5, top: 0),
                lstDataSource: categories_bloc.instance.LstCategoriesAsDataSource,
                hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                menuMaxHeightValue: 300,
                selectedValue: categoryID,
                OnChanged: (returnID) {
                  setState(() {
                    categoryID = returnID;
                    product_bloc.instance.add(filterAnyProduct_Event(filterData: contFilter.text.trim(), categoryID: categoryID));
                  });
                  return null;
                },
              );
            } else
              return SizedBox();
          }),
          Row(
            children: [
              Expanded(
                  child: ctr_TextFormField(
                Controller: contFilter,
                PrefixIcon: const Icon(Icons.search),
                padding: const EdgeInsets.only(left: 0, right: 10, bottom: 5, top: 0),
                OnChanged: (value) {
                  if (value != null) {
                    product_bloc.instance.add(filterAnyProduct_Event(filterData: value.trim(), categoryID: categoryID));
                  } else {
                    return null;
                  }
                  return null;
                },
              )),
              IconButton(
                onPressed: () {
                  contFilter.clear();
                  product_bloc.instance.add(filterAnyProduct_Event(filterData: contFilter.text.trim(), categoryID: categoryID));
                },
                icon: const Icon(Icons.clear),
              ),
            ],
          ),
          Expanded(
            child: buildListView(context),
          ),
        ],
      ),
    );
  }

  Widget buildListView(BuildContext context) {
    return BlocBuilder<product_bloc, definition_state>(
      builder: (context, state) {
        if (state is product_StateInitial) {
          const LinearProgressIndicator(minHeight: 6);
          return const Center(child: CircularProgressIndicator());
        } else if (state is getListProduct_StateDataChanged) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Container(
                  color: Colors.grey[300],
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                  width: 1040,
                  height: 30,
                  child: Row(
                    children: [
                      SizedBox(
                          width: 60,
                          child: Text('باركود', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 150,
                          child: Text('الصـــنف', textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 100,
                          child: Text('التصنيف', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 40,
                          child: Text('نشط', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 40,
                          child: Text('POS', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 65,
                          child: Text('تم التعديل', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      // SizedBox(
                      //     width: 50,
                      //     child: Text('صورة', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      // ************************************ الأسعار
                      SizedBox(
                          width: 60,
                          child: Text('الوحدة', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 60,
                          child: Text('شراء', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 60,
                          child: Text('بيع 1', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 60,
                          child: Text('بيع 2', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 60,
                          child: Text('بيع 3', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 60,
                          child: Text('بيع 4', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 60,
                          child: Text('بيع 5', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),

                      SizedBox(
                          width: 110,
                          child: Text('  ', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 1040,
                    height: 480,
                    child: ListView.separated(
                      // physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                      itemBuilder: (context, index) {
                        return buildListViewItem(state.filterdLst_Product[index], context);
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 1),
                      itemCount: state.filterdLst_Product.length,
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

  buildListViewItem(Def_ProductStructure item, context) {
    return Column(
      children: [
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        InkWell(
          onDoubleTap: () => editItem(item),
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    item.BarCode.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    sharedFunctions_String.RemoveStringWords(item.Name ?? ''),
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    categories_bloc.instance.getNameByID(item.IDCategory),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Checkbox(value: item.IsActive, onChanged: (value) {}),
                ),
                SizedBox(
                  width: 40,
                  child: Checkbox(value: item.IsPOS, onChanged: (value) {}),
                ),
                SizedBox(
                  width: 65,
                  child: Checkbox(value: item.IsUpdated, onChanged: (value) {}),
                ),

                // // لو الصورة موجودة يظهرها
                // if (item.ImageURL1 == null || item.ImageURL1!.isEmpty ? false : true)
                //   SizedBox(
                //     width: 50,
                //     child: Image(image: NetworkImage(item.ImageURL1 ?? ''), height: 40, width: 40),
                //   ),
                // // لو الصورة مش موجودة يظهر نفس المساحة فاضية
                // if (item.ImageURL1 == null || item.ImageURL1!.isEmpty ? true : false)
                //   SizedBox(
                //     width: 50,
                //     // child: Image(image: NetworkImage(item.ImageURL ?? ''), height: 40, width: 40),
                //   ),

                // ********************************* الأسعار
                Column(
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        unit_bloc.instance.getNameByID(item.UnitBig_ID),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        unit_bloc.instance.getNameByID(item.UnitSmall_ID),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        item.UnitBig_PurchasePrice.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        item.UnitSmall_PurchasePrice.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        item.UnitBig_Sales1.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        item.UnitSmall_Sales1.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        item.UnitBig_Sales2.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        item.UnitSmall_Sales2.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        item.UnitBig_Sales3.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        item.UnitSmall_Sales3.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        item.UnitBig_Sales4.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        item.UnitSmall_Sales4.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        item.UnitBig_Sales5.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        item.UnitBig_Sales5.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    )
                  ],
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
    // List<BLLCondions>? condions=[
    //   ,
    // ];

    categories_bloc.instance.add(getListCategories_Event([BLLCondions(enTable_Def_Categories.IsActive.name, en_CondionsWhere.isEqualTo, true)]));
    categories_bloc.instance.getList_CategoryAsDataSource(condions: [BLLCondions(enTable_Def_Categories.IsActive.name, en_CondionsWhere.isEqualTo, true)]);
    unit_bloc.instance.getLstUnitsAsDataSource(condions: [BLLCondions(enTable_Def_Units.IsActive.name, en_CondionsWhere.isEqualTo, true)]);
    loadDataFromDB();
  }

  Future loadDataFromDB() async {
    product_bloc.instance.add(getListProduct_Event([BLLCondions(enTable_Def_ProductStructure.IsActive.name, en_CondionsWhere.isEqualTo, true)]));
    if (contFilter.text.trim().isNotEmpty) {
      product_bloc.instance.add(filterAnyProduct_Event(filterData: contFilter.text.trim()));
    }
  }

  void newItem() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => scr_ProductItem(null, scaffold, en_FormMode.NewMode),
      ),
    );
    if (result != null) {
      product_bloc.instance.filterdLst_Product.add(result);
      product_bloc.instance.add(refreshProduct_Event());
    }
  }

  void editItem(Def_ProductStructure item) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => scr_ProductItem(item, scaffold, en_FormMode.EditMode),
      ),
    );
    if (result != null) {
      item = result;
      product_bloc.instance.add(refreshProduct_Event());
    }
  }

  // Future filterByCategory() async {
  //   product_bloc.instance.add(filterAnyProduct_Event(filterData: contFilter.text.trim(), categoryID: categoryID));
  // }

  void deleteItem(Def_ProductStructure item) {
    print('حذف ${item.Name}  -  ID ${item.ID}');
    ctr_AlertDialog.showListFilter(
      context,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ctr_TextHeaderPage(
            text: 'هل تريد تأكيد حذف : \n ${item.Name}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              ElevatedButton.icon(
                label: const Text(
                  'حذف',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                icon: const Icon(Icons.delete_forever),
                iconAlignment: IconAlignment.end,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 3),
                onPressed: () {
                  bllDef_ProductStructure.fire_DeleteItem(item.ID.toString());
                  loadDataFromDB();
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                label: const Text(
                  'الغاء',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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

  void shareItem(Def_ProductStructure item) async {
    print('مشاركة  ${item.Name}  -  ID ${item.ID}');
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/blocManagment/blocFixTables/fix_table_bloc.dart';
import 'package:vigil_erp/blocManagment/blocInventory/inv_bloc.dart';
import 'package:vigil_erp/componants/ctr_AlertDialog.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/sharedFunctions.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

import '../../../bll/bllFirebase/ManageBLL.dart';
import '../../../bll/classModel/Inv_ProductsQty.dart';

class scr_ProductsQtyView extends StatefulWidget {
  scr_ProductsQtyView({super.key});

  @override
  State<scr_ProductsQtyView> createState() => _scr_ProductsQtyViewState();
}

class _scr_ProductsQtyViewState extends State<scr_ProductsQtyView> {
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  TextEditingController controllerfilter = TextEditingController();
  TextEditingController contQty = TextEditingController();
  TextEditingController contQtyRepresents = TextEditingController();
  TextEditingController contTotalQty = TextEditingController();
  TextEditingController contTotalPrice = TextEditingController();
  int? stockID;
  int? priceTypeID;
  int? hideQtyZeroID;

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
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ctr_TextHeaderPage(
                text: 'رصيد الأصناف',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
              ),
              BlocBuilder<productQty_bloc, inv_state>(
                builder: (context, state) {
                  if (state is productQty_StateDataChanged) {
                    return ctr_TextHeaderPage(
                      text: state.filterdLst_productQty.length.toString(),
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
          // const SizedBox(height: 5),
          SizedBox(
            height: 60,
            child: Row(
              children: [
                Expanded(
                    child: ctr_TextFormField(
                  Controller: controllerfilter,
                  PrefixIcon: const Icon(Icons.search),
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 0),
                  OnChanged: (value) {
                    if (value != null) {
                      productQty_bloc.instance.add(filterAnyProductsQty_Event(filterData: value.trim()));
                    }
                    return null;
                  },
                )),
                IconButton(
                  onPressed: () {
                    controllerfilter.clear();
                    productQty_bloc.instance.add(resetFilterProductsQty_Event());
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
    return BlocBuilder<productQty_bloc, inv_state>(
      builder: (context, state) {
        if (state is productQty_StateInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is productQty_StateDataChanged) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Column Header
                Container(
                  color: Colors.grey[300],
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                  width: 820,
                  height: 30,
                  child: Row(
                    children: [
                      SizedBox(
                          width: 130,
                          child: Text('المخزن', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 170,
                          child: Text('الصـــنف', textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 90,
                          child: Text('التصنيف', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 80,
                          child: Text('مخزن', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 80,
                          child: Text('مندوب', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 80,
                          child: Text('إجمالى', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 75,
                          child: Text('السعر', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 100,
                          child: Text('الإجمالى', textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),

                // ListView - Rows
                Expanded(
                  child: SizedBox(
                    width: 820,
                    height: 470,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(right: 2, left: 2),
                      itemBuilder: (context, index) {
                        return buildListViewItem(state.filterdLst_productQty[index], context);
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 1),
                      itemCount: state.filterdLst_productQty.length,
                    ),
                  ),
                ),


                // Summary
                SizedBox(
                  width: 820,
                  height: 30,
                  child:  BlocBuilder<productQty_bloc, inv_state>(
                    builder: (context, state) {
                      if (state is productQty_StateDataChanged) {
                        contQty.text = state.sumQty.toString();
                        contQtyRepresents.text = state.sumQtyRepresents.toString();
                        contTotalQty.text = state.sumTotalQty.toString();
                        contTotalPrice.text = state.sumTotalPrice.toString();
                        return Row(
                          children: [
                            SizedBox(width: 390),
                            SizedBox(
                              width: 80,
                              child: ctr_TextFormField(
                                Controller: contQty,
                                Lable: 'مخزن',
                                readOnly: true,
                                textStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: ctr_TextFormField(
                                Controller: contQtyRepresents,
                                Lable: 'مندوب',
                                readOnly: true,
                                textStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: ctr_TextFormField(
                                Controller: contTotalQty,
                                Lable: 'إجمالى',
                                readOnly: true,
                                textStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 120,
                              child: ctr_TextFormField(
                                Controller: contTotalPrice,
                                Lable: 'إجمالى السعر',
                                readOnly: true,
                                textStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ],
                        );
                      } else
                        return SizedBox();
                    },
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

  buildListViewItem(Inv_ProductsQty item, context) {
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 1),
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
                width: 130,
                child: Text(
                  '${sharedFunctions_String.RemoveStringWords(item.StockName!)}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  // textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 170,
                child: Text(
                  '${item.BarCode!} - ${sharedFunctions_String.RemoveStringWords(item.ProductName!)}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                  // textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 90,
                child: Text(
                  '${item.ClasseficationsName!}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  '${item.Qty ?? 0}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  '${item.QtyRepresents!}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  '${item.TotalQty ?? 0}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 75,
                child: Text(
                  '${item.Price ?? 0}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 100,
                child: Text(
                  '${item.TotalPrice != null ? item.TotalPrice!.toStringAsFixed(2) : 0}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // company_bloc.instance.add(getListCompany_Event());
    //  stock_bloc.instance.add(getListStock_Event());
    //  stock_bloc.instance.add(getLstStocksAsDataSource_Event());

    loadDataFromDB();
  }

  Widget buildCustomBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            showMoreFilterData();
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
            loadDataFromDB();
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

  Future<void> loadDataFromDB() async {
    stock_bloc.instance.getLstStockAsDataSource();
    priceType_bloc.instance.getLst_PriceTypeAsDataSource();

    productQty_bloc.instance.add(getListProductsQty_Event());
    if (controllerfilter.text.trim().isNotEmpty) {
      productQty_bloc.instance.add(filterAnyProductsQty_Event(filterData: controllerfilter.text.trim()));
    }
  }

  void showMoreFilterData() async {
    ctr_AlertDialog.showListFilter(
      context,
      content: Column(
        mainAxisSize: MainAxisSize.min, // يجعل الارتفاع يتناسب مع المحتويات
        children: [
          Text(
            'فلتر لأرصدة الأصناف',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ctr_DropDowenList(
            hintLable: 'المخزن',
            padding: const EdgeInsets.only(top: 0, right: 5, bottom: 5, left: 0),
            lstDataSource: stock_bloc.instance.LstStocksAsDataSource,
            hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
            itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
            menuMaxHeightValue: 300,
            showClearIcon: true,
            selectedValue: stockID,
            OnChanged: (returnID) {
              stockID = returnID;
              return stockID;
            },
          ),
          ctr_DropDowenList(
            hintLable: 'تقييم المخزون بسعر',
            padding: const EdgeInsets.only(top: 0, right: 5, bottom: 5, left: 0),
            lstDataSource: priceType_bloc.instance.lstPriceTypeAsDataSource,
            hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
            itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
            menuMaxHeightValue: 300,
            showClearIcon: true,
            selectedValue: priceTypeID,
            OnChanged: (returnID) {
              priceTypeID = returnID;
              return priceTypeID;
            },
          ),
          ctr_DropDowenList(
            hintLable: 'إخفاء الكمية = 0 من',
            padding: const EdgeInsets.only(top: 0, right: 5, bottom: 5, left: 0),
             lstDataSource: en_HideZeroFrom.getListDropDowen() ,
            // lstDataString: en_HideZeroFrom.getListArabic() ,
            hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
            itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
            menuMaxHeightValue: 300,
            showClearIcon: true,
             selectedValue: hideQtyZeroID,
            OnChanged: (val) {
              hideQtyZeroID = val;
              return null;
            },
          ),
          Center(
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    List<BLLCondions> cond = [];
                    cond.add(BLLCondions('IDStock', en_CondionsWhere.isEqualTo, stockID));
                    productQty_bloc.instance.add(getListProductsQtyByCondions_Event(
                        condions: cond , priceType:priceTypeID , hideQtyZeroID : hideQtyZeroID));
                    Navigator.of(context).pop();
                    // Navigator.pop(context, cProduct);
                  },
                  child: Text('تأكيد', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('إلغاء', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

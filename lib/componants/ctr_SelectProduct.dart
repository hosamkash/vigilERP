import 'package:flutter/material.dart';
import 'package:vigil_erp/shared/sharedDesigne.dart';
import '../bll/bllFirebase/bllDef_ProductStructure.dart';
import '../bll/classModel/Def_ProductStructure.dart';
import '../blocManagment/blocDefinition/definition_bloc.dart';
import '../blocManagment/blocFixTables/fix_table_bloc.dart';
import '../shared/enumerators.dart';
import '../shared/shared_controls.dart';
import 'ctr_DropDowenList.dart';
import 'ctr_TextFormField.dart';

class ctr_SelectProduct extends StatefulWidget {
  static final GlobalKey<_ctr_SelectProductState> keyx = GlobalKey<_ctr_SelectProductState>();

  @override
  _ctr_SelectProductState createState() => _ctr_SelectProductState();

  List<Def_ProductStructure> lstProducts = [];
  List<Def_ProductStructure> lstProductsFilterd = [];
  TextEditingController filterController = TextEditingController();
  int? categoryID;
  int? priceTypeID;
  bool chkUseBigUnit = false;
  double currentPrice = 0;
  double? widthControl;
  EdgeInsets? padding;
  Icon? suffixIcon;
  Icon? prefixIcon;
  String? labelText;
  TextStyle? labelStyle;


  void Function(customProductItem) onAddProduct;

  ctr_SelectProduct({
    this.widthControl,
    this.padding,
    this.suffixIcon,
    this.prefixIcon,
    this.labelText,
    this.labelStyle,
    required this.onAddProduct,
     this.priceTypeID,

  });

  static double getPriceWhereType(Def_ProductStructure item, int? priceTypeID, bool isBigUnit) {
    double currenPrice = 0;

    // السعر بناء على - وحدة كبري
    if (priceTypeID == en_PriceType.purchasePrice.value && isBigUnit)
      currenPrice = item.UnitBig_PurchasePrice!;
    else if (priceTypeID == en_PriceType.salesPrice1.value && isBigUnit)
      currenPrice = item.UnitBig_Sales1!;
    else if (priceTypeID == en_PriceType.salesPrice2.value && isBigUnit)
      currenPrice = item.UnitBig_Sales2!;
    else if (priceTypeID == en_PriceType.salesPrice3.value && isBigUnit)
      currenPrice = item.UnitBig_Sales3!;
    else if (priceTypeID == en_PriceType.salesPrice4.value && isBigUnit)
      currenPrice = item.UnitBig_Sales4!;
    else if (priceTypeID == en_PriceType.salesPrice5.value && isBigUnit)
      currenPrice = item.UnitBig_Sales5!;

    // السعر بناء على - وحدة صغري
    else if (priceTypeID == en_PriceType.purchasePrice.value && !isBigUnit)
      currenPrice = item.UnitSmall_PurchasePrice!;
    else if (priceTypeID == en_PriceType.salesPrice1.value && !isBigUnit)
      currenPrice = item.UnitSmall_Sales1!;
    else if (priceTypeID == en_PriceType.salesPrice2.value && !isBigUnit)
      currenPrice = item.UnitSmall_Sales2!;
    else if (priceTypeID == en_PriceType.salesPrice3.value && !isBigUnit)
      currenPrice = item.UnitSmall_Sales3!;
    else if (priceTypeID == en_PriceType.salesPrice4.value && !isBigUnit)
      currenPrice = item.UnitSmall_Sales4!;
    else if (priceTypeID == en_PriceType.salesPrice5.value && !isBigUnit) currenPrice = item.UnitSmall_Sales5!;

    return currenPrice;
  }

  Future editProduct(BuildContext context, int productID, int priceTypeID, bool isUseBigUnit, double Price, int Qty ,
  {bool showUseBigUnit = true}) {
    Def_ProductStructure item = bllDef_ProductStructure.lstDef_ProductStructure.firstWhere((x) => x.ID == productID);
    final TextEditingController contQty = TextEditingController(text: Qty.toString());
    final TextEditingController contPrice = TextEditingController(text: Price.toString());
    bool? isBigUnit = isUseBigUnit;

   return showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateNew) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: Text(
                    item.Name!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                  )),
                  ctr_DropDowenList(
                    hintLable: 'فئة السعر',
                    padding: const EdgeInsets.only(top: 10, right: 5, bottom: 5, left: 0),
                    height: 55,
                    lstDataSource: priceType_bloc.instance.lstPriceTypeAsDataSource,
                    hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                    itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                    menuMaxHeightValue: 300,
                    selectedValue: priceTypeID,
                    showClearIcon: false,
                    OnChanged: (returnID) {
                      setStateNew(() {
                        priceTypeID = returnID!;
                        contPrice.text = ctr_SelectProduct.getPriceWhereType(item, priceTypeID, isBigUnit!).toString();
                      });
                      return priceTypeID;
                    },
                  ),
                  if(showUseBigUnit)
                  Row(
                    children: [
                      Checkbox(
                          value: isBigUnit,
                          onChanged: (value) {
                            setStateNew(() {
                              isBigUnit = !isBigUnit!;
                              contPrice.text = ctr_SelectProduct.getPriceWhereType(item, priceTypeID, isBigUnit!).toString();
                            });
                          }),
                      const Text('وحدة كبري', style: TextStyle(fontSize: 17)),
                    ],
                  ),
                  ctr_TextFormField(
                    Controller: contQty,
                    padding: padding ?? EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5),
                    Lable: 'الكمية',
                    TextType: TextInputType.number,
                    OnValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'لابد من إدخال قيمة';
                      }
                      return null;
                    },
                  ),
                  ctr_TextFormField(
                    Controller: contPrice,
                    padding: const EdgeInsets.only(top: 0, right: 5, bottom: 5),
                    Lable: 'السعر',
                    TextType: TextInputType.number,
                    OnValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'لابد من إدخال قيمة';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    customProductItem cProduct = customProductItem(
                      ID: item.ID,
                      BarCode: item.BarCode,
                      Name: item.Name,
                      IDCategory: item.IDCategory,
                      IDProductionCompany: item.IDProductionCompany,
                      IDPriceType: priceTypeID,
                      UnitBig_ID: item.UnitBig_ID,
                      UnitCountOf: item.UnitCountOf,
                      UnitSmall_ID: item.UnitSmall_ID,
                      controller: item.controller = contQty,
                      isBigUnit: isBigUnit,
                    );
                    // التأكد من إن العميل غير السعر الافتراضي
                    double priceBig = ctr_SelectProduct.getPriceWhereType(item, priceTypeID, true);
                    double priceSmall = ctr_SelectProduct.getPriceWhereType(item, priceTypeID, false);
                    if (isBigUnit! == true && double.parse(contPrice.text) != priceBig) {
                      cProduct.UnitBigPrice = double.parse(double.parse(contPrice.text).toStringAsFixed(2));
                      cProduct.UnitSmllPrice = double.parse((cProduct.UnitBigPrice! / cProduct.UnitCountOf!).toStringAsFixed(2));
                    } else if (isBigUnit! == false && double.parse(contPrice.text) != priceSmall) {
                      cProduct.UnitSmllPrice = double.parse(double.parse(contPrice.text).toStringAsFixed(2));
                      cProduct.UnitBigPrice = double.parse((cProduct.UnitSmllPrice! * cProduct.UnitCountOf!).toStringAsFixed(2));
                    } else {
                      cProduct.UnitBigPrice = priceBig;
                      cProduct.UnitSmllPrice = priceSmall;
                    }
                    // cProduct.rowIndex = index;
                    // permissionAdd_bloc.instance.add(editRowPermissionAddDetails_Event(itemCustomProduct: cProduct, index: index));
                    Navigator.pop(context, cProduct);
                  },
                  child: Text('تأكيد', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('إلغاء', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _ctr_SelectProductState extends State<ctr_SelectProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? const EdgeInsets.all(0),
      width: widget.widthControl ?? double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ctr_DropDowenList(
              hintLable: 'التصنيف',
              padding: const EdgeInsets.only(top: 5, right: 0, bottom: 5, left: 0),
              height: 50,
              lstDataSource: categories_bloc.instance.LstCategoriesAsDataSource,
              hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
              itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
              menuMaxHeightValue: 300,
              selectedValue: widget.categoryID,
              OnChanged: (returnID) {
                setState(() {
                  // if(returnID != null)
                  // widget.categoryID = returnID;
                  // else
                  widget.categoryID = returnID;
                  filterProducts();
                });
                return null;
              },
            ),
            Row(
              children: [
                Expanded(
                  child: ctr_DropDowenList(
                    hintLable: 'فئة السعر',
                    padding: const EdgeInsets.only(top: 0, right: 5, bottom: 5, left: 0),
                    lstDataSource: priceType_bloc.instance.lstPriceTypeAsDataSource,
                    hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                    itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                    menuMaxHeightValue: 300,
                    selectedValue: widget.priceTypeID,
                    OnChanged: (returnID) {
                      setState(() {
                        widget.priceTypeID = returnID;
                      });
                      return widget.priceTypeID;
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: Checkbox(
                      value: widget.chkUseBigUnit,
                      onChanged: (value) {
                        setState(() {
                          widget.chkUseBigUnit = !widget.chkUseBigUnit;
                        });
                      }),
                ),
                SizedBox(width: 70, child: const Text('وحدة كبري', style: TextStyle(fontSize: 17))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, right: 5, bottom: 0, left: 0),
              child: ctr_TextFormField(
                Controller: widget.filterController,
                Lable: widget.labelText ?? 'البحث فى الأصناف',
                labelStyle: widget.labelStyle ?? const TextStyle(fontSize: 17, color: Colors.grey),
                PrefixIcon: widget.suffixIcon,
                useAsBarcodeControle: true,
                SufixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      widget.filterController.clear();
                      widget.lstProductsFilterd = widget.lstProducts;
                    });
                  },
                  icon: widget.prefixIcon ?? const Icon(Icons.clear),
                  color: Colors.black,
                ),
                OnChanged: (value) {
                  setState(() {
                    filterProducts();
                    print('lstDataFilterd : ${widget.lstProductsFilterd.length}');
                  });
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 500,
              child: buildListView(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 0, bottom: 50, left: 0),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        // padding: const EdgeInsets.only(right: 2, left: 2),
        itemBuilder: (context, index) {
          if (widget.lstProductsFilterd[index].controller == null) {
            widget.lstProductsFilterd[index].controller = TextEditingController(text: '1');
          }
          return BuildItem(widget.lstProductsFilterd[index], context);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 1),
        itemCount: widget.lstProductsFilterd.length,
      ),
    );
  }

  BuildItem(Def_ProductStructure item, context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Text(item.BarCode.toString(), style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 5),
              SizedBox(
                  width: 160,
                  child: Text(
                    item.Name.toString(),
                    style: const TextStyle(fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
            ],
          ),
          Row(
            children: [
              Text('التصنيف: ${categories_bloc.instance.getNameByID(item.IDCategory)}', style: const TextStyle(fontSize: 14)),
              // const SizedBox(width: 5),
              // SizedBox(
              //     width: 160,
              //     child: Text(
              //       item.Name.toString(),
              //       style: const TextStyle(fontSize: 15),
              //       maxLines: 1,
              //       overflow: TextOverflow.ellipsis,
              //     )),
            ],
          ),
          Row(
            children: [
              Text(ctr_SelectProduct.getPriceWhereType(item, widget.priceTypeID, widget.chkUseBigUnit).toString(),
                  style: const TextStyle(fontSize: 17)),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () {
                  if (item.controller != null) {
                    item.controller!.text = (int.parse(item.controller!.text) + 1).toString();
                  }
                },
                icon: const Icon(Icons.add_box, color: sharedDesigne.primaryColor),
              ),
              SizedBox(
                width: 35,
                height: 30,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  ),
                  controller: item.controller,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (int.parse(item.controller!.text) > 1) {
                    if (item.controller != null) {
                      item.controller!.text = (int.parse(item.controller!.text) - 1).toString();
                    }
                  }
                },
                icon: const Icon(
                  Icons.remove_circle,
                  color: sharedDesigne.primaryColor,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (widget.priceTypeID == null) {
                    sharedControls.toastNotification('لابد من اختيار فئة السعر', false);
                    return;
                  }
                  if (item.controller == null || item.controller!.text.isEmpty || int.parse(item.controller!.text) == 0) {
                    sharedControls.toastNotification('يرجى كتابة الكمية المضافة', false);
                    return;
                  }
                  if (ctr_SelectProduct.getPriceWhereType(item, widget.priceTypeID, widget.chkUseBigUnit) == 0) {
                    sharedControls.toastNotification('لابد أن يكون الصنف له سعر', false);
                    return;
                  }

                  widget.onAddProduct(customProductItem(
                    ID: item.ID,
                    BarCode: item.BarCode,
                    Name: item.Name,
                    IDCategory: item.IDCategory,
                    IDProductionCompany: item.IDProductionCompany,
                    IDPriceType: widget.priceTypeID,
                    UnitBig_ID: item.UnitBig_ID,
                    UnitBigPrice: ctr_SelectProduct.getPriceWhereType(item, widget.priceTypeID, true),
                    UnitCountOf: item.UnitCountOf,
                    UnitSmall_ID: item.UnitSmall_ID,
                    UnitSmllPrice: ctr_SelectProduct.getPriceWhereType(item, widget.priceTypeID, false),
                    controller: item.controller,
                    isBigUnit: widget.chkUseBigUnit,
                  ));
                },
                label: const Text(
                  '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                icon: const Icon(Icons.add_shopping_cart),
                iconAlignment: IconAlignment.end,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 4,
                ),
              ),
              // SizedBox(width: 5),
              // const Text('Total' , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.filterController.text = '';
    ReadAllDefaultData();
  }

  void ReadAllDefaultData() async {
    if (bllDef_ProductStructure.lstDef_ProductStructure.length == 0) {
      await product_bloc.instance.getList_Product();
    }
    widget.lstProducts = widget.lstProductsFilterd = bllDef_ProductStructure.lstDef_ProductStructure;
  }

  void filterProducts() async {
    // لو مفيش فلتر يرجع القائمة الأساسية
    if (widget.filterController.text.isEmpty && widget.categoryID == null && widget.priceTypeID == null) {
      widget.lstProductsFilterd = widget.lstProducts;
      return;
    }

    widget.lstProductsFilterd = await widget.lstProducts.where((item) {
      final matchesBarCode =
          item.BarCode == null ? false : item.BarCode!.toString().toLowerCase().contains(widget.filterController.text.toLowerCase());
      final matchesName = item.Name == null ? false : item.Name!.toLowerCase().contains(widget.filterController.text.toLowerCase());
      // final matchesCategory = widget.categoryID != null && item.IDCategory == widget.categoryID;
      // final matchesPriceType =
      //     widget.priceTypeID == en_PriceType.purchasePrice ? item.UnitBig_PurchasePrice : false;

      return (matchesBarCode || matchesName) ;//&& matchesCategory
    }).toList();
  }
}

class customProductItem {
  // int? rowIndex;

  int? ID;
  int? BarCode;
  String? Name;
  int? IDCategory;
  int? IDProductionCompany;
  int? IDPriceType;
  int? UnitBig_ID;
  double? UnitBigPrice;
  int? UnitCountOf;
  int? UnitSmall_ID;
  double? UnitSmllPrice;
  TextEditingController? controller;
  bool? isBigUnit;

  customProductItem({
    // this.rowIndex,
    this.ID,
    this.BarCode,
    this.Name,
    this.IDCategory,
    this.IDProductionCompany,
    this.IDPriceType,
    this.UnitBig_ID,
    this.UnitBigPrice,
    this.UnitCountOf,
    this.UnitSmall_ID,
    this.UnitSmllPrice,
    this.controller,
    this.isBigUnit,
  });
}

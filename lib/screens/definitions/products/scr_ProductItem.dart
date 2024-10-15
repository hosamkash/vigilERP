import 'package:flutter/material.dart';
import 'package:vigil_erp/blocManagment/blocDefinition/definition_bloc.dart';
import 'package:vigil_erp/componants/ctr_DropDowenList.dart';
import 'package:vigil_erp/componants/ctr_TextFormField.dart';
import 'package:vigil_erp/componants/ctr_TextHeaderPage.dart';
import 'package:vigil_erp/shared/enumerators.dart';
import 'package:vigil_erp/shared/shared_controls.dart';
import '../../../bll/bllFirebase/ManageBLL.dart';
import '../../../bll/bllFirebase/bllDef_ProductStructure.dart';
import '../../../bll/classModel/Def_ProductStructure.dart';

class scr_ProductItem extends StatefulWidget {
  scr_ProductItem(this.itemProduct, this.scaffold, this.frmMode, {super.key});

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  Def_ProductStructure? itemProduct;
  en_FormMode frmMode;

  @override
  State<scr_ProductItem> createState() => _scr_ProductItemState();
}

class _scr_ProductItemState extends State<scr_ProductItem> {
  int? categoryID;
  TextEditingController controllerBarCode = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  bool chkIsActive = true;
  bool chkIsPos = true;
  bool chkIsUpdated = false;
  int? unitBig_ID;

  TextEditingController controllerUnitCountOf = TextEditingController();
  TextEditingController controllerUnitBig_PurchasePrice = TextEditingController();
  TextEditingController controllerUnitBig_Sales1 = TextEditingController();
  TextEditingController controllerUnitBig_Sales2 = TextEditingController();
  TextEditingController controllerUnitBig_Sales3 = TextEditingController();
  TextEditingController controllerUnitBig_Sales4 = TextEditingController();
  TextEditingController controllerUnitBig_Sales5 = TextEditingController();
  int? unitSmall_ID;
  TextEditingController controllerUnitSmall_PurchasePrice = TextEditingController();
  TextEditingController controllerUnitSmall_Sales1 = TextEditingController();
  TextEditingController controllerUnitSmall_Sales2 = TextEditingController();
  TextEditingController controllerUnitSmall_Sales3 = TextEditingController();
  TextEditingController controllerUnitSmall_Sales4 = TextEditingController();
  TextEditingController controllerUnitSmall_Sales5 = TextEditingController();
  TextEditingController controllerLimitedQty = TextEditingController();
  String imageName = '';
  String imagePath = '';
  TextEditingController contDiscription = TextEditingController();

  var frmKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              text: 'بيانات الصنف',
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
            ),
            ctr_DropDowenList(
              hintLable: 'التصنيف',
              padding: EdgeInsets.only(right: 5, left: 0, top: 5, bottom: 5),
              height: 50,
              lstDataSource: categories_bloc.instance.LstCategoriesAsDataSource,
              hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
              itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
              menuMaxHeightValue: 300,
              selectedValue: categoryID,
              OnChanged: (returnID) {
                categoryID = returnID;
                setNewBarcode();
                // setNewBarcode().then((val) {
                //   controllerBarCode.text = val.toString();
                // });
                return null;
              },
            ),
            ctr_TextFormField(
              Controller: controllerBarCode,
              Lable: 'الباركود',
              padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
              useAsBarcodeControle: true,
              OnValidate: (value) {
                if (value == null || value.isEmpty) {
                  return 'لابد من إدخال قيمة';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            ctr_TextFormField(
              Controller: controllerName,
              padding: const EdgeInsets.only(right: 7),
              TextType: TextInputType.text,
              TextAlignValue: TextAlign.end,
              Lable: 'الإســــم',
              autoSelectData: true,
              OnValidate: (value) {
                if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
                return null;
              },
            ),
            Row(
              children: [
                Checkbox(
                    value: chkIsActive,
                    onChanged: (value) {
                      setState(() {
                        chkIsActive = !chkIsActive;
                      });
                    }),
                const Text('نشط', style: TextStyle(fontSize: 17)),
                Checkbox(
                    value: chkIsPos,
                    onChanged: (value) {
                      setState(() {
                        chkIsPos = !chkIsPos;
                      });
                    }),
                const Text('يتم العرض فى المبيعات', style: TextStyle(fontSize: 17)),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: chkIsUpdated,
                    onChanged: (value) {
                      setState(() {
                        chkIsUpdated = !chkIsUpdated;
                      });
                    }),
                const Text('تم التعديل على الصنف', style: TextStyle(fontSize: 17)),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ctr_DropDowenList(
                    hintLable: 'الوحدة الكبري',
                    padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 0),
                    lstDataSource: unit_bloc.instance.LstUnitsAsDataSource,
                    hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                    itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                    menuMaxHeightValue: 300,
                    showClearIcon: false,
                    selectedValue: unitBig_ID,
                    OnChanged: (returnID) {
                      unitBig_ID = returnID;
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
                Expanded(
                  child: ctr_DropDowenList(
                    hintLable: 'الوحدة الصغري',
                    padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 0),
                    lstDataSource: unit_bloc.instance.LstUnitsAsDataSource,
                    hintTextStyle: const TextStyle(fontSize: 17.0, color: Colors.grey),
                    itemsTextStyle: const TextStyle(fontSize: 17.0, color: Colors.purple, fontWeight: FontWeight.bold),
                    menuMaxHeightValue: 300,
                    showClearIcon: false,
                    selectedValue: unitSmall_ID,
                    OnChanged: (returnID) {
                      unitSmall_ID = returnID;
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
              ],
            ),

            Row(
              children: [
                SizedBox(width: 80),
                SizedBox(
                  width: 200,
                  child: ctr_TextFormField(
                    Controller: controllerUnitCountOf,
                    padding: EdgeInsets.only(right: 0, left: 0, top: 10, bottom: 5),
                    height: 50,
                    TextType: TextInputType.number,
                    TextAlignValue: TextAlign.center,
                    Lable: 'الكبري تحتوي علي ؟؟؟ من الصغري',
                    autoSelectData: true,
                    OnValidate: (value) {
                      if (value == null || value.isEmpty) return 'لابد من إدخال قيمة';
                      return null;
                    },
                    OnChanged: (value) {
                      // هشتغل على انه كتب فى الوحدة الكبري
                      controllerUnitSmall_PurchasePrice.text = priceChanged(true, controllerUnitBig_PurchasePrice.text, value);
                      controllerUnitSmall_Sales1.text = priceChanged(true, controllerUnitBig_Sales1.text, value);
                      controllerUnitSmall_Sales2.text = priceChanged(true, controllerUnitBig_Sales2.text, value);
                      controllerUnitSmall_Sales3.text = priceChanged(true, controllerUnitBig_Sales3.text, value);
                      controllerUnitSmall_Sales4.text = priceChanged(true, controllerUnitBig_Sales4.text, value);
                      controllerUnitSmall_Sales5.text = priceChanged(true, controllerUnitBig_Sales5.text, value);
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: controllerUnitBig_PurchasePrice,
                    padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                    TextType: TextInputType.number,
                    TextAlignValue: TextAlign.center,
                    autoSelectData: true,
                    Lable: 'شراء كبري',
                    OnChanged: (value) {
                      controllerUnitSmall_PurchasePrice.text = priceChanged(true, value, controllerUnitCountOf.text);
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: controllerUnitSmall_PurchasePrice,
                    padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                    TextType: TextInputType.number,
                    TextAlignValue: TextAlign.center,
                    Lable: 'شراء صغري',
                    autoSelectData: true,
                    OnChanged: (value) {
                      controllerUnitBig_PurchasePrice.text = priceChanged(false, value, controllerUnitCountOf.text);
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: controllerUnitBig_Sales1,
                    padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                    TextType: TextInputType.number,
                    TextAlignValue: TextAlign.center,
                    Lable: 'سعر بيع 1 كبري',
                    autoSelectData: true,
                    OnChanged: (value) {
                      controllerUnitSmall_Sales1.text = priceChanged(true, value, controllerUnitCountOf.text);
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: controllerUnitSmall_Sales1,
                    padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                    TextType: TextInputType.number,
                    TextAlignValue: TextAlign.center,
                    Lable: 'سعر بيع 1 صغري',
                    autoSelectData: true,
                    OnChanged: (value) {
                      controllerUnitBig_Sales1.text = priceChanged(false, value, controllerUnitCountOf.text);
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: controllerUnitBig_Sales2,
                    padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                    TextType: TextInputType.number,
                    TextAlignValue: TextAlign.center,
                    Lable: 'سعر بيع 2 كبري',
                    autoSelectData: true,
                    OnChanged: (value) {
                      controllerUnitSmall_Sales2.text = priceChanged(true, value, controllerUnitCountOf.text);
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: controllerUnitSmall_Sales2,
                    padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                    TextType: TextInputType.number,
                    TextAlignValue: TextAlign.center,
                    Lable: 'سعر بيع 2 صغري',
                    autoSelectData: true,
                    OnChanged: (value) {
                      controllerUnitBig_Sales2.text = priceChanged(false, value, controllerUnitCountOf.text);
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: controllerUnitBig_Sales3,
                    padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                    TextType: TextInputType.number,
                    TextAlignValue: TextAlign.center,
                    Lable: 'سعر بيع 3 كبري',
                    autoSelectData: true,
                    OnChanged: (value) {
                      controllerUnitSmall_Sales3.text = priceChanged(true, value, controllerUnitCountOf.text);
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: controllerUnitSmall_Sales3,
                    padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                    TextType: TextInputType.number,
                    TextAlignValue: TextAlign.center,
                    Lable: 'سعر بيع 3 صغري',
                    autoSelectData: true,
                    OnChanged: (value) {
                      controllerUnitBig_Sales3.text = priceChanged(false, value, controllerUnitCountOf.text);
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: controllerUnitBig_Sales4,
                    padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                    TextType: TextInputType.number,
                    TextAlignValue: TextAlign.center,
                    Lable: 'سعر بيع 4 كبري',
                    autoSelectData: true,
                    OnChanged: (value) {
                      controllerUnitSmall_Sales4.text = priceChanged(true, value, controllerUnitCountOf.text);
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: controllerUnitSmall_Sales4,
                    padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                    TextType: TextInputType.number,
                    TextAlignValue: TextAlign.center,
                    Lable: 'سعر بيع 4 صغري',
                    autoSelectData: true,
                    OnChanged: (value) {
                      controllerUnitBig_Sales4.text = priceChanged(false, value, controllerUnitCountOf.text);
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ctr_TextFormField(
                    Controller: controllerUnitBig_Sales5,
                    padding: EdgeInsets.only(right: 5, left: 0, top: 0, bottom: 5),
                    TextType: TextInputType.number,
                    TextAlignValue: TextAlign.center,
                    Lable: 'سعر بيع 5 كبري',
                    autoSelectData: true,
                    OnChanged: (value) {
                      controllerUnitSmall_Sales5.text = priceChanged(true, value, controllerUnitCountOf.text);
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: ctr_TextFormField(
                    Controller: controllerUnitSmall_Sales5,
                    padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
                    TextType: TextInputType.number,
                    TextAlignValue: TextAlign.center,
                    Lable: 'سعر بيع 5 صغري',
                    autoSelectData: true,
                    OnChanged: (value) {
                      controllerUnitBig_Sales5.text = priceChanged(false, value, controllerUnitCountOf.text);
                      return null;
                    },
                  ),
                ),
              ],
            ),
            ctr_TextFormField(
              Controller: controllerLimitedQty,
              padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 5),
              TextType: TextInputType.number,
              TextAlignValue: TextAlign.center,
              Lable: 'الحد الأدني للطلب',
              autoSelectData: true,
            ),
            SizedBox(
              height: 220,
              child: ctr_TextFormField(
                Controller: contDiscription,
                padding: EdgeInsets.only(right: 5, left: 5, top: 0, bottom: 10),
                TextType: TextInputType.multiline,
                TextAlignValue: TextAlign.end,
                Lable: 'الوصف التفصيلي - للمتجر',
                maxLines: null, // يسمح بالنص الطويل
                minLines: 8,
              ),
            ),




            // Stack(
            //   children: [
            //     Container(
            //       color: Colors.grey[100],
            //       child: BlocBuilder<product_bloc, definition_state>(
            //         builder: (context, state) {
            //           if (state is! getListProduct_StateDataChanged) {
            //             loadImageProduct();
            //           }
            //           return Image(
            //             image: product_bloc.instance.productImageTemp.image ?? manage_Images.defaultImage,
            //             width: 150,
            //             height: 150,
            //             fit: BoxFit.cover,
            //           );
            //         },
            //       ),
            //     ),
            //     Positioned(
            //       top: 20,
            //       right: 20,
            //       child: CircleAvatar(
            //         backgroundColor: Colors.grey[300],
            //         radius: 25,
            //         child: IconButton(
            //           onPressed: (() async {
            //             product_bloc.instance.takeImageProduct();
            //             widget.itemProduct!.ImageURL1 = '';
            //           }),
            //           icon: const Icon(
            //             Icons.add_a_photo,
            //             size: 27,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.frmMode == en_FormMode.NewMode)
      NewMode();
    else if (widget.frmMode == en_FormMode.EditMode) EditMode();
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

  Future<int?> setNewBarcode() async {
    BLLCondions cond =
      BLLCondions(enTable_Def_ProductStructure.IDCategory.name, en_CondionsWhere.isEqualTo, categoryID);

    await bllDef_ProductStructure.getMax_firestore(enTable_Def_ProductStructure.BarCode,condion: cond).then((val) {
      controllerBarCode.text = val.toString();
    }).toString();
    return null;
  }

  void NewMode() async {
    categoryID =
        categories_bloc.instance.LstCategoriesAsDataSource.isNotEmpty ? categories_bloc.instance.LstCategoriesAsDataSource.first.valueMember : null;
    await setNewBarcode();
    // controllerName.text =   ;
    chkIsActive = true;
    chkIsPos = true;
    // chkIsUpdated = false ;
    unitBig_ID = unit_bloc.instance.LstUnitsAsDataSource.isNotEmpty ? unit_bloc.instance.LstUnitsAsDataSource.first.valueMember : null;
    controllerUnitCountOf.text = '1';
    controllerUnitBig_PurchasePrice.text = '0';
    controllerUnitBig_Sales1.text = '0';
    controllerUnitBig_Sales2.text = '0';
    controllerUnitBig_Sales3.text = '0';
    controllerUnitBig_Sales4.text = '0';
    controllerUnitBig_Sales5.text = '0';
    unitSmall_ID = unit_bloc.instance.LstUnitsAsDataSource.isNotEmpty ? unit_bloc.instance.LstUnitsAsDataSource.first.valueMember : null;
    controllerUnitSmall_PurchasePrice.text = '0';
    controllerUnitSmall_Sales1.text = '0';
    controllerUnitSmall_Sales2.text = '0';
    controllerUnitSmall_Sales3.text = '0';
    controllerUnitSmall_Sales4.text = '0';
    controllerUnitSmall_Sales5.text = '0';
    controllerLimitedQty.text = '0';
    // product_bloc.instance.productImageTemp.imageName = '';
    // product_bloc.instance.productImageTemp.imagepath = '';
    // product_bloc.instance.productImageTemp.image = null;
    // product_bloc.instance.productImageTemp.imageFile = null;
    // product_bloc.instance.productImageTemp.imageURL = '';
  }

  void EditMode() {
    if (widget.itemProduct != null) {
      categoryID = widget.itemProduct!.IDCategory;
      controllerBarCode.text = widget.itemProduct!.BarCode.toString();
      controllerName.text = widget.itemProduct!.Name!;
      chkIsActive = widget.itemProduct!.IsActive!;
      chkIsPos = widget.itemProduct!.IsPOS!;
      chkIsUpdated = widget.itemProduct!.IsUpdated!;
      unitBig_ID = widget.itemProduct!.UnitBig_ID;
      controllerUnitCountOf.text = widget.itemProduct!.UnitCountOf.toString();
      controllerUnitBig_PurchasePrice.text = widget.itemProduct!.UnitBig_PurchasePrice.toString();
      controllerUnitBig_Sales1.text = widget.itemProduct!.UnitBig_Sales1.toString();
      controllerUnitBig_Sales2.text = widget.itemProduct!.UnitBig_Sales2.toString();
      controllerUnitBig_Sales3.text = widget.itemProduct!.UnitBig_Sales3.toString();
      controllerUnitBig_Sales4.text = widget.itemProduct!.UnitBig_Sales4.toString();
      controllerUnitBig_Sales5.text = widget.itemProduct!.UnitBig_Sales5.toString();

      unitSmall_ID = widget.itemProduct!.UnitSmall_ID;
      controllerUnitSmall_PurchasePrice.text = widget.itemProduct!.UnitSmall_PurchasePrice.toString();
      controllerUnitSmall_Sales1.text = widget.itemProduct!.UnitSmall_Sales1.toString();
      controllerUnitSmall_Sales2.text = widget.itemProduct!.UnitSmall_Sales2.toString();
      controllerUnitSmall_Sales3.text = widget.itemProduct!.UnitSmall_Sales3.toString();
      controllerUnitSmall_Sales4.text = widget.itemProduct!.UnitSmall_Sales4.toString();
      controllerUnitSmall_Sales5.text = widget.itemProduct!.UnitSmall_Sales5.toString();
      controllerLimitedQty.text = widget.itemProduct!.LimitedQty.toString();
      contDiscription.text = widget.itemProduct!.Discription.toString();
    }
  }

  void loadImageProduct() {
    // if (widget.itemProduct != null && widget.itemProduct!.ImageURL1 != null && widget.itemProduct!.ImageURL1!.isNotEmpty) {
    //   product_bloc.instance.productImageTemp.image = NetworkImage(widget.itemProduct!.ImageURL1!);
    // } else if (product_bloc.instance.productImageTemp.image != null) {
    // } else {
    //   // بيرجع الصورة الافتراضية
    //   product_bloc.instance.productImageTemp.image = manage_Images.defaultImage;
    // }
  }

  String priceChanged(bool fromBig, String? item1, String? UnitCountOf) {
    String calcValue = '';
    if (UnitCountOf == null || UnitCountOf == 0 || UnitCountOf.isEmpty) {
      controllerUnitCountOf.text = '1';
      UnitCountOf = '1';
    }

    // لو بكتب فى الوحدة الكبري بيحسب ويضع الناتج فى الوحدة الصغري
    if (fromBig && item1 != null && item1.isNotEmpty) {
      calcValue = (double.parse(item1) / int.parse(UnitCountOf)).toStringAsFixed(2);
    }

    // لو بكتب فى الوحدة الصغري بيحسب ويضع الناتج فى الوحدة الكبري
    else if (!fromBig && item1 != null && item1.isNotEmpty) {
      calcValue = (double.parse(item1) * int.parse(UnitCountOf)).toStringAsFixed(2);
    }

    return calcValue;
  }

  void saveData() async {
    if (frmKey.currentState != null && frmKey.currentState!.validate()) {
      int maxID = 0;

      // // Uplade Image before save item
      // String imageUrlUpload = '';
      // if (product_bloc.instance.productImageTemp.image == null) {
      //   imageUrlUpload = '';
      // } else if (product_bloc.instance.productImageTemp.imageName != null && product_bloc.instance.productImageTemp.imageFile != null) {
      //   await bllDef_ProductStructure
      //       .storage_UploadFile(product_bloc.instance.productImageTemp.imageName!, product_bloc.instance.productImageTemp.imageFile!)
      //       .then((img) {
      //     imageUrlUpload = img;
      //   });
      // }

      //************************** New
      if (widget.frmMode == en_FormMode.NewMode) {
        maxID = await bllDef_ProductStructure.getMaxID_firestore();
        widget.itemProduct = Def_ProductStructure(
          ID: maxID,
          IDCategory: categoryID,
          BarCode: int.parse(controllerBarCode.text),
          Name: controllerName.text,
          IsActive: chkIsActive,
          IsPOS: chkIsPos,
          IsUpdated: chkIsUpdated,
          UnitBig_ID: unitBig_ID,
          UnitCountOf: int.parse(controllerUnitCountOf.text),
          UnitBig_PurchasePrice: double.parse(controllerUnitBig_PurchasePrice.text),
          UnitBig_Sales1: double.parse(controllerUnitBig_Sales1.text),
          UnitBig_Sales2: double.parse(controllerUnitBig_Sales2.text),
          UnitBig_Sales3: double.parse(controllerUnitBig_Sales3.text),
          UnitBig_Sales4: double.parse(controllerUnitBig_Sales4.text),
          UnitBig_Sales5: double.parse(controllerUnitBig_Sales5.text),
          UnitSmall_ID: unitSmall_ID,
          UnitSmall_PurchasePrice: double.parse(controllerUnitSmall_PurchasePrice.text),
          UnitSmall_Sales1: double.parse(controllerUnitSmall_Sales1.text),
          UnitSmall_Sales2: double.parse(controllerUnitSmall_Sales2.text),
          UnitSmall_Sales3: double.parse(controllerUnitSmall_Sales3.text),
          UnitSmall_Sales4: double.parse(controllerUnitSmall_Sales4.text),
          UnitSmall_Sales5: double.parse(controllerUnitSmall_Sales5.text),
          LimitedQty: int.parse(controllerLimitedQty.text),
          Discription: contDiscription.text,
          // ImageName1: product_bloc.instance.productImageTemp.imageName,
          // ImageURL1: imageUrlUpload,
        );
        await bllDef_ProductStructure.fire_SetItem(maxID.toString(), widget.itemProduct!);
      }

      //************************** Edit
      else if (widget.frmMode == en_FormMode.EditMode) {
        maxID = widget.itemProduct!.ID!;
        widget.itemProduct!.IDCategory = categoryID;
        widget.itemProduct!.BarCode = int.parse(controllerBarCode.text);
        widget.itemProduct!.Name = controllerName.text;
        widget.itemProduct!.IsActive = chkIsActive;
        widget.itemProduct!.IsPOS = chkIsPos;
        widget.itemProduct!.IsUpdated = chkIsUpdated;
        widget.itemProduct!.UnitBig_ID = unitBig_ID;
        widget.itemProduct!.UnitCountOf = int.parse(controllerUnitCountOf.text);
        widget.itemProduct!.UnitBig_PurchasePrice = double.parse(controllerUnitBig_PurchasePrice.text);
        widget.itemProduct!.UnitBig_Sales1 = double.parse(controllerUnitBig_Sales1.text);
        widget.itemProduct!.UnitBig_Sales2 = double.parse(controllerUnitBig_Sales2.text);
        widget.itemProduct!.UnitBig_Sales3 = double.parse(controllerUnitBig_Sales3.text);
        widget.itemProduct!.UnitBig_Sales4 = double.parse(controllerUnitBig_Sales4.text);
        widget.itemProduct!.UnitBig_Sales5 = double.parse(controllerUnitBig_Sales5.text);
        widget.itemProduct!.UnitSmall_ID = unitSmall_ID;
        widget.itemProduct!.UnitSmall_PurchasePrice = double.parse(controllerUnitSmall_PurchasePrice.text);
        widget.itemProduct!.UnitSmall_Sales1 = double.parse(controllerUnitSmall_Sales1.text);
        widget.itemProduct!.UnitSmall_Sales2 = double.parse(controllerUnitSmall_Sales2.text);
        widget.itemProduct!.UnitSmall_Sales3 = double.parse(controllerUnitSmall_Sales3.text);
        widget.itemProduct!.UnitSmall_Sales4 = double.parse(controllerUnitSmall_Sales4.text);
        widget.itemProduct!.UnitSmall_Sales5 = double.parse(controllerUnitSmall_Sales5.text);
        widget.itemProduct!.LimitedQty = int.parse(controllerLimitedQty.text);
        widget.itemProduct!.Discription = contDiscription.text;
        // widget.itemProduct!.ImageName1 = product_bloc.instance.productImageTemp.imageName;
        // widget.itemProduct!.ImageURL1 = imageUrlUpload;
      }

      await bllDef_ProductStructure.fire_SetItem(maxID.toString(), widget.itemProduct!);
      // reset obj image عشان لما بفتح صنف جديد بيجيب الصورة القديمة
      Navigator.pop(context, widget.itemProduct);
    }
  }
}

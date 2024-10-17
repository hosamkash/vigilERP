import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/classModel/Inv_Transfer.dart';
import 'package:vigil_erp/bll/classModel/Inv_TransferDetails.dart';
import '../../bll/bllFirebase/ManageBLL.dart';
import '../../bll/bllFirebase/bllInv_PermissionAdd.dart';
import '../../bll/bllFirebase/bllInv_PermissionDiscount.dart';
import '../../bll/bllFirebase/bllInv_ProductsQty.dart';
import '../../bll/bllFirebase/bllInv_Settlement.dart';
import '../../bll/bllFirebase/bllInv_Transfer.dart';
import '../../bll/classModel/Inv_PermissionAdd.dart';
import '../../bll/classModel/Inv_PermissionAddDetails.dart';
import '../../bll/classModel/Inv_PermissionDiscount.dart';
import '../../bll/classModel/Inv_PermissionDiscountDetails.dart';
import '../../bll/classModel/Inv_ProductsQty.dart';
import '../../bll/classModel/Inv_Settlement.dart';
import '../../bll/classModel/Inv_SettlementDetails.dart';
import '../../componants/ctr_SelectProduct.dart';
import '../../shared/enumerators.dart';
import '../blocDealing/dealing_bloc.dart';
import '../blocDefinition/definition_bloc.dart';
import '../blocFixTables/fix_table_bloc.dart';

part 'inv_event.dart';

part 'inv_state.dart';

class productQty_bloc extends Bloc<inv_event, inv_state> {
  static late productQty_bloc instance;

  static productQty_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<productQty_bloc>(context);
    return instance;
  }

  // **************************************************************

  List<Inv_ProductsQty> filterdLst_productQty = [];
  List<Inv_ProductsQty> orignalLst = [];

  Future getList_ProductsQty({int? priceType, int? hideQtyZeroID, List<BLLCondions>? conditions}) async {
    try {
      List<Inv_ProductsQty> tempLst = await bllInv_ProductsQty.fire_getListWithConditions(conditions: conditions);
      await grouped_productQty(tempLst, priceType, hideQtyZeroID);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  grouped_productQty(List<Inv_ProductsQty> tempLst, int? priceType, int? hideQtyZeroID) async {
    var groupd = <String, String>{};
    filterdLst_productQty.clear();
    orignalLst.clear();
    for (var item in tempLst) {
      String k = '${item.IDProduct}-${item.IDStock}';
      item.Price = 0;
      item.TotalPrice = 0;

      if (!groupd.containsKey(k)) {
        groupd[k] = k;
        orignalLst.add(item);
      } else {
        Inv_ProductsQty xx = orignalLst.where((val) => val.IDProduct == item.IDProduct && val.IDStock == item.IDStock).first;
        xx.Qty = xx.Qty! + (item.Qty ?? 0);
        xx.TotalQty = xx.Qty;
      }
    }
    filterdLst_productQty = orignalLst;
    await qtyHideZero(hideQtyZeroID);
    await calcGroupedRowsPric(priceType);
  }

  qtyHideZero(int? hideQtyZeroID) async {
    if (hideQtyZeroID == null) return;

    filterdLst_productQty = orignalLst.where((elm) {
      if (hideQtyZeroID == en_HideZeroFrom.stockQty.value)
        return elm.Qty != 0;
      else if (hideQtyZeroID == en_HideZeroFrom.representQty.value)
        return elm.QtyRepresents != 0;
      else if (hideQtyZeroID == en_HideZeroFrom.sumQty.value)
        return elm.TotalQty != 0;
      else
        return elm != 0;
    }).toList();
  }

  calcGroupedRowsPric(int? priceType) async {
    for (var item in filterdLst_productQty) {
      item.Price = await product_bloc.instance.getPriceByTypeID(item.IDProduct!, priceType != null ? priceType : null);
      item.TotalPrice = double.parse((item.TotalQty! * item.Price!).toStringAsFixed(2));
    }
  }

  resetFilter_productQty() {
    filterdLst_productQty.clear();
    filterdLst_productQty = orignalLst;
  }

  filterAny_productQty({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_productQty();
    }
    filterdLst_productQty = await orignalLst.where((item) {
      return (item.StockName == null ? false : item.StockName!.toString().contains(filterData!)) ||
          (item.BarCode == null ? false : item.BarCode!.toString().contains(filterData!.toLowerCase())) ||
          (item.ProductName == null ? false : item.ProductName!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.ClasseficationsName == null ? false : item.ClasseficationsName!.toLowerCase().contains(filterData!.toLowerCase())) ||
          // (item.ProductionCompaniesName == null ? false : item.ProductionCompaniesName!.toLowerCase().contains(filterData!.toLowerCase())) ||
          // (item.UnitName == null ? false : item.UnitName!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Qty == null ? false : item.Qty.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
          // (item.DateInserted == null ? false : item.DateInserted!.toLowerCase().contains(filterData!.toLowerCase())) ||
          // (item.DocumentTypeName == null ? false : item.DocumentTypeName!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Price == null ? false : item.Price.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.TotalPrice == null ? false : item.TotalPrice.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.PriceTypeName == null ? false : item.PriceTypeName.toString().toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future deleteByCondition(List<BLLCondions>? cond) async {
    try {
      if (cond != null && cond.length > 0) {
        await bllInv_ProductsQty.fire_DeleteListMaster(cond);
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<int> getproductQtyByStockID_OrAllStocks(int? stockID, int productID) async {
    int x = 0;

    if (orignalLst.length == 0) {
      await getList_ProductsQty();
    }

    if (stockID != null) // ألكمية من مخزن محدد
    {
      x = orignalLst.where((elm) {
        return elm.IDProduct == productID && elm.IDStock == stockID;
      }).fold(0, (previousValue, element) => previousValue + (element.Qty ?? 0));
    } else // الكمية من كل المخازن
    {
      x = orignalLst.where((elm) {
        return elm.IDProduct == productID;
      }).fold(0, (previousValue, element) => previousValue + (element.Qty ?? 0));
    }

    return x;
  }

  productQty_bloc() : super(productQty_StateInitial()) {
    on<inv_event>((event, emit) async {
      if (event is getListProductsQty_Event) {
        await getList_ProductsQty(priceType: event.priceType);
        emit(productQty_StateDataChanged(
          filterdLst_productQty: filterdLst_productQty,
          sumQty: filterdLst_productQty.fold(0, (previousValue, element) => previousValue! + element.Qty!),
          sumQtyRepresents: filterdLst_productQty.fold(0, (previousValue, element) => previousValue! + element.QtyRepresents!),
          sumTotalQty: filterdLst_productQty.fold(0, (previousValue, element) => previousValue! + element.TotalQty!),
          sumTotalPrice:
              double.parse(filterdLst_productQty.fold(0.0, (previousValue, element) => previousValue + element.TotalPrice!).toStringAsFixed(2)),
        ));
      } else if (event is getListProductsQtyByCondions_Event) {
        await getList_ProductsQty(conditions: event.condions, priceType: event.priceType, hideQtyZeroID: event.hideQtyZeroID);
        emit(productQty_StateDataChanged(
          filterdLst_productQty: filterdLst_productQty,
          sumQty: filterdLst_productQty.fold(0, (previousValue, element) => previousValue! + element.Qty!),
          sumQtyRepresents: filterdLst_productQty.fold(0, (previousValue, element) => previousValue! + element.QtyRepresents!),
          sumTotalQty: filterdLst_productQty.fold(0, (previousValue, element) => previousValue! + element.TotalQty!),
          sumTotalPrice:
              double.parse(filterdLst_productQty.fold(0.0, (previousValue, element) => previousValue + element.TotalPrice!).toStringAsFixed(2)),
        ));
      } else if (event is refreshProductsQty_Event) {
        emit(productQty_StateDataChanged(filterdLst_productQty: filterdLst_productQty));
      } else if (event is resetFilterProductsQty_Event) {
        await resetFilter_productQty();
        emit(productQty_StateDataChanged(filterdLst_productQty: filterdLst_productQty));
      } else if (event is filterAnyProductsQty_Event) {
        await filterAny_productQty(filterData: event.filterData);
        emit(productQty_StateDataChanged(filterdLst_productQty: filterdLst_productQty));
      }
    });
  }
}

class permissionAdd_bloc extends Bloc<inv_event, inv_state> {
  static late permissionAdd_bloc instance;

  static permissionAdd_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<permissionAdd_bloc>(context);
    return instance;
  }

  // **************************************************************
  List<Inv_PermissionAdd> filterdLst_PermissionAdd = [];
  List<Inv_PermissionAddDetails> filterdLst_PermissionAddDetails = [];

  Future getList_permissionAdd({List<BLLCondions>? conditions}) async {
    try {
      await bllInv_PermissionAdd.fire_getListWithConditions(conditions: conditions).then((val) {
        filterdLst_PermissionAdd = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  resetFilter_permissionAdd() {
    filterdLst_PermissionAdd.clear();
    filterdLst_PermissionAdd = bllInv_PermissionAdd.lstInv_PermissionAdd;
  }

  filterAny_permissionAdd({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_permissionAdd();
    }
    filterdLst_PermissionAdd = await bllInv_PermissionAdd.lstInv_PermissionAdd.where((item) {
      String branchName = company_bloc.instance.getNameByID(item.IDBranch);
      String stockName = stock_bloc.instance.getNameByID(item.IDStock);
      String employeeName = employee_bloc.instance.getNameByID(item.IDEmployee);
      String requestStatusName = requestStatus_bloc.instance.getNameByID(item.IDRequestStatus);

      return (item.Code == null ? false : item.Code!.toString().contains(filterData!)) ||
          (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (branchName.isEmpty ? false : branchName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (stockName.isEmpty ? false : stockName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (employeeName.isEmpty ? false : employeeName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (requestStatusName.isEmpty ? false : requestStatusName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Value == null ? false : item.Value.toString().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future getList_permissionAddDetails(int IDPermissionAdd) async {
    try {
      filterdLst_PermissionAddDetails.clear();
      await bllInv_PermissionAdd.fire_getListDetails(IDPermissionAdd.toString(), en_TablesName.Inv_PermissionAddDetails.name).then((val) {
        filterdLst_PermissionAddDetails = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future addNewPermissionAddDetails(customProductItem customProduct) async {
    try {
      double price = customProduct.isBigUnit! ? customProduct.UnitBigPrice! : customProduct.UnitSmllPrice!;

      Inv_PermissionAddDetails itemInsert = Inv_PermissionAddDetails(
          ID: filterdLst_PermissionAddDetails.length + 1,
          IDProduct: customProduct.ID,
          Barcode: customProduct.BarCode,
          IDClassefication: customProduct.IDCategory,
          IDProductionCompanies: customProduct.IDProductionCompany,
          Balance: 0,
          // وحدة كبري
          UnitBig_ID: customProduct.isBigUnit! ? customProduct.UnitBig_ID : null,
          UnitBig_Price: customProduct.isBigUnit! ? customProduct.UnitBigPrice : 0,
          UnitBig_Qty: customProduct.isBigUnit! ? int.parse(customProduct.controller!.text) : 0,
          //
          UnitCountOf: customProduct.UnitCountOf,
          // وحدة صغري
          UnitSmall_ID: customProduct.UnitSmall_ID,
          UnitSmall_Price: customProduct.UnitSmllPrice,
          UnitSmall_Qty: customProduct.isBigUnit!
              ? int.parse(customProduct.controller!.text) * customProduct.UnitCountOf!
              : int.parse(customProduct.controller!.text),
          TotalPrice: price * int.parse(customProduct.controller!.text),
          PriceType: customProduct.IDPriceType,
          isBigUnit: customProduct.isBigUnit);

      // filterdLst_PermissionAddDetails.add(itemInsert);
      bllInv_PermissionAdd.lstInv_PermissionAddDetails.add(itemInsert);
      await resetFilter_permissionAddDetails();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future editRowPermissionAddDetails(customProductItem customProductItem, int index) async {
    try {
      filterdLst_PermissionAddDetails[index].PriceType = customProductItem.IDPriceType;
      filterdLst_PermissionAddDetails[index].isBigUnit = customProductItem.isBigUnit;
      // وحدة كبري
      filterdLst_PermissionAddDetails[index].UnitBig_ID = customProductItem.isBigUnit! ? customProductItem.UnitBig_ID : null;
      filterdLst_PermissionAddDetails[index].UnitBig_Price = customProductItem.isBigUnit! ? customProductItem.UnitBigPrice : 0;
      filterdLst_PermissionAddDetails[index].UnitBig_Qty = customProductItem.isBigUnit! ? int.parse(customProductItem.controller!.text) : 0;
      //
      filterdLst_PermissionAddDetails[index].UnitCountOf = customProductItem.UnitCountOf;
      // وحدة صغري
      filterdLst_PermissionAddDetails[index].UnitSmall_ID = customProductItem.UnitSmall_ID;
      filterdLst_PermissionAddDetails[index].UnitSmall_Price = customProductItem.UnitSmllPrice;
      filterdLst_PermissionAddDetails[index].UnitSmall_Qty = customProductItem.isBigUnit!
          ? int.parse(customProductItem.controller!.text) * customProductItem.UnitCountOf!
          : int.parse(customProductItem.controller!.text);

      double price = customProductItem.isBigUnit! ? customProductItem.UnitBigPrice! : customProductItem.UnitSmllPrice!;
      filterdLst_PermissionAddDetails[index].TotalPrice = price * int.parse(customProductItem.controller!.text);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future deleteItemPermissionAddDetails(Inv_PermissionAddDetails itemDetails) async {
    try {
      filterdLst_PermissionAddDetails.remove(itemDetails);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  filterAny_permissionAddDetails({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_permissionAddDetails();
      return;
    }
    filterdLst_PermissionAddDetails = await filterdLst_PermissionAddDetails.where((item) {
      String productName = product_bloc.instance.getNameByID(item.IDProduct);

      return (item.Barcode == null ? false : item.Barcode!.toString().contains(filterData)) ||
          (productName.isEmpty ? false : productName.toLowerCase().contains(filterData.toLowerCase()));
    }).toList();
  }

  resetFilter_permissionAddDetails() async {
    // filterdLst_PermissionAddDetails.clear();
    filterdLst_PermissionAddDetails = await bllInv_PermissionAdd.lstInv_PermissionAddDetails.where((item) {
      return item != 0;
    }).toList();
  }

  permissionAdd_bloc() : super(permissionAdd_StateInitial()) {
    on<inv_event>((event, emit) async {
      if (event is getListPermissionAdd_Event) {
        await getList_permissionAdd(conditions: event.condions);
        emit(permissionAdd_StateDataChanged(filterdLst_PermissionAdd: filterdLst_PermissionAdd));
      } else if (event is refreshPermissionAdd_Event) {
        emit(permissionAdd_StateDataChanged(filterdLst_PermissionAdd: filterdLst_PermissionAdd));
      } else if (event is resetFilterPermissionAdd_Event) {
        await resetFilter_permissionAdd();
        emit(permissionAdd_StateDataChanged(filterdLst_PermissionAdd: filterdLst_PermissionAdd));
      } else if (event is filterAnyPermissionAdd_Event) {
        await filterAny_permissionAdd(filterData: event.filterData);
        emit(permissionAdd_StateDataChanged(filterdLst_PermissionAdd: filterdLst_PermissionAdd));
      } else if (event is deletePermissionAdd_Event) {
        await bllInv_PermissionAdd.fire_DeleteListMaster_And_Details(event.deleteID.toString(), en_TablesName.Inv_PermissionAddDetails.name);
        await bllInv_PermissionAdd.fire_getList().then((val) {
          filterdLst_PermissionAdd = val;
        });
        emit(permissionAdd_StateDataChanged(filterdLst_PermissionAdd: filterdLst_PermissionAdd));
      }

      // **********************   Details

      else if (event is getListPermissionAddDetails_Event) {
        await getList_permissionAddDetails(event.IDPermissionAdd);
        emit(permissionAddDetails_StateDataChanged(filterdLst_PermissionAddDetails: filterdLst_PermissionAddDetails));
      } else if (event is addNewPermissionAddDetails_Event) {
        await addNewPermissionAddDetails(event.itemCustomProduct!);
        emit(permissionAddDetails_StateDataChanged(filterdLst_PermissionAddDetails: filterdLst_PermissionAddDetails));
      } else if (event is editRowPermissionAddDetails_Event) {
        await editRowPermissionAddDetails(event.itemCustomProduct!, event.index!);
        emit(permissionAddDetails_StateDataChanged(filterdLst_PermissionAddDetails: filterdLst_PermissionAddDetails));
      } else if (event is deleteItemPermissionAddDetails_Event) {
        await deleteItemPermissionAddDetails(event.itemDetails!);
        emit(permissionAddDetails_StateDataChanged(filterdLst_PermissionAddDetails: filterdLst_PermissionAddDetails));
      } else if (event is clearPermissionAddDetails_Event) {
        filterdLst_PermissionAddDetails.clear();
        bllInv_PermissionAdd.lstInv_PermissionAddDetails.clear();
        emit(clearPermissionAddDetails());
      } else if (event is filterAnyPermissionAddDetails_Event) {
        await filterAny_permissionAddDetails(filterData: event.filterData);
        emit(permissionAddDetails_StateDataChanged(filterdLst_PermissionAddDetails: filterdLst_PermissionAddDetails));
      } else if (event is resetFilterPermissionAddDetails_Event) {
        await resetFilter_permissionAddDetails();
        emit(permissionAddDetails_StateDataChanged(filterdLst_PermissionAddDetails: filterdLst_PermissionAddDetails));
      }
    });
  }
}

class permissionDiscount_bloc extends Bloc<inv_event, inv_state> {
  static late permissionDiscount_bloc instance;

  static permissionDiscount_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<permissionDiscount_bloc>(context);
    return instance;
  }

  // **************************************************************
  List<Inv_PermissionDiscount> filterdLst_permissionDiscount = [];
  List<Inv_PermissionDiscountDetails> filterdLst_permissionDiscountDetails = [];

  Future getList_permissionDiscount({List<BLLCondions>? conditions}) async {
    try {
      await bllInv_PermissionDiscount.fire_getListWithConditions(conditions: conditions).then((val) {
        filterdLst_permissionDiscount = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  resetFilter_permissionDiscount() {
    filterdLst_permissionDiscount.clear();
    filterdLst_permissionDiscount = bllInv_PermissionDiscount.lstInv_PermissionDiscount;
  }

  filterAny_permissionDiscount({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_permissionDiscount();
    }
    filterdLst_permissionDiscount = await bllInv_PermissionDiscount.lstInv_PermissionDiscount.where((item) {
      String branchName = company_bloc.instance.getNameByID(item.IDBranch);
      String stockName = company_bloc.instance.getNameByID(item.IDStock);
      String employeeName = company_bloc.instance.getNameByID(item.IDEmployee);
      String requestStatusName = company_bloc.instance.getNameByID(item.IDRequestStatus);

      return (item.Code == null ? false : item.Code!.toString().contains(filterData!)) ||
          (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (branchName.isEmpty ? false : branchName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (stockName.isEmpty ? false : stockName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (employeeName.isEmpty ? false : employeeName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (requestStatusName.isEmpty ? false : requestStatusName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Value == null ? false : item.Value.toString().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future getList_permissionDiscountDetails(int IDpermissionDiscount) async {
    try {
      filterdLst_permissionDiscountDetails.clear();
      await bllInv_PermissionDiscount
          .fire_getListDetails(IDpermissionDiscount.toString(), en_TablesName.Inv_PermissionDiscountDetails.name)
          .then((val) {
        filterdLst_permissionDiscountDetails = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future addNewpermissionDiscountDetails(customProductItem addCustomProduct) async {
    try {
      double price = addCustomProduct.isBigUnit! ? addCustomProduct.UnitBigPrice! : addCustomProduct.UnitSmllPrice!;

      Inv_PermissionDiscountDetails itemInserted = Inv_PermissionDiscountDetails(
          ID: filterdLst_permissionDiscountDetails.length + 1,
          IDProduct: addCustomProduct.ID,
          Barcode: addCustomProduct.BarCode,
          IDClassefication: addCustomProduct.IDCategory,
          IDProductionCompanies: addCustomProduct.IDProductionCompany,
          Balance: 0,
          // وحدة كبري
          UnitBig_ID: addCustomProduct.isBigUnit! ? addCustomProduct.UnitBig_ID : null,
          UnitBig_Price: addCustomProduct.isBigUnit! ? addCustomProduct.UnitBigPrice : 0,
          UnitBig_Qty: addCustomProduct.isBigUnit! ? int.parse(addCustomProduct.controller!.text) : 0,
          //
          UnitCountOf: addCustomProduct.UnitCountOf,
          // وحدة صغري
          UnitSmall_ID: addCustomProduct.UnitSmall_ID,
          UnitSmall_Price: addCustomProduct.UnitSmllPrice,
          UnitSmall_Qty: addCustomProduct.isBigUnit!
              ? int.parse(addCustomProduct.controller!.text) * addCustomProduct.UnitCountOf!
              : int.parse(addCustomProduct.controller!.text),
          TotalPrice: price * int.parse(addCustomProduct.controller!.text),
          PriceType: addCustomProduct.IDPriceType,
          isBigUnit: addCustomProduct.isBigUnit);

      // filterdLst_permissionDiscountDetails.add(itemInserted);
      bllInv_PermissionDiscount.lstInv_PermissionDiscountDetails.add(itemInserted);
      await resetFilter_permissionDiscountDetails();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future editRowpermissionDiscountDetails(customProductItem editCustomProduct, int index) async {
    try {
      filterdLst_permissionDiscountDetails[index].PriceType = editCustomProduct.IDPriceType;
      filterdLst_permissionDiscountDetails[index].isBigUnit = editCustomProduct.isBigUnit;
      // وحدة كبري
      filterdLst_permissionDiscountDetails[index].UnitBig_ID = editCustomProduct.isBigUnit! ? editCustomProduct.UnitBig_ID : null;
      filterdLst_permissionDiscountDetails[index].UnitBig_Price = editCustomProduct.isBigUnit! ? editCustomProduct.UnitBigPrice : 0;
      filterdLst_permissionDiscountDetails[index].UnitBig_Qty = editCustomProduct.isBigUnit! ? int.parse(editCustomProduct.controller!.text) : 0;
      //
      filterdLst_permissionDiscountDetails[index].UnitCountOf = editCustomProduct.UnitCountOf;
      // وحدة صغري
      filterdLst_permissionDiscountDetails[index].UnitSmall_ID = editCustomProduct.UnitSmall_ID;
      filterdLst_permissionDiscountDetails[index].UnitSmall_Price = editCustomProduct.UnitSmllPrice;
      filterdLst_permissionDiscountDetails[index].UnitSmall_Qty = editCustomProduct.isBigUnit!
          ? int.parse(editCustomProduct.controller!.text) * editCustomProduct.UnitCountOf!
          : int.parse(editCustomProduct.controller!.text);

      double price = editCustomProduct.isBigUnit! ? editCustomProduct.UnitBigPrice! : editCustomProduct.UnitSmllPrice!;
      filterdLst_permissionDiscountDetails[index].TotalPrice = price * int.parse(editCustomProduct.controller!.text);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future deleteItempermissionDiscountDetails(Inv_PermissionDiscountDetails itemDetails) async {
    try {
      filterdLst_permissionDiscountDetails.remove(itemDetails);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  filterAny_permissionDiscountDetails({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_permissionDiscountDetails();
      return;
    }
    filterdLst_permissionDiscountDetails = await filterdLst_permissionDiscountDetails.where((item) {
      String productName = product_bloc.instance.getNameByID(item.IDProduct);

      return (item.Barcode == null ? false : item.Barcode!.toString().contains(filterData)) ||
          (productName.isEmpty ? false : productName.toLowerCase().contains(filterData.toLowerCase()));
    }).toList();
  }

  resetFilter_permissionDiscountDetails() async {
    filterdLst_permissionDiscountDetails = await bllInv_PermissionDiscount.lstInv_PermissionDiscountDetails.where((item) {
      return item != 0;
    }).toList();
  }

  permissionDiscount_bloc() : super(permissionDiscount_StateInitial()) {
    on<inv_event>((event, emit) async {
      if (event is getListPermissionDiscount_Event) {
        await getList_permissionDiscount(conditions: event.condions);
        emit(permissionDiscount_StateDataChanged(filterdLst_PermissionDiscount: filterdLst_permissionDiscount));
      } else if (event is refreshPermissionDiscount_Event) {
        emit(permissionDiscount_StateDataChanged(filterdLst_PermissionDiscount: filterdLst_permissionDiscount));
      } else if (event is resetFilterPermissionDiscount_Event) {
        await resetFilter_permissionDiscount();
        emit(permissionDiscount_StateDataChanged(filterdLst_PermissionDiscount: filterdLst_permissionDiscount));
      } else if (event is filterAnyPermissionDiscount_Event) {
        await filterAny_permissionDiscount(filterData: event.filterData);
        emit(permissionDiscount_StateDataChanged(filterdLst_PermissionDiscount: filterdLst_permissionDiscount));
      } else if (event is deletePermissionDiscount_Event) {
        await bllInv_PermissionDiscount.fire_DeleteListMaster_And_Details(
            event.deleteID.toString(), en_TablesName.Inv_PermissionDiscountDetails.name);
        await bllInv_PermissionDiscount.fire_getList().then((val) {
          filterdLst_permissionDiscount = val;
        });
        emit(permissionDiscount_StateDataChanged(filterdLst_PermissionDiscount: filterdLst_permissionDiscount));
      }

      // **********************   Details
      else if (event is getListPermissionDiscountDetails_Event) {
        await getList_permissionDiscountDetails(event.IDPermissionDiscount);
        emit(permissionDiscountDetails_StateDataChanged(filterdLst_PermissionDiscountDetails: filterdLst_permissionDiscountDetails));
      } else if (event is addNewPermissionDiscountDetails_Event) {
        await addNewpermissionDiscountDetails(event.itemCustomProduct!);
        emit(permissionDiscountDetails_StateDataChanged(filterdLst_PermissionDiscountDetails: filterdLst_permissionDiscountDetails));
      } else if (event is editRowPermissionDiscountDetails_Event) {
        await editRowpermissionDiscountDetails(event.itemCustomProduct!, event.index!);
        emit(permissionDiscountDetails_StateDataChanged(filterdLst_PermissionDiscountDetails: filterdLst_permissionDiscountDetails));
      } else if (event is deleteItemPermissionDiscountDetails_Event) {
        await deleteItempermissionDiscountDetails(event.itemDetails!);
        emit(permissionDiscountDetails_StateDataChanged(filterdLst_PermissionDiscountDetails: filterdLst_permissionDiscountDetails));
      } else if (event is clearPermissionDiscountDetails_Event) {
        filterdLst_permissionDiscountDetails.clear();
        bllInv_PermissionDiscount.lstInv_PermissionDiscountDetails.clear();
        emit(clearPermissionDiscountDetails());
      } else if (event is filterAnyPermissionDiscountDetails_Event) {
        await filterAny_permissionDiscountDetails(filterData: event.filterData);
        emit(permissionDiscountDetails_StateDataChanged(filterdLst_PermissionDiscountDetails: filterdLst_permissionDiscountDetails));
      } else if (event is resetFilterPermissionDiscountDetails_Event) {
        await resetFilter_permissionDiscountDetails();
        emit(permissionDiscountDetails_StateDataChanged(filterdLst_PermissionDiscountDetails: filterdLst_permissionDiscountDetails));
      }
    });
  }
}

class settlement_bloc extends Bloc<inv_event, inv_state> {
  static late settlement_bloc instance;

  static settlement_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<settlement_bloc>(context);
    return instance;
  }

// **************************************************************
  List<Inv_Settlement> filterdLst_Settlement = [];
  List<Inv_SettlementDetails> filterdLst_SettlementDetails = [];

  Future getList_Settlement({List<BLLCondions>? conditions}) async {
    try {
      await bllInv_Settlement.fire_getListWithConditions(conditions: conditions).then((val) {
        filterdLst_Settlement = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  resetFilter_Settlement() {
    // filterdLst_Settlement.clear();
    filterdLst_Settlement = bllInv_Settlement.lstInv_Settlement;
  }

  filterAny_Settlement({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Settlement();
    }
    filterdLst_Settlement = await bllInv_Settlement.lstInv_Settlement.where((item) {
      String branchName = company_bloc.instance.getNameByID(item.IDBranch);
      String stockName = stock_bloc.instance.getNameByID(item.IDStock);
      String employeeName = employee_bloc.instance.getNameByID(item.IDEmployee);
      String requestStatusName = requestStatus_bloc.instance.getNameByID(item.IDRequestStatus);

      return (item.Code == null ? false : item.Code!.toString().contains(filterData!)) ||
          (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (branchName.isEmpty ? false : branchName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (stockName.isEmpty ? false : stockName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (employeeName.isEmpty ? false : employeeName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (requestStatusName.isEmpty ? false : requestStatusName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.SettlementAddValue == null ? false : item.SettlementAddValue.toString().contains(filterData!.toLowerCase())) ||
          (item.SettlementDiscountValue == null ? false : item.SettlementDiscountValue.toString().contains(filterData!.toLowerCase())) ||
          (item.NetValue == null ? false : item.NetValue.toString().contains(filterData!.toLowerCase())) ||
          (item.Note == null ? false : item.Note!.toLowerCase().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future getList_SettlementDetails(int IDsettlement) async {
    try {
      filterdLst_SettlementDetails.clear();
      await bllInv_Settlement.fire_getListDetails(IDsettlement.toString(), en_TablesName.Inv_SettlementDetails.name).then((val) {
        filterdLst_SettlementDetails = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future addNewSettlementDetails(customProductItem customProduct, int? stockID) async {
    try {
      double price = customProduct.UnitSmllPrice!;
      int bookQty = await productQty_bloc.instance.getproductQtyByStockID_OrAllStocks(stockID, customProduct.ID!);
      int diffQty = int.parse(customProduct.controller!.text) < bookQty ? int.parse(customProduct.controller!.text) - bookQty : 0;
      int addQty = int.parse(customProduct.controller!.text) > bookQty ? int.parse(customProduct.controller!.text) - bookQty : 0;

      Inv_SettlementDetails inserDetails = Inv_SettlementDetails(
        ID: filterdLst_SettlementDetails.length + 1,
        IDProduct: customProduct.ID,
        Barcode: customProduct.BarCode,
        IDClassefication: customProduct.IDCategory,
        IDProductionCompanies: customProduct.IDProductionCompany,
        // وحدة صغري
        IDUnit: customProduct.UnitSmall_ID,
        BookingQty: bookQty,
        ActualQty: int.parse(customProduct.controller!.text),
        PriceType: customProduct.IDPriceType,
        Price: customProduct.UnitSmllPrice,

        DiffQty: diffQty,
        DiffTotalPrice: double.parse((diffQty * price).toStringAsFixed(2)),
        AddQty: addQty,
        AddTotalPrice: double.parse((addQty * price).toStringAsFixed(2)),
      );

      // filterdLst_SettlementDetails.add(inserDetails);
      bllInv_Settlement.lstInv_SettlementDetails.add(inserDetails);
      resetFilter_SettlementDetails();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future editRowSettlementDetails(customProductItem customProduct, int index) async {
    try {
      double price = customProduct.UnitSmllPrice!;
      int bookQty = filterdLst_SettlementDetails[index].BookingQty!;
      int diffQty = int.parse(customProduct.controller!.text) < bookQty ? int.parse(customProduct.controller!.text) - bookQty : 0;
      int addQty = int.parse(customProduct.controller!.text) > bookQty ? int.parse(customProduct.controller!.text) - bookQty : 0;

      filterdLst_SettlementDetails[index].ActualQty = int.parse(customProduct.controller!.text);
      filterdLst_SettlementDetails[index].PriceType = customProduct.IDPriceType;
      filterdLst_SettlementDetails[index].Price = customProduct.UnitSmllPrice;

      filterdLst_SettlementDetails[index].DiffQty = diffQty;
      filterdLst_SettlementDetails[index].DiffTotalPrice = double.parse((diffQty * price).toStringAsFixed(2));
      filterdLst_SettlementDetails[index].AddQty = addQty;
      filterdLst_SettlementDetails[index].AddTotalPrice = double.parse((addQty * price).toStringAsFixed(2));
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future deleteItemSettlementDetails(Inv_SettlementDetails itemDetails) async {
    try {
      // filterdLst_SettlementDetails.remove(itemDetails);
      bllInv_Settlement.lstInv_SettlementDetails.remove(itemDetails);
      resetFilter_SettlementDetails();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  filterAny_SettlementDetails({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_SettlementDetails();
      return;
    }
    filterdLst_SettlementDetails = await bllInv_Settlement.lstInv_SettlementDetails.where((item) {
      String productName = product_bloc.instance.getNameByID(item.IDProduct);

      return (item.Barcode == null ? false : item.Barcode!.toString().contains(filterData)) ||
          (productName.isEmpty ? false : productName.toLowerCase().contains(filterData.toLowerCase()));
    }).toList();
  }

  resetFilter_SettlementDetails() {
    filterdLst_SettlementDetails = bllInv_Settlement.lstInv_SettlementDetails.where((item) {
      return item != 0;
    }).toList();
  }

  updateSettlementProductQtyByStock(int? stockID) async {
    filterdLst_SettlementDetails.forEach((elm) async {
      elm.BookingQty = await productQty_bloc.instance.getproductQtyByStockID_OrAllStocks(stockID, elm.IDProduct!);

      elm.AddQty = elm.ActualQty! > elm.BookingQty! ? elm.ActualQty! - elm.BookingQty! : 0;
      elm.AddTotalPrice = double.parse((elm.AddQty! * elm.Price!).toStringAsFixed(2));

      elm.DiffQty = elm.ActualQty! < elm.BookingQty! ? elm.ActualQty! - elm.BookingQty! : 0;
      elm.DiffTotalPrice = double.parse((elm.DiffQty! * elm.Price!).toStringAsFixed(2));
    });
  }

  settlement_bloc() : super(settlement_StateInitial()) {
    on<inv_event>((event, emit) async {
      if (event is getListSettlement_Event) {
        await getList_Settlement(conditions: event.condions);
        emit(settlement_StateDataChanged(filterdLst_Settlement: filterdLst_Settlement));
      } else if (event is refreshSettlement_Event) {
        emit(settlement_StateDataChanged(filterdLst_Settlement: filterdLst_Settlement));
      } else if (event is resetFilterSettlement_Event) {
        await resetFilter_Settlement();
        emit(settlement_StateDataChanged(filterdLst_Settlement: filterdLst_Settlement));
      } else if (event is filterAnySettlement_Event) {
        await filterAny_Settlement(filterData: event.filterData);
        emit(settlement_StateDataChanged(filterdLst_Settlement: filterdLst_Settlement));
      } else if (event is deleteSettlement_Event) {
        await bllInv_Settlement.fire_DeleteListMaster_And_Details(event.deleteID.toString(), en_TablesName.Inv_SettlementDetails.name);
        await bllInv_Settlement.fire_getList().then((val) {
          filterdLst_Settlement = val;
        });
        emit(settlement_StateDataChanged(filterdLst_Settlement: filterdLst_Settlement));
      }

      // **********************   Details
      else if (event is getListSettlementDetails_Event) {
        await getList_SettlementDetails(event.IDSettlement);
        emit(settlementDetails_StateDataChanged(filterdLst_SettlementDetails: filterdLst_SettlementDetails));
      } else if (event is addNewSettlementDetails_Event) {
        await addNewSettlementDetails(event.itemCustomProduct!, event.stockID);
        emit(settlementDetails_StateDataChanged(filterdLst_SettlementDetails: filterdLst_SettlementDetails));
      } else if (event is editRowSettlementDetails_Event) {
        await editRowSettlementDetails(event.itemCustomProduct!, event.index!);
        emit(settlementDetails_StateDataChanged(filterdLst_SettlementDetails: filterdLst_SettlementDetails));
      } else if (event is deleteItemSettlementDetails_Event) {
        await deleteItemSettlementDetails(event.itemDetails!);
        emit(settlementDetails_StateDataChanged(filterdLst_SettlementDetails: filterdLst_SettlementDetails));
      } else if (event is clearSettlementDetails_Event) {
        filterdLst_SettlementDetails.clear();
        bllInv_Settlement.lstInv_SettlementDetails.clear();
        emit(clearSettlementDetails());
      } else if (event is filterAnySettlementDetails_Event) {
        await filterAny_SettlementDetails(filterData: event.filterData);
        emit(settlementDetails_StateDataChanged(filterdLst_SettlementDetails: filterdLst_SettlementDetails));
      } else if (event is resetFilterSettlementDetails_Event) {
        await resetFilter_SettlementDetails();
        emit(settlementDetails_StateDataChanged(filterdLst_SettlementDetails: filterdLst_SettlementDetails));
      } else if (event is updateSettlementProductQtyByStock_Event) {
        await updateSettlementProductQtyByStock(event.stockID);
        emit(settlementDetails_StateDataChanged(filterdLst_SettlementDetails: filterdLst_SettlementDetails));
      } else if (event is refreshSettlementDetails_Event) {
        emit(settlementDetails_StateDataChanged(filterdLst_SettlementDetails: filterdLst_SettlementDetails));
      }
    });
  }
}

class transfer_bloc extends Bloc<inv_event, inv_state> {
  static late transfer_bloc instance;

  static transfer_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<transfer_bloc>(context);
    return instance;
  }

  // **************************************************************
  List<Inv_Transfer> filterdLst_Transfer = [];
  List<Inv_TransferDetails> filterdLst_TransferDetails = [];

  Future getList_transfer({List<BLLCondions>? conditions}) async {
    try {
      await bllInv_Transfer.fire_getListWithConditions(conditions: conditions).then((val) {
        filterdLst_Transfer = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  resetFilter_transfer() {
    filterdLst_Transfer.clear();
    filterdLst_Transfer = bllInv_Transfer.lstInv_Transfer;
  }

  filterAny_transfer({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_transfer();
    }
    filterdLst_Transfer = await bllInv_Transfer.lstInv_Transfer.where((item) {
      String branchName = company_bloc.instance.getNameByID(item.IDBranchFrom);
      String stockName = stock_bloc.instance.getNameByID(item.IDStockFrom);
      String employeeName = employee_bloc.instance.getNameByID(item.IDEmployee);
      String requestStatusName = requestStatus_bloc.instance.getNameByID(item.IDRequestStatus);

      return (item.Code == null ? false : item.Code!.toString().contains(filterData!)) ||
          (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (branchName.isEmpty ? false : branchName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (stockName.isEmpty ? false : stockName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (employeeName.isEmpty ? false : employeeName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (requestStatusName.isEmpty ? false : requestStatusName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.TotalValueFrom == null ? false : item.TotalValueFrom.toString().contains(filterData!.toLowerCase()));
    }).toList();
  }

  Future getList_transferDetails(int IDTransfer) async {
    try {
      filterdLst_TransferDetails.clear();
      await bllInv_Transfer.fire_getListDetails(IDTransfer.toString(), en_TablesName.Inv_TransferDetails.name).then((val) {
        filterdLst_TransferDetails = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future addNewTransferDetails(customProductItem customProduct) async {
    try {
      double price = customProduct.isBigUnit! ? customProduct.UnitBigPrice! : customProduct.UnitSmllPrice!;

      Inv_TransferDetails itemInsert = Inv_TransferDetails(
          ID: filterdLst_TransferDetails.length + 1,
          IDProduct: customProduct.ID,
          Barcode: customProduct.BarCode,
          IDClassefication: customProduct.IDCategory,
          IDProductionCompanies: customProduct.IDProductionCompany,
          // Balance: 0,
          // وحدة كبري
          UnitBig_ID: customProduct.isBigUnit! ? customProduct.UnitBig_ID : null,
          UnitBig_Price: customProduct.isBigUnit! ? customProduct.UnitBigPrice : 0,
          UnitBig_Qty: customProduct.isBigUnit! ? int.parse(customProduct.controller!.text) : 0,
          //
          UnitCountOf: customProduct.UnitCountOf,
          // وحدة صغري
          UnitSmall_ID: customProduct.UnitSmall_ID,
          UnitSmall_Price: customProduct.UnitSmllPrice,
          UnitSmall_Qty: customProduct.isBigUnit!
              ? int.parse(customProduct.controller!.text) * customProduct.UnitCountOf!
              : int.parse(customProduct.controller!.text),
          TotalPrice: price * int.parse(customProduct.controller!.text),
          PriceType: customProduct.IDPriceType,
          isBigUnit: customProduct.isBigUnit);

      // filterdLst_TransferDetails.add(itemInsert);
      bllInv_Transfer.lstInv_TransferDetails.add(itemInsert);
      await resetFilter_transferDetails();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future editRowTransferDetails(customProductItem customProductItem, int index) async {
    try {
      filterdLst_TransferDetails[index].PriceType = customProductItem.IDPriceType;
      filterdLst_TransferDetails[index].isBigUnit = customProductItem.isBigUnit;
      // وحدة كبري
      filterdLst_TransferDetails[index].UnitBig_ID = customProductItem.isBigUnit! ? customProductItem.UnitBig_ID : null;
      filterdLst_TransferDetails[index].UnitBig_Price = customProductItem.isBigUnit! ? customProductItem.UnitBigPrice : 0;
      filterdLst_TransferDetails[index].UnitBig_Qty = customProductItem.isBigUnit! ? int.parse(customProductItem.controller!.text) : 0;
      //
      filterdLst_TransferDetails[index].UnitCountOf = customProductItem.UnitCountOf;
      // وحدة صغري
      filterdLst_TransferDetails[index].UnitSmall_ID = customProductItem.UnitSmall_ID;
      filterdLst_TransferDetails[index].UnitSmall_Price = customProductItem.UnitSmllPrice;
      filterdLst_TransferDetails[index].UnitSmall_Qty = customProductItem.isBigUnit!
          ? int.parse(customProductItem.controller!.text) * customProductItem.UnitCountOf!
          : int.parse(customProductItem.controller!.text);

      double price = customProductItem.isBigUnit! ? customProductItem.UnitBigPrice! : customProductItem.UnitSmllPrice!;
      filterdLst_TransferDetails[index].TotalPrice = price * int.parse(customProductItem.controller!.text);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future deleteItemTransferDetails(Inv_TransferDetails itemDetails) async {
    try {
      filterdLst_TransferDetails.remove(itemDetails);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  filterAny_transferDetails({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_transferDetails();
      return;
    }
    filterdLst_TransferDetails = await filterdLst_TransferDetails.where((item) {
      String productName = product_bloc.instance.getNameByID(item.IDProduct);

      return (item.Barcode == null ? false : item.Barcode!.toString().contains(filterData)) ||
          (productName.isEmpty ? false : productName.toLowerCase().contains(filterData.toLowerCase()));
    }).toList();
  }

  resetFilter_transferDetails() async {
    // filterdLst_TransferDetails.clear();
    filterdLst_TransferDetails = await bllInv_Transfer.lstInv_TransferDetails.where((item) {
      return item != 0;
    }).toList();
  }

  transfer_bloc() : super(transfer_StateInitial()) {
    on<inv_event>((event, emit) async {
      if (event is getListTransfer_Event) {
        await getList_transfer(conditions: event.condions);
        emit(transfer_StateDataChanged(filterdLst_Transfer: filterdLst_Transfer));
      } else if (event is refreshTransfer_Event) {
        emit(transfer_StateDataChanged(filterdLst_Transfer: filterdLst_Transfer));
      } else if (event is resetFilterTransfer_Event) {
        await resetFilter_transfer();
        emit(transfer_StateDataChanged(filterdLst_Transfer: filterdLst_Transfer));
      } else if (event is filterAnyTransfer_Event) {
        await filterAny_transfer(filterData: event.filterData);
        emit(transfer_StateDataChanged(filterdLst_Transfer: filterdLst_Transfer));
      } else if (event is deleteTransfer_Event) {
        await bllInv_Transfer.fire_DeleteListMaster_And_Details(event.deleteID.toString(), en_TablesName.Inv_TransferDetails.name);
        await bllInv_Transfer.fire_getList().then((val) {
          filterdLst_Transfer = val;
        });
        emit(transfer_StateDataChanged(filterdLst_Transfer: filterdLst_Transfer));
      }

      // **********************   Details

      else if (event is getListTransferDetails_Event) {
        await getList_transferDetails(event.IDTransfer);
        emit(transferDetails_StateDataChanged(filterdLst_TransferDetails: filterdLst_TransferDetails));
      } else if (event is addNewTransferDetails_Event) {
        await addNewTransferDetails(event.itemCustomProduct!);
        emit(transferDetails_StateDataChanged(filterdLst_TransferDetails: filterdLst_TransferDetails));
      } else if (event is editRowTransferDetails_Event) {
        await editRowTransferDetails(event.itemCustomProduct!, event.index!);
        emit(transferDetails_StateDataChanged(filterdLst_TransferDetails: filterdLst_TransferDetails));
      } else if (event is deleteItemTransferDetails_Event) {
        await deleteItemTransferDetails(event.itemDetails!);
        emit(transferDetails_StateDataChanged(filterdLst_TransferDetails: filterdLst_TransferDetails));
      } else if (event is clearTransferDetails_Event) {
        filterdLst_TransferDetails.clear();
        bllInv_Transfer.lstInv_TransferDetails.clear();
        emit(clearTransferDetails());
      } else if (event is filterAnyTransferDetails_Event) {
        await filterAny_transferDetails(filterData: event.filterData);
        emit(transferDetails_StateDataChanged(filterdLst_TransferDetails: filterdLst_TransferDetails));
      } else if (event is resetFilterTransferDetails_Event) {
        await resetFilter_transferDetails();
        emit(transferDetails_StateDataChanged(filterdLst_TransferDetails: filterdLst_TransferDetails));
      }
    });
  }
}


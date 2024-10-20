import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/bllFirebase/bllInvoices_Purchase.dart';
import 'package:vigil_erp/bll/classModel/Invoices_Purchase.dart';
import 'package:vigil_erp/bll/classModel/Invoices_PurchaseDetails.dart';
import '../../bll/bllFirebase/ManageBLL.dart';
import '../../bll/bllFirebase/bllInvoices_PurchaseReturned.dart';
import '../../bll/bllFirebase/bllInvoices_Sales.dart';
import '../../bll/bllFirebase/bllInvoices_SalesReturned.dart';
import '../../bll/classModel/Invoices_PurchaseReturned.dart';
import '../../bll/classModel/Invoices_PurchaseReturnedDetails.dart';
import '../../bll/classModel/Invoices_Sales.dart';
import '../../bll/classModel/Invoices_SalesDetails.dart';
import '../../bll/classModel/Invoices_SalesReturned.dart';
import '../../bll/classModel/Invoices_SalesReturnedDetails.dart';
import '../../componants/ctr_SelectProduct.dart';
import '../blocDealing/dealing_bloc.dart';
import '../blocDefinition/definition_bloc.dart';

part 'invoic_event.dart';

part 'invoic_state.dart';

class purchase_bloc extends Bloc<invoic_event, invoic_state> {
  static late purchase_bloc instance;

  static purchase_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<purchase_bloc>(context);
    return instance;
  }

  // **************************************************************
  List<Invoices_Purchase> filterdLst_Purchase = [];
  List<Invoices_PurchaseDetails> filterdLst_PurchaseDetails = [];

  Future getList_purchase({List<BLLCondions>? conditions}) async {
    try {
      await bllInvoices_Purchase.fire_getListWithConditions(conditions: conditions).then((val) {
        filterdLst_Purchase = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  resetFilter_purchase() {
    filterdLst_Purchase.clear();
    filterdLst_Purchase = bllInvoices_Purchase.lstInvoices_Purchase;
  }

  filterAny_purchase({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_purchase();
    }
    filterdLst_Purchase = await bllInvoices_Purchase.lstInvoices_Purchase.where((item) {
      String branchName = company_bloc.instance.getNameByID(item.IDBranch);
      String stockName = stock_bloc.instance.getNameByID(item.IDStock);
      String employeeName = employee_bloc.instance.getNameByID(item.IDEmployee);
      String vendorName = vendor_bloc.instance.getNameByID(item.IDVendor);

      return (item.Code == null ? false : item.Code!.toString().contains(filterData!)) ||
          (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (branchName.isEmpty ? false : branchName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (stockName.isEmpty ? false : stockName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (employeeName.isEmpty ? false : employeeName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (vendorName.isEmpty ? false : vendorName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.TotalValue == null ? false : item.TotalValue.toString().contains(filterData!)) ||
          (item.DiscountPercent == null ? false : item.DiscountPercent.toString().contains(filterData!)) ||
          (item.DiscountValue == null ? false : item.DiscountValue.toString().contains(filterData!)) ||
          (item.NetValue == null ? false : item.NetValue.toString().contains(filterData!));
    }).toList();
  }

  Future getList_purchaseDetails(int IDPurchase) async {
    try {
      filterdLst_PurchaseDetails.clear();
      await bllInvoices_Purchase.fire_getListDetails(IDPurchase.toString(), en_TablesName.Invoices_PurchaseDetails.name).then((val) {
        filterdLst_PurchaseDetails = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future addNewPurchaseDetails(customProductItem customProduct) async {
    try {
      double price = customProduct.isBigUnit! ? customProduct.UnitBigPrice! : customProduct.UnitSmllPrice!;

      Invoices_PurchaseDetails itemInsert = Invoices_PurchaseDetails(
          ID: filterdLst_PurchaseDetails.length + 1,
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

      // filterdLst_PurchaseDetails.add(itemInsert);
      bllInvoices_Purchase.lstInvoices_PurchaseDetails.add(itemInsert);
      await resetFilter_purchaseDetails();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future editRowPurchaseDetails(customProductItem customProductItem, int index) async {
    try {
      filterdLst_PurchaseDetails[index].PriceType = customProductItem.IDPriceType;
      filterdLst_PurchaseDetails[index].isBigUnit = customProductItem.isBigUnit;
      // وحدة كبري
      filterdLst_PurchaseDetails[index].UnitBig_ID = customProductItem.isBigUnit! ? customProductItem.UnitBig_ID : null;
      filterdLst_PurchaseDetails[index].UnitBig_Price = customProductItem.isBigUnit! ? customProductItem.UnitBigPrice : 0;
      filterdLst_PurchaseDetails[index].UnitBig_Qty = customProductItem.isBigUnit! ? int.parse(customProductItem.controller!.text) : 0;
      //
      filterdLst_PurchaseDetails[index].UnitCountOf = customProductItem.UnitCountOf;
      // وحدة صغري
      filterdLst_PurchaseDetails[index].UnitSmall_ID = customProductItem.UnitSmall_ID;
      filterdLst_PurchaseDetails[index].UnitSmall_Price = customProductItem.UnitSmllPrice;
      filterdLst_PurchaseDetails[index].UnitSmall_Qty = customProductItem.isBigUnit!
          ? int.parse(customProductItem.controller!.text) * customProductItem.UnitCountOf!
          : int.parse(customProductItem.controller!.text);

      double price = customProductItem.isBigUnit! ? customProductItem.UnitBigPrice! : customProductItem.UnitSmllPrice!;
      filterdLst_PurchaseDetails[index].TotalPrice = price * int.parse(customProductItem.controller!.text);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future deleteItemPurchaseDetails(Invoices_PurchaseDetails itemDetails) async {
    try {
      filterdLst_PurchaseDetails.remove(itemDetails);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  filterAny_purchaseDetails({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_purchaseDetails();
      return;
    }
    filterdLst_PurchaseDetails = await filterdLst_PurchaseDetails.where((item) {
      String productName = product_bloc.instance.getNameByID(item.IDProduct);

      return (item.Barcode == null ? false : item.Barcode!.toString().contains(filterData)) ||
          (productName.isEmpty ? false : productName.toLowerCase().contains(filterData.toLowerCase()));
    }).toList();
  }

  resetFilter_purchaseDetails() async {
    // filterdLst_PurchaseDetails.clear();
    filterdLst_PurchaseDetails = await bllInvoices_Purchase.lstInvoices_PurchaseDetails.where((item) {
      return item != 0;
    }).toList();
  }

  purchase_bloc() : super(purchase_StateInitial()) {
    on<invoic_event>((event, emit) async {
      if (event is getListPurchase_Event) {
        await getList_purchase(conditions: event.condions);
        emit(purchase_StateDataChanged(filterdLst_Purchase: filterdLst_Purchase));
      } else if (event is refreshPurchase_Event) {
        emit(purchase_StateDataChanged(filterdLst_Purchase: filterdLst_Purchase));
      } else if (event is resetFilterPurchase_Event) {
        await resetFilter_purchase();
        emit(purchase_StateDataChanged(filterdLst_Purchase: filterdLst_Purchase));
      } else if (event is filterAnyPurchase_Event) {
        await filterAny_purchase(filterData: event.filterData);
        emit(purchase_StateDataChanged(filterdLst_Purchase: filterdLst_Purchase));
      } else if (event is deletePurchase_Event) {
        await bllInvoices_Purchase.fire_DeleteListMaster_And_Details(event.deleteID.toString(), en_TablesName.Invoices_PurchaseDetails.name);
        await bllInvoices_Purchase.fire_getList().then((val) {
          filterdLst_Purchase = val;
        });
        emit(purchase_StateDataChanged(filterdLst_Purchase: filterdLst_Purchase));
      }

      // **********************   Details

      else if (event is getListPurchaseDetails_Event) {
        await getList_purchaseDetails(event.IDPurchase);
        emit(purchaseDetails_StateDataChanged(filterdLst_PurchaseDetails: filterdLst_PurchaseDetails));
      } else if (event is addNewPurchaseDetails_Event) {
        await addNewPurchaseDetails(event.itemCustomProduct!);
        emit(purchaseDetails_StateDataChanged(filterdLst_PurchaseDetails: filterdLst_PurchaseDetails));
      } else if (event is editRowPurchaseDetails_Event) {
        await editRowPurchaseDetails(event.itemCustomProduct!, event.index!);
        emit(purchaseDetails_StateDataChanged(filterdLst_PurchaseDetails: filterdLst_PurchaseDetails));
      } else if (event is deleteItemPurchaseDetails_Event) {
        await deleteItemPurchaseDetails(event.itemDetails!);
        emit(purchaseDetails_StateDataChanged(filterdLst_PurchaseDetails: filterdLst_PurchaseDetails));
      } else if (event is clearPurchaseDetails_Event) {
        filterdLst_PurchaseDetails.clear();
        bllInvoices_Purchase.lstInvoices_PurchaseDetails.clear();
        emit(clearPurchaseDetails_State());
      } else if (event is filterAnyPurchaseDetails_Event) {
        await filterAny_purchaseDetails(filterData: event.filterData);
        emit(purchaseDetails_StateDataChanged(filterdLst_PurchaseDetails: filterdLst_PurchaseDetails));
      } else if (event is resetFilterPurchaseDetails_Event) {
        await resetFilter_purchaseDetails();
        emit(purchaseDetails_StateDataChanged(filterdLst_PurchaseDetails: filterdLst_PurchaseDetails));
      } else if (event is refreshPurchaseDetails_Event) {
        emit(purchaseDetails_StateDataChanged(filterdLst_PurchaseDetails: filterdLst_PurchaseDetails));
      }
    });
  }
}

class purchaseReturned_bloc extends Bloc<invoic_event, invoic_state> {
  static late purchaseReturned_bloc instance;

  static purchaseReturned_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<purchaseReturned_bloc>(context);
    return instance;
  }

  // **************************************************************
  List<Invoices_PurchaseReturned> filterdLst_PurchaseReturned = [];
  List<Invoices_PurchaseReturnedDetails> filterdLst_PurchaseReturnedDetails = [];

  Future getList_purchaseReturned({List<BLLCondions>? conditions}) async {
    try {
      await bllInvoices_PurchaseReturned.fire_getListWithConditions(conditions: conditions).then((val) {
        filterdLst_PurchaseReturned = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  resetFilter_purchaseReturned() {
    filterdLst_PurchaseReturned.clear();
    filterdLst_PurchaseReturned = bllInvoices_PurchaseReturned.lstInvoices_PurchaseReturned;
  }

  filterAny_purchaseReturned({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_purchaseReturned();
    }
    filterdLst_PurchaseReturned = await bllInvoices_PurchaseReturned.lstInvoices_PurchaseReturned.where((item) {
      String branchName = company_bloc.instance.getNameByID(item.IDBranch);
      String stockName = stock_bloc.instance.getNameByID(item.IDStock);
      String employeeName = employee_bloc.instance.getNameByID(item.IDEmployee);
      String vendorName = vendor_bloc.instance.getNameByID(item.IDVendor);

      return (item.Code == null ? false : item.Code!.toString().contains(filterData!)) ||
          (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (branchName.isEmpty ? false : branchName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (stockName.isEmpty ? false : stockName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (employeeName.isEmpty ? false : employeeName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (vendorName.isEmpty ? false : vendorName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.TotalValue == null ? false : item.TotalValue.toString().contains(filterData!)) ||
          (item.DiscountPercent == null ? false : item.DiscountPercent.toString().contains(filterData!)) ||
          (item.DiscountValue == null ? false : item.DiscountValue.toString().contains(filterData!)) ||
          (item.NetValue == null ? false : item.NetValue.toString().contains(filterData!));
    }).toList();
  }

  Future getList_purchaseReturnedDetails(int IDPurchaseReturned) async {
    try {
      filterdLst_PurchaseReturnedDetails.clear();
      await bllInvoices_PurchaseReturned
          .fire_getListDetails(IDPurchaseReturned.toString(), en_TablesName.Invoices_PurchaseReturnedDetails.name)
          .then((val) {
        filterdLst_PurchaseReturnedDetails = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future addNewPurchaseReturnedDetails(customProductItem customProduct) async {
    try {
      double price = customProduct.isBigUnit! ? customProduct.UnitBigPrice! : customProduct.UnitSmllPrice!;

      Invoices_PurchaseReturnedDetails itemInsert = Invoices_PurchaseReturnedDetails(
          ID: filterdLst_PurchaseReturnedDetails.length + 1,
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

      // filterdLst_PurchaseReturnedDetails.add(itemInsert);
      bllInvoices_PurchaseReturned.lstInvoices_PurchaseReturnedDetails.add(itemInsert);
      await resetFilter_purchaseReturnedDetails();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future editRowPurchaseReturnedDetails(customProductItem customProductItem, int index) async {
    try {
      filterdLst_PurchaseReturnedDetails[index].PriceType = customProductItem.IDPriceType;
      filterdLst_PurchaseReturnedDetails[index].isBigUnit = customProductItem.isBigUnit;
      // وحدة كبري
      filterdLst_PurchaseReturnedDetails[index].UnitBig_ID = customProductItem.isBigUnit! ? customProductItem.UnitBig_ID : null;
      filterdLst_PurchaseReturnedDetails[index].UnitBig_Price = customProductItem.isBigUnit! ? customProductItem.UnitBigPrice : 0;
      filterdLst_PurchaseReturnedDetails[index].UnitBig_Qty = customProductItem.isBigUnit! ? int.parse(customProductItem.controller!.text) : 0;
      //
      filterdLst_PurchaseReturnedDetails[index].UnitCountOf = customProductItem.UnitCountOf;
      // وحدة صغري
      filterdLst_PurchaseReturnedDetails[index].UnitSmall_ID = customProductItem.UnitSmall_ID;
      filterdLst_PurchaseReturnedDetails[index].UnitSmall_Price = customProductItem.UnitSmllPrice;
      filterdLst_PurchaseReturnedDetails[index].UnitSmall_Qty = customProductItem.isBigUnit!
          ? int.parse(customProductItem.controller!.text) * customProductItem.UnitCountOf!
          : int.parse(customProductItem.controller!.text);

      double price = customProductItem.isBigUnit! ? customProductItem.UnitBigPrice! : customProductItem.UnitSmllPrice!;
      filterdLst_PurchaseReturnedDetails[index].TotalPrice = price * int.parse(customProductItem.controller!.text);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future deleteItemPurchaseReturnedDetails(Invoices_PurchaseReturnedDetails itemDetails) async {
    try {
      filterdLst_PurchaseReturnedDetails.remove(itemDetails);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  filterAny_purchaseReturnedDetails({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_purchaseReturnedDetails();
      return;
    }
    filterdLst_PurchaseReturnedDetails = await filterdLst_PurchaseReturnedDetails.where((item) {
      String productName = product_bloc.instance.getNameByID(item.IDProduct);

      return (item.Barcode == null ? false : item.Barcode!.toString().contains(filterData)) ||
          (productName.isEmpty ? false : productName.toLowerCase().contains(filterData.toLowerCase()));
    }).toList();
  }

  resetFilter_purchaseReturnedDetails() async {
    // filterdLst_PurchaseReturnedDetails.clear();
    filterdLst_PurchaseReturnedDetails = await bllInvoices_PurchaseReturned.lstInvoices_PurchaseReturnedDetails.where((item) {
      return item != 0;
    }).toList();
  }

  purchaseReturned_bloc() : super(purchaseReturned_StateInitial()) {
    on<invoic_event>((event, emit) async {
      if (event is getListPurchaseReturned_Event) {
        await getList_purchaseReturned(conditions: event.condions);
        emit(purchaseReturned_StateDataChanged(filterdLst_PurchaseReturned: filterdLst_PurchaseReturned));
      } else if (event is refreshPurchaseReturned_Event) {
        emit(purchaseReturned_StateDataChanged(filterdLst_PurchaseReturned: filterdLst_PurchaseReturned));
      } else if (event is resetFilterPurchaseReturned_Event) {
        await resetFilter_purchaseReturned();
        emit(purchaseReturned_StateDataChanged(filterdLst_PurchaseReturned: filterdLst_PurchaseReturned));
      } else if (event is filterAnyPurchaseReturned_Event) {
        await filterAny_purchaseReturned(filterData: event.filterData);
        emit(purchaseReturned_StateDataChanged(filterdLst_PurchaseReturned: filterdLst_PurchaseReturned));
      } else if (event is deletePurchaseReturned_Event) {
        await bllInvoices_PurchaseReturned.fire_DeleteListMaster_And_Details(
            event.deleteID.toString(), en_TablesName.Invoices_PurchaseReturnedDetails.name);
        await bllInvoices_PurchaseReturned.fire_getList().then((val) {
          filterdLst_PurchaseReturned = val;
        });
        emit(purchaseReturned_StateDataChanged(filterdLst_PurchaseReturned: filterdLst_PurchaseReturned));
      }

      // **********************   Details

      else if (event is getListPurchaseReturnedDetails_Event) {
        await getList_purchaseReturnedDetails(event.IDPurchaseReturned);
        emit(purchaseReturnedDetails_StateDataChanged(filterdLst_PurchaseReturnedDetails: filterdLst_PurchaseReturnedDetails));
      } else if (event is addNewPurchaseReturnedDetails_Event) {
        await addNewPurchaseReturnedDetails(event.itemCustomProduct!);
        emit(purchaseReturnedDetails_StateDataChanged(filterdLst_PurchaseReturnedDetails: filterdLst_PurchaseReturnedDetails));
      } else if (event is editRowPurchaseReturnedDetails_Event) {
        await editRowPurchaseReturnedDetails(event.itemCustomProduct!, event.index!);
        emit(purchaseReturnedDetails_StateDataChanged(filterdLst_PurchaseReturnedDetails: filterdLst_PurchaseReturnedDetails));
      } else if (event is deleteItemPurchaseReturnedDetails_Event) {
        await deleteItemPurchaseReturnedDetails(event.itemDetails!);
        emit(purchaseReturnedDetails_StateDataChanged(filterdLst_PurchaseReturnedDetails: filterdLst_PurchaseReturnedDetails));
      } else if (event is clearPurchaseReturnedDetails_Event) {
        filterdLst_PurchaseReturnedDetails.clear();
        bllInvoices_PurchaseReturned.lstInvoices_PurchaseReturnedDetails.clear();
        emit(clearPurchaseReturnedDetails_State());
      } else if (event is filterAnyPurchaseReturnedDetails_Event) {
        await filterAny_purchaseReturnedDetails(filterData: event.filterData);
        emit(purchaseReturnedDetails_StateDataChanged(filterdLst_PurchaseReturnedDetails: filterdLst_PurchaseReturnedDetails));
      } else if (event is resetFilterPurchaseReturnedDetails_Event) {
        await resetFilter_purchaseReturnedDetails();
        emit(purchaseReturnedDetails_StateDataChanged(filterdLst_PurchaseReturnedDetails: filterdLst_PurchaseReturnedDetails));
      } else if (event is refreshPurchaseReturnedDetails_Event) {
        emit(purchaseReturnedDetails_StateDataChanged(filterdLst_PurchaseReturnedDetails: filterdLst_PurchaseReturnedDetails));
      }
    });
  }
}

class sales_bloc extends Bloc<invoic_event, invoic_state> {
  static late sales_bloc instance;

  static sales_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<sales_bloc>(context);
    return instance;
  }

  // **************************************************************
  List<Invoices_Sales> filterdLst_Sales = [];
  List<Invoices_SalesDetails> filterdLst_SalesDetails = [];

  Future getList_sales({List<BLLCondions>? conditions}) async {
    try {
      await bllInvoices_Sales.fire_getListWithConditions(conditions: conditions).then((val) {
        filterdLst_Sales = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  resetFilter_sales() {
    filterdLst_Sales.clear();
    filterdLst_Sales = bllInvoices_Sales.lstInvoices_Sales;
  }

  filterAny_sales({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_sales();
    }
    filterdLst_Sales = await bllInvoices_Sales.lstInvoices_Sales.where((item) {
      String branchName = company_bloc.instance.getNameByID(item.IDBranch);
      String stockName = stock_bloc.instance.getNameByID(item.IDStock);
      String employeeName = employee_bloc.instance.getNameByID(item.IDEmployee);
      String clientName = client_bloc.instance.getNameByID(item.IDClient);

      return (item.Code == null ? false : item.Code!.toString().contains(filterData!)) ||
          (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (branchName.isEmpty ? false : branchName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (stockName.isEmpty ? false : stockName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (employeeName.isEmpty ? false : employeeName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (clientName.isEmpty ? false : clientName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.TotalValue == null ? false : item.TotalValue.toString().contains(filterData!)) ||
          (item.DiscountPercent == null ? false : item.DiscountPercent.toString().contains(filterData!)) ||
          (item.DiscountValue == null ? false : item.DiscountValue.toString().contains(filterData!)) ||
          (item.NetValue == null ? false : item.NetValue.toString().contains(filterData!));
    }).toList();
  }

  Future getList_salesDetails(int IDSales) async {
    try {
      filterdLst_SalesDetails.clear();
      await bllInvoices_Sales.fire_getListDetails(IDSales.toString(), en_TablesName.Invoices_SalesDetails.name).then((val) {
        filterdLst_SalesDetails = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future addNewSalesDetails(customProductItem customProduct) async {
    try {
      double price = customProduct.isBigUnit! ? customProduct.UnitBigPrice! : customProduct.UnitSmllPrice!;

      Invoices_SalesDetails itemInsert = Invoices_SalesDetails(
          ID: filterdLst_SalesDetails.length + 1,
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

      // filterdLst_SalesDetails.add(itemInsert);
      bllInvoices_Sales.lstInvoices_SalesDetails.add(itemInsert);
      await resetFilter_salesDetails();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future editRowSalesDetails(customProductItem customProductItem, int index) async {
    try {
      filterdLst_SalesDetails[index].PriceType = customProductItem.IDPriceType;
      filterdLst_SalesDetails[index].isBigUnit = customProductItem.isBigUnit;
      // وحدة كبري
      filterdLst_SalesDetails[index].UnitBig_ID = customProductItem.isBigUnit! ? customProductItem.UnitBig_ID : null;
      filterdLst_SalesDetails[index].UnitBig_Price = customProductItem.isBigUnit! ? customProductItem.UnitBigPrice : 0;
      filterdLst_SalesDetails[index].UnitBig_Qty = customProductItem.isBigUnit! ? int.parse(customProductItem.controller!.text) : 0;
      //
      filterdLst_SalesDetails[index].UnitCountOf = customProductItem.UnitCountOf;
      // وحدة صغري
      filterdLst_SalesDetails[index].UnitSmall_ID = customProductItem.UnitSmall_ID;
      filterdLst_SalesDetails[index].UnitSmall_Price = customProductItem.UnitSmllPrice;
      filterdLst_SalesDetails[index].UnitSmall_Qty = customProductItem.isBigUnit!
          ? int.parse(customProductItem.controller!.text) * customProductItem.UnitCountOf!
          : int.parse(customProductItem.controller!.text);

      double price = customProductItem.isBigUnit! ? customProductItem.UnitBigPrice! : customProductItem.UnitSmllPrice!;
      filterdLst_SalesDetails[index].TotalPrice = price * int.parse(customProductItem.controller!.text);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future deleteItemSalesDetails(Invoices_SalesDetails itemDetails) async {
    try {
      filterdLst_SalesDetails.remove(itemDetails);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  filterAny_salesDetails({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_salesDetails();
      return;
    }
    filterdLst_SalesDetails = await filterdLst_SalesDetails.where((item) {
      String productName = product_bloc.instance.getNameByID(item.IDProduct);

      return (item.Barcode == null ? false : item.Barcode!.toString().contains(filterData)) ||
          (productName.isEmpty ? false : productName.toLowerCase().contains(filterData.toLowerCase()));
    }).toList();
  }

  resetFilter_salesDetails() async {
    // filterdLst_SalesDetails.clear();
    filterdLst_SalesDetails = await bllInvoices_Sales.lstInvoices_SalesDetails.where((item) {
      return item != 0;
    }).toList();
  }

  sales_bloc() : super(sales_StateInitial()) {
    on<invoic_event>((event, emit) async {
      if (event is getListSales_Event) {
        await getList_sales(conditions: event.condions);
        emit(sales_StateDataChanged(filterdLst_Sales: filterdLst_Sales));
      } else if (event is refreshSales_Event) {
        emit(sales_StateDataChanged(filterdLst_Sales: filterdLst_Sales));
      } else if (event is resetFilterSales_Event) {
        await resetFilter_sales();
        emit(sales_StateDataChanged(filterdLst_Sales: filterdLst_Sales));
      } else if (event is filterAnySales_Event) {
        await filterAny_sales(filterData: event.filterData);
        emit(sales_StateDataChanged(filterdLst_Sales: filterdLst_Sales));
      } else if (event is deleteSales_Event) {
        await bllInvoices_Sales.fire_DeleteListMaster_And_Details(event.deleteID.toString(), en_TablesName.Invoices_SalesDetails.name);
        await bllInvoices_Sales.fire_getList().then((val) {
          filterdLst_Sales = val;
        });
        emit(sales_StateDataChanged(filterdLst_Sales: filterdLst_Sales));
      }

      // **********************   Details

      else if (event is getListSalesDetails_Event) {
        await getList_salesDetails(event.IDSales);
        emit(salesDetails_StateDataChanged(filterdLst_SalesDetails: filterdLst_SalesDetails));
      } else if (event is addNewSalesDetails_Event) {
        await addNewSalesDetails(event.itemCustomProduct!);
        emit(salesDetails_StateDataChanged(filterdLst_SalesDetails: filterdLst_SalesDetails));
      } else if (event is editRowSalesDetails_Event) {
        await editRowSalesDetails(event.itemCustomProduct!, event.index!);
        emit(salesDetails_StateDataChanged(filterdLst_SalesDetails: filterdLst_SalesDetails));
      } else if (event is deleteItemSalesDetails_Event) {
        await deleteItemSalesDetails(event.itemDetails!);
        emit(salesDetails_StateDataChanged(filterdLst_SalesDetails: filterdLst_SalesDetails));
      } else if (event is clearSalesDetails_Event) {
        filterdLst_SalesDetails.clear();
        bllInvoices_Sales.lstInvoices_SalesDetails.clear();
        emit(clearSalesDetails());
      } else if (event is filterAnySalesDetails_Event) {
        await filterAny_salesDetails(filterData: event.filterData);
        emit(salesDetails_StateDataChanged(filterdLst_SalesDetails: filterdLst_SalesDetails));
      } else if (event is resetFilterSalesDetails_Event) {
        await resetFilter_salesDetails();
        emit(salesDetails_StateDataChanged(filterdLst_SalesDetails: filterdLst_SalesDetails));
      } else if (event is refreshSalesDetails_Event) {
        emit(salesDetails_StateDataChanged(filterdLst_SalesDetails: filterdLst_SalesDetails));
      }
    });
  }
}

class salesReturned_bloc extends Bloc<invoic_event, invoic_state> {
  static late salesReturned_bloc instance;

  static salesReturned_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<salesReturned_bloc>(context);
    return instance;
  }

  // **************************************************************
  List<Invoices_SalesReturned> filterdLst_SalesReturned = [];
  List<Invoices_SalesReturnedDetails> filterdLst_SalesReturnedDetails = [];

  Future getList_salesReturned({List<BLLCondions>? conditions}) async {
    try {
      await bllInvoices_SalesReturned.fire_getListWithConditions(conditions: conditions).then((val) {
        filterdLst_SalesReturned = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  resetFilter_salesReturned() {
    filterdLst_SalesReturned.clear();
    filterdLst_SalesReturned = bllInvoices_SalesReturned.lstInvoices_SalesReturned;
  }

  filterAny_salesReturned({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_salesReturned();
    }
    filterdLst_SalesReturned = await bllInvoices_SalesReturned.lstInvoices_SalesReturned.where((item) {
      String branchName = company_bloc.instance.getNameByID(item.IDBranch);
      String stockName = stock_bloc.instance.getNameByID(item.IDStock);
      String employeeName = employee_bloc.instance.getNameByID(item.IDEmployee);
      String clientName = client_bloc.instance.getNameByID(item.IDClient);

      return (item.Code == null ? false : item.Code!.toString().contains(filterData!)) ||
          (item.Date == null ? false : item.Date!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.Time == null ? false : item.Time!.toLowerCase().contains(filterData!.toLowerCase())) ||
          (branchName.isEmpty ? false : branchName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (stockName.isEmpty ? false : stockName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (employeeName.isEmpty ? false : employeeName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (clientName.isEmpty ? false : clientName.toLowerCase().contains(filterData!.toLowerCase())) ||
          (item.TotalValue == null ? false : item.TotalValue.toString().contains(filterData!)) ||
          (item.DiscountPercent == null ? false : item.DiscountPercent.toString().contains(filterData!)) ||
          (item.DiscountValue == null ? false : item.DiscountValue.toString().contains(filterData!)) ||
          (item.NetValue == null ? false : item.NetValue.toString().contains(filterData!));
    }).toList();
  }

  Future getList_salesReturnedDetails(int IDSalesReturned) async {
    try {
      filterdLst_SalesReturnedDetails.clear();
      await bllInvoices_SalesReturned.fire_getListDetails(IDSalesReturned.toString(), en_TablesName.Invoices_SalesReturnedDetails.name).then((val) {
        filterdLst_SalesReturnedDetails = val;
      });
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future addNewSalesReturnedDetails(customProductItem customProduct) async {
    try {
      double price = customProduct.isBigUnit! ? customProduct.UnitBigPrice! : customProduct.UnitSmllPrice!;

      Invoices_SalesReturnedDetails itemInsert = Invoices_SalesReturnedDetails(
          ID: filterdLst_SalesReturnedDetails.length + 1,
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

      // filterdLst_SalesReturnedDetails.add(itemInsert);
      bllInvoices_SalesReturned.lstInvoices_SalesReturnedDetails.add(itemInsert);
      await resetFilter_salesReturnedDetails();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future editRowSalesReturnedDetails(customProductItem customProductItem, int index) async {
    try {
      filterdLst_SalesReturnedDetails[index].PriceType = customProductItem.IDPriceType;
      filterdLst_SalesReturnedDetails[index].isBigUnit = customProductItem.isBigUnit;
      // وحدة كبري
      filterdLst_SalesReturnedDetails[index].UnitBig_ID = customProductItem.isBigUnit! ? customProductItem.UnitBig_ID : null;
      filterdLst_SalesReturnedDetails[index].UnitBig_Price = customProductItem.isBigUnit! ? customProductItem.UnitBigPrice : 0;
      filterdLst_SalesReturnedDetails[index].UnitBig_Qty = customProductItem.isBigUnit! ? int.parse(customProductItem.controller!.text) : 0;
      //
      filterdLst_SalesReturnedDetails[index].UnitCountOf = customProductItem.UnitCountOf;
      // وحدة صغري
      filterdLst_SalesReturnedDetails[index].UnitSmall_ID = customProductItem.UnitSmall_ID;
      filterdLst_SalesReturnedDetails[index].UnitSmall_Price = customProductItem.UnitSmllPrice;
      filterdLst_SalesReturnedDetails[index].UnitSmall_Qty = customProductItem.isBigUnit!
          ? int.parse(customProductItem.controller!.text) * customProductItem.UnitCountOf!
          : int.parse(customProductItem.controller!.text);

      double price = customProductItem.isBigUnit! ? customProductItem.UnitBigPrice! : customProductItem.UnitSmllPrice!;
      filterdLst_SalesReturnedDetails[index].TotalPrice = price * int.parse(customProductItem.controller!.text);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future deleteItemSalesReturnedDetails(Invoices_SalesReturnedDetails itemDetails) async {
    try {
      filterdLst_SalesReturnedDetails.remove(itemDetails);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  filterAny_salesReturnedDetails({String? filterData}) async {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_salesReturnedDetails();
      return;
    }
    filterdLst_SalesReturnedDetails = await filterdLst_SalesReturnedDetails.where((item) {
      String productName = product_bloc.instance.getNameByID(item.IDProduct);

      return (item.Barcode == null ? false : item.Barcode!.toString().contains(filterData)) ||
          (productName.isEmpty ? false : productName.toLowerCase().contains(filterData.toLowerCase()));
    }).toList();
  }

  resetFilter_salesReturnedDetails() async {
    // filterdLst_SalesReturnedDetails.clear();
    filterdLst_SalesReturnedDetails = await bllInvoices_SalesReturned.lstInvoices_SalesReturnedDetails.where((item) {
      return item != 0;
    }).toList();
  }

  salesReturned_bloc() : super(salesReturned_StateInitial()) {
    on<invoic_event>((event, emit) async {
      if (event is getListSalesReturned_Event) {
        await getList_salesReturned(conditions: event.condions);
        emit(salesReturned_StateDataChanged(filterdLst_SalesReturned: filterdLst_SalesReturned));
      } else if (event is refreshSalesReturned_Event) {
        emit(salesReturned_StateDataChanged(filterdLst_SalesReturned: filterdLst_SalesReturned));
      } else if (event is resetFilterSalesReturned_Event) {
        await resetFilter_salesReturned();
        emit(salesReturned_StateDataChanged(filterdLst_SalesReturned: filterdLst_SalesReturned));
      } else if (event is filterAnySalesReturned_Event) {
        await filterAny_salesReturned(filterData: event.filterData);
        emit(salesReturned_StateDataChanged(filterdLst_SalesReturned: filterdLst_SalesReturned));
      } else if (event is deleteSalesReturned_Event) {
        await bllInvoices_SalesReturned.fire_DeleteListMaster_And_Details(
            event.deleteID.toString(), en_TablesName.Invoices_SalesReturnedDetails.name);
        await bllInvoices_SalesReturned.fire_getList().then((val) {
          filterdLst_SalesReturned = val;
        });
        emit(salesReturned_StateDataChanged(filterdLst_SalesReturned: filterdLst_SalesReturned));
      }

      // **********************   Details

      else if (event is getListSalesReturnedDetails_Event) {
        await getList_salesReturnedDetails(event.IDSalesReturned);
        emit(salesReturnedDetails_StateDataChanged(filterdLst_SalesReturnedDetails: filterdLst_SalesReturnedDetails));
      } else if (event is addNewSalesReturnedDetails_Event) {
        await addNewSalesReturnedDetails(event.itemCustomProduct!);
        emit(salesReturnedDetails_StateDataChanged(filterdLst_SalesReturnedDetails: filterdLst_SalesReturnedDetails));
      } else if (event is editRowSalesReturnedDetails_Event) {
        await editRowSalesReturnedDetails(event.itemCustomProduct!, event.index!);
        emit(salesReturnedDetails_StateDataChanged(filterdLst_SalesReturnedDetails: filterdLst_SalesReturnedDetails));
      } else if (event is deleteItemSalesReturnedDetails_Event) {
        await deleteItemSalesReturnedDetails(event.itemDetails!);
        emit(salesReturnedDetails_StateDataChanged(filterdLst_SalesReturnedDetails: filterdLst_SalesReturnedDetails));
      } else if (event is clearSalesReturnedDetails_Event) {
        filterdLst_SalesReturnedDetails.clear();
        bllInvoices_SalesReturned.lstInvoices_SalesReturnedDetails.clear();
        emit(clearSalesReturnedDetails());
      } else if (event is filterAnySalesReturnedDetails_Event) {
        await filterAny_salesReturnedDetails(filterData: event.filterData);
        emit(salesReturnedDetails_StateDataChanged(filterdLst_SalesReturnedDetails: filterdLst_SalesReturnedDetails));
      } else if (event is resetFilterSalesReturnedDetails_Event) {
        await resetFilter_salesReturnedDetails();
        emit(salesReturnedDetails_StateDataChanged(filterdLst_SalesReturnedDetails: filterdLst_SalesReturnedDetails));
      } else if (event is refreshSalesReturnedDetails_Event) {
        emit(salesReturnedDetails_StateDataChanged(filterdLst_SalesReturnedDetails: filterdLst_SalesReturnedDetails));
      }
    });
  }
}

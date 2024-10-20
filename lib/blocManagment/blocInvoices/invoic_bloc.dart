import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/bll/bllFirebase/bllInvoices_Purchase.dart';
import 'package:vigil_erp/bll/classModel/Invoices_Purchase.dart';
import 'package:vigil_erp/bll/classModel/Invoices_PurchaseDetails.dart';
import '../../bll/bllFirebase/ManageBLL.dart';
import '../../bll/bllFirebase/bllInvoices_Sales.dart';
import '../../bll/classModel/Invoices_Sales.dart';
import '../../bll/classModel/Invoices_SalesDetails.dart';
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
          (item.NetValue == null ? false : item.NetValue.toString().contains(filterData!))
      ;
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
        emit(clearPurchaseDetails());
      } else if (event is filterAnyPurchaseDetails_Event) {
        await filterAny_purchaseDetails(filterData: event.filterData);
        emit(purchaseDetails_StateDataChanged(filterdLst_PurchaseDetails: filterdLst_PurchaseDetails));
      } else if (event is resetFilterPurchaseDetails_Event) {
        await resetFilter_purchaseDetails();
        emit(purchaseDetails_StateDataChanged(filterdLst_PurchaseDetails: filterdLst_PurchaseDetails));
      }
      else if (event is refreshPurchaseDetails_Event) {
        emit(purchaseDetails_StateDataChanged(filterdLst_PurchaseDetails: filterdLst_PurchaseDetails));
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
          (item.NetValue == null ? false : item.NetValue.toString().contains(filterData!))
      ;
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
      }
      else if (event is refreshSalesDetails_Event) {
        emit(salesDetails_StateDataChanged(filterdLst_SalesDetails: filterdLst_SalesDetails));
      }

    });
  }
}




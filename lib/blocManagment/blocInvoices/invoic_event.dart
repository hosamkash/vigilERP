part of 'invoic_bloc.dart';

@immutable
sealed class invoic_event {}

//******************************** Purchase **************************************
class getListPurchase_Event extends invoic_event {
  final List<BLLCondions>? condions;
  getListPurchase_Event({ this.condions });
}
class refreshPurchase_Event extends invoic_event {}
class resetFilterPurchase_Event extends invoic_event {}
class filterAnyPurchase_Event extends invoic_event {
  final String? filterData;
  filterAnyPurchase_Event({ this.filterData});
}
class deletePurchase_Event extends invoic_event {
  final int? deleteID;
  deletePurchase_Event({ this.deleteID});
}

class getListPurchaseDetails_Event extends invoic_event {
  final int IDPurchase;
  getListPurchaseDetails_Event(this.IDPurchase);
}
class clearPurchaseDetails_Event extends invoic_event {}
class filterAnyPurchaseDetails_Event extends invoic_event {
  final String? filterData;
  filterAnyPurchaseDetails_Event({ this.filterData});
}
class addNewPurchaseDetails_Event extends invoic_event {
  final customProductItem? itemCustomProduct;
  addNewPurchaseDetails_Event({ this.itemCustomProduct});
}
class editRowPurchaseDetails_Event extends invoic_event {
  final customProductItem? itemCustomProduct;
  final int? index;
  editRowPurchaseDetails_Event({ this.itemCustomProduct , this.index});
}
class deleteItemPurchaseDetails_Event extends invoic_event {
  final Invoices_PurchaseDetails? itemDetails;
  deleteItemPurchaseDetails_Event({ this.itemDetails});
}
class resetFilterPurchaseDetails_Event extends invoic_event {}
class refreshPurchaseDetails_Event extends invoic_event {}


//******************************** PurchaseReturned **************************************
class getListPurchaseReturned_Event extends invoic_event {
  final List<BLLCondions>? condions;
  getListPurchaseReturned_Event({ this.condions });
}
class refreshPurchaseReturned_Event extends invoic_event {}
class resetFilterPurchaseReturned_Event extends invoic_event {}
class filterAnyPurchaseReturned_Event extends invoic_event {
  final String? filterData;
  filterAnyPurchaseReturned_Event({ this.filterData});
}
class deletePurchaseReturned_Event extends invoic_event {
  final int? deleteID;
  deletePurchaseReturned_Event({ this.deleteID});
}

class getListPurchaseReturnedDetails_Event extends invoic_event {
  final int IDPurchaseReturned;
  getListPurchaseReturnedDetails_Event(this.IDPurchaseReturned);
}
class clearPurchaseReturnedDetails_Event extends invoic_event {}
class filterAnyPurchaseReturnedDetails_Event extends invoic_event {
  final String? filterData;
  filterAnyPurchaseReturnedDetails_Event({ this.filterData});
}
class addNewPurchaseReturnedDetails_Event extends invoic_event {
  final customProductItem? itemCustomProduct;
  addNewPurchaseReturnedDetails_Event({ this.itemCustomProduct});
}
class editRowPurchaseReturnedDetails_Event extends invoic_event {
  final customProductItem? itemCustomProduct;
  final int? index;
  editRowPurchaseReturnedDetails_Event({ this.itemCustomProduct , this.index});
}
class deleteItemPurchaseReturnedDetails_Event extends invoic_event {
  final Invoices_PurchaseReturnedDetails? itemDetails;
  deleteItemPurchaseReturnedDetails_Event({ this.itemDetails});
}
class resetFilterPurchaseReturnedDetails_Event extends invoic_event {}
class refreshPurchaseReturnedDetails_Event extends invoic_event {}



//******************************** Sales **************************************
class getListSales_Event extends invoic_event {
  final List<BLLCondions>? condions;
  getListSales_Event({ this.condions });
}
class refreshSales_Event extends invoic_event {}
class resetFilterSales_Event extends invoic_event {}
class filterAnySales_Event extends invoic_event {
  final String? filterData;
  filterAnySales_Event({ this.filterData});
}
class deleteSales_Event extends invoic_event {
  final int? deleteID;
  deleteSales_Event({ this.deleteID});
}

class getListSalesDetails_Event extends invoic_event {
  final int IDSales;
  getListSalesDetails_Event(this.IDSales);
}
class clearSalesDetails_Event extends invoic_event {}
class filterAnySalesDetails_Event extends invoic_event {
  final String? filterData;
  filterAnySalesDetails_Event({ this.filterData});
}
class addNewSalesDetails_Event extends invoic_event {
  final customProductItem? itemCustomProduct;
  addNewSalesDetails_Event({ this.itemCustomProduct});
}
class editRowSalesDetails_Event extends invoic_event {
  final customProductItem? itemCustomProduct;
  final int? index;
  editRowSalesDetails_Event({ this.itemCustomProduct , this.index});
}
class deleteItemSalesDetails_Event extends invoic_event {
  final Invoices_SalesDetails? itemDetails;
  deleteItemSalesDetails_Event({ this.itemDetails});
}
class resetFilterSalesDetails_Event extends invoic_event {}
class refreshSalesDetails_Event extends invoic_event {}


//******************************** SalesReturned **************************************
class getListSalesReturned_Event extends invoic_event {
  final List<BLLCondions>? condions;
  getListSalesReturned_Event({ this.condions });
}
class refreshSalesReturned_Event extends invoic_event {}
class resetFilterSalesReturned_Event extends invoic_event {}
class filterAnySalesReturned_Event extends invoic_event {
  final String? filterData;
  filterAnySalesReturned_Event({ this.filterData});
}
class deleteSalesReturned_Event extends invoic_event {
  final int? deleteID;
  deleteSalesReturned_Event({ this.deleteID});
}

class getListSalesReturnedDetails_Event extends invoic_event {
  final int IDSalesReturned;
  getListSalesReturnedDetails_Event(this.IDSalesReturned);
}
class clearSalesReturnedDetails_Event extends invoic_event {}
class filterAnySalesReturnedDetails_Event extends invoic_event {
  final String? filterData;
  filterAnySalesReturnedDetails_Event({ this.filterData});
}
class addNewSalesReturnedDetails_Event extends invoic_event {
  final customProductItem? itemCustomProduct;
  addNewSalesReturnedDetails_Event({ this.itemCustomProduct});
}
class editRowSalesReturnedDetails_Event extends invoic_event {
  final customProductItem? itemCustomProduct;
  final int? index;
  editRowSalesReturnedDetails_Event({ this.itemCustomProduct , this.index});
}
class deleteItemSalesReturnedDetails_Event extends invoic_event {
  final Invoices_SalesReturnedDetails? itemDetails;
  deleteItemSalesReturnedDetails_Event({ this.itemDetails});
}
class resetFilterSalesReturnedDetails_Event extends invoic_event {}
class refreshSalesReturnedDetails_Event extends invoic_event {}

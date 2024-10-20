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
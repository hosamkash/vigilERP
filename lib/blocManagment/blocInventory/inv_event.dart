part of 'inv_bloc.dart';

@immutable
sealed class inv_event {}

//******************************** Material Qty - الجرد المستمر **************************************
class getListProductsQty_Event extends inv_event {
  int? priceType;
  getListProductsQty_Event({ this.priceType});
}
class getListProductsQtyByCondions_Event extends inv_event {
  final List<BLLCondions>? condions;
  int? priceType;
  int? hideQtyZeroID;
  getListProductsQtyByCondions_Event({ this.condions ,this.priceType , this.hideQtyZeroID});
}
class refreshProductsQty_Event extends inv_event {}
class resetFilterProductsQty_Event extends inv_event {}
class filterAnyProductsQty_Event extends inv_event {
  final String? filterData;
  filterAnyProductsQty_Event({ this.filterData});
}
class getListGroupedProductsQty_Event extends inv_event {
  final String? filterData;
  getListGroupedProductsQty_Event({ this.filterData});
}

//******************************** Permission add **************************************

class getListPermissionAdd_Event extends inv_event {
  final List<BLLCondions>? condions;
  getListPermissionAdd_Event({ this.condions });
}
class refreshPermissionAdd_Event extends inv_event {}
class resetFilterPermissionAdd_Event extends inv_event {}
class filterAnyPermissionAdd_Event extends inv_event {
  final String? filterData;
  filterAnyPermissionAdd_Event({ this.filterData});
}
class deletePermissionAdd_Event extends inv_event {
  final int? deleteID;
  deletePermissionAdd_Event({ this.deleteID});
}

class getListPermissionAddDetails_Event extends inv_event {
  final int IDPermissionAdd;
  getListPermissionAddDetails_Event(this.IDPermissionAdd);
}
class clearPermissionAddDetails_Event extends inv_event {}
class filterAnyPermissionAddDetails_Event extends inv_event {
  final String? filterData;
  filterAnyPermissionAddDetails_Event({ this.filterData});
}
class addNewPermissionAddDetails_Event extends inv_event {
  final customProductItem? itemCustomProduct;
  addNewPermissionAddDetails_Event({ this.itemCustomProduct});
}
class editRowPermissionAddDetails_Event extends inv_event {
  final customProductItem? itemCustomProduct;
  final int? index;
  editRowPermissionAddDetails_Event({ this.itemCustomProduct , this.index});
}
class deleteItemPermissionAddDetails_Event extends inv_event {
  final Inv_PermissionAddDetails? itemDetails;
  deleteItemPermissionAddDetails_Event({ this.itemDetails});
}
class resetFilterPermissionAddDetails_Event extends inv_event {}

//******************************** Permission Discount **************************************

class getListPermissionDiscount_Event extends inv_event {
  final List<BLLCondions>? condions;
  getListPermissionDiscount_Event({ this.condions });
}
class refreshPermissionDiscount_Event extends inv_event {}
class resetFilterPermissionDiscount_Event extends inv_event {}
class filterAnyPermissionDiscount_Event extends inv_event {
  final String? filterData;
  filterAnyPermissionDiscount_Event({ this.filterData});
}
class deletePermissionDiscount_Event extends inv_event {
  final int? deleteID;
  deletePermissionDiscount_Event({ this.deleteID});
}

class getListPermissionDiscountDetails_Event extends inv_event {
  final int IDPermissionDiscount;
  getListPermissionDiscountDetails_Event(this.IDPermissionDiscount);
}
class clearPermissionDiscountDetails_Event extends inv_event {}
class filterAnyPermissionDiscountDetails_Event extends inv_event {
  final String? filterData;
  filterAnyPermissionDiscountDetails_Event({ this.filterData});
}
class addNewPermissionDiscountDetails_Event extends inv_event {
  final customProductItem? itemCustomProduct;
  addNewPermissionDiscountDetails_Event({ this.itemCustomProduct});
}
class editRowPermissionDiscountDetails_Event extends inv_event {
  final customProductItem? itemCustomProduct;
  final int? index;
  editRowPermissionDiscountDetails_Event({ this.itemCustomProduct , this.index});
}
class deleteItemPermissionDiscountDetails_Event extends inv_event {
  final Inv_PermissionDiscountDetails? itemDetails;
  deleteItemPermissionDiscountDetails_Event({ this.itemDetails});
}
class resetFilterPermissionDiscountDetails_Event extends inv_event {}

//******************************** Settlement **************************************

class getListSettlement_Event extends inv_event {
  final List<BLLCondions>? condions;
  getListSettlement_Event({ this.condions });
}
class refreshSettlement_Event extends inv_event {}
class resetFilterSettlement_Event extends inv_event {}
class filterAnySettlement_Event extends inv_event {
  final String? filterData;
  filterAnySettlement_Event({ this.filterData});
}
class deleteSettlement_Event extends inv_event {
  final int? deleteID;
  deleteSettlement_Event({ this.deleteID});
}

class getListSettlementDetails_Event extends inv_event {
  final int IDSettlement;
  getListSettlementDetails_Event(this.IDSettlement);
}
class clearSettlementDetails_Event extends inv_event {}
class filterAnySettlementDetails_Event extends inv_event {
  final String? filterData;
  filterAnySettlementDetails_Event({ this.filterData});
}
class addNewSettlementDetails_Event extends inv_event {
  final customProductItem? itemCustomProduct;
  final int? stockID;
  addNewSettlementDetails_Event({ this.itemCustomProduct , this.stockID});
}
class editRowSettlementDetails_Event extends inv_event {
  final customProductItem? itemCustomProduct;
  final int? index;
  editRowSettlementDetails_Event({ this.itemCustomProduct , this.index});
}
class deleteItemSettlementDetails_Event extends inv_event {
  final Inv_SettlementDetails? itemDetails;
  deleteItemSettlementDetails_Event({ this.itemDetails});
}
class resetFilterSettlementDetails_Event extends inv_event {}
class refreshDetails_Event extends inv_event {}
class updateSettlementProductQtyByStock_Event extends inv_event {
  final int? stockID;
  final int? productID;
  updateSettlementProductQtyByStock_Event({this.productID , this.stockID  });
}

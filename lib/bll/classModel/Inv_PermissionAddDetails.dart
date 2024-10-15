

enum enTable_Inv_PermissionAddDetails{ ID, IDPermission, IDProduct, Barcode, IDClassefication, IDProductionCompanies, UnitBig_ID, UnitBig_Price, UnitBig_Qty, UnitCountOf, UnitSmall_ID, UnitSmall_Price, UnitSmall_Qty, isBigUnit, Balance, TotalPrice, PriceType }

class Inv_PermissionAddDetails
	{
		static List<String> ColumnsName = enTable_Inv_PermissionAddDetails.values.map((item) => item.name).toList();

 int? ID;
 int? IDPermission;
 int? IDProduct;
 int? Barcode;
 int? IDClassefication;
 int? IDProductionCompanies;
 int? UnitBig_ID;
 double? UnitBig_Price;
 int? UnitBig_Qty;
 int? UnitCountOf;
 int? UnitSmall_ID;
 double? UnitSmall_Price;
 int? UnitSmall_Qty;
 bool? isBigUnit;
 int? Balance;
 double? TotalPrice;
 int? PriceType;

Inv_PermissionAddDetails({
 		this.ID,
 		this.IDPermission,
 		this.IDProduct,
 		this.Barcode,
 		this.IDClassefication,
 		this.IDProductionCompanies,
 		this.UnitBig_ID,
 		this.UnitBig_Price,
 		this.UnitBig_Qty,
 		this.UnitCountOf,
 		this.UnitSmall_ID,
 		this.UnitSmall_Price,
 		this.UnitSmall_Qty,
 		this.isBigUnit,
 		this.Balance,
 		this.TotalPrice,
 		this.PriceType,
});


//**************************** general function ****************************

Inv_PermissionAddDetails.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 IDPermission = json['IDPermission'];
		 IDProduct = json['IDProduct'];
		 Barcode = json['Barcode'];
		 IDClassefication = json['IDClassefication'];
		 IDProductionCompanies = json['IDProductionCompanies'];
		 UnitBig_ID = json['UnitBig_ID'];
		 UnitBig_Price = json['UnitBig_Price'];
		 UnitBig_Qty = json['UnitBig_Qty'];
		 UnitCountOf = json['UnitCountOf'];
		 UnitSmall_ID = json['UnitSmall_ID'];
		 UnitSmall_Price = json['UnitSmall_Price'];
		 UnitSmall_Qty = json['UnitSmall_Qty'];
		 isBigUnit = json['isBigUnit'];
		 Balance = json['Balance'];
		 TotalPrice = json['TotalPrice'];
		 PriceType = json['PriceType'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'IDPermission' : IDPermission,
	 'IDProduct' : IDProduct,
	 'Barcode' : Barcode,
	 'IDClassefication' : IDClassefication,
	 'IDProductionCompanies' : IDProductionCompanies,
	 'UnitBig_ID' : UnitBig_ID,
	 'UnitBig_Price' : UnitBig_Price,
	 'UnitBig_Qty' : UnitBig_Qty,
	 'UnitCountOf' : UnitCountOf,
	 'UnitSmall_ID' : UnitSmall_ID,
	 'UnitSmall_Price' : UnitSmall_Price,
	 'UnitSmall_Qty' : UnitSmall_Qty,
	 'isBigUnit' : isBigUnit,
	 'Balance' : Balance,
	 'TotalPrice' : TotalPrice,
	 'PriceType' : PriceType,
		};
}

static List<dynamic> getColumnAsList(List<Inv_PermissionAddDetails> lstInv_PermissionAddDetails, enTable_Inv_PermissionAddDetails enTable)
	{
	if (enTable == enTable_Inv_PermissionAddDetails.ID) {
		return lstInv_PermissionAddDetails.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.IDPermission) {
		return lstInv_PermissionAddDetails.map((col) => col.IDPermission).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.IDProduct) {
		return lstInv_PermissionAddDetails.map((col) => col.IDProduct).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.Barcode) {
		return lstInv_PermissionAddDetails.map((col) => col.Barcode).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.IDClassefication) {
		return lstInv_PermissionAddDetails.map((col) => col.IDClassefication).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.IDProductionCompanies) {
		return lstInv_PermissionAddDetails.map((col) => col.IDProductionCompanies).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.UnitBig_ID) {
		return lstInv_PermissionAddDetails.map((col) => col.UnitBig_ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.UnitBig_Price) {
		return lstInv_PermissionAddDetails.map((col) => col.UnitBig_Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.UnitBig_Qty) {
		return lstInv_PermissionAddDetails.map((col) => col.UnitBig_Qty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.UnitCountOf) {
		return lstInv_PermissionAddDetails.map((col) => col.UnitCountOf).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.UnitSmall_ID) {
		return lstInv_PermissionAddDetails.map((col) => col.UnitSmall_ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.UnitSmall_Price) {
		return lstInv_PermissionAddDetails.map((col) => col.UnitSmall_Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.UnitSmall_Qty) {
		return lstInv_PermissionAddDetails.map((col) => col.UnitSmall_Qty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.isBigUnit) {
		return lstInv_PermissionAddDetails.map((col) => col.isBigUnit).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.Balance) {
		return lstInv_PermissionAddDetails.map((col) => col.Balance).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.TotalPrice) {
		return lstInv_PermissionAddDetails.map((col) => col.TotalPrice).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.PriceType) {
		return lstInv_PermissionAddDetails.map((col) => col.PriceType).toSet().toList() as List<int>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Inv_PermissionAddDetails> lstInv_PermissionAddDetails, enTable_Inv_PermissionAddDetails enTable)
	{
	if (enTable == enTable_Inv_PermissionAddDetails.ID) {
		return lstInv_PermissionAddDetails.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.IDPermission) {
		return lstInv_PermissionAddDetails.map((col) => col.IDPermission.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.IDProduct) {
		return lstInv_PermissionAddDetails.map((col) => col.IDProduct.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.Barcode) {
		return lstInv_PermissionAddDetails.map((col) => col.Barcode.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.IDClassefication) {
		return lstInv_PermissionAddDetails.map((col) => col.IDClassefication.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.IDProductionCompanies) {
		return lstInv_PermissionAddDetails.map((col) => col.IDProductionCompanies.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.UnitBig_ID) {
		return lstInv_PermissionAddDetails.map((col) => col.UnitBig_ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.UnitBig_Price) {
		return lstInv_PermissionAddDetails.map((col) => col.UnitBig_Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.UnitBig_Qty) {
		return lstInv_PermissionAddDetails.map((col) => col.UnitBig_Qty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.UnitCountOf) {
		return lstInv_PermissionAddDetails.map((col) => col.UnitCountOf.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.UnitSmall_ID) {
		return lstInv_PermissionAddDetails.map((col) => col.UnitSmall_ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.UnitSmall_Price) {
		return lstInv_PermissionAddDetails.map((col) => col.UnitSmall_Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.UnitSmall_Qty) {
		return lstInv_PermissionAddDetails.map((col) => col.UnitSmall_Qty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.isBigUnit) {
		return lstInv_PermissionAddDetails.map((col) => col.isBigUnit.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.Balance) {
		return lstInv_PermissionAddDetails.map((col) => col.Balance.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.TotalPrice) {
		return lstInv_PermissionAddDetails.map((col) => col.TotalPrice.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionAddDetails.PriceType) {
		return lstInv_PermissionAddDetails.map((col) => col.PriceType.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}


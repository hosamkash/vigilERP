

enum enTable_Inv_PermissionDiscountDetails{ ID, IDPermission, IDProduct, Barcode, IDClassefication, IDProductionCompanies, UnitBig_ID, UnitBig_Price, UnitBig_Qty, UnitCountOf, UnitSmall_ID, UnitSmall_Price, UnitSmall_Qty, isBigUnit, Balance, TotalPrice, PriceType }

class Inv_PermissionDiscountDetails
	{
		static List<String> ColumnsName = enTable_Inv_PermissionDiscountDetails.values.map((item) => item.name).toList();

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

Inv_PermissionDiscountDetails({
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

Inv_PermissionDiscountDetails.fromJson(Map<String, dynamic> json) {
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

static List<dynamic> getColumnAsList(List<Inv_PermissionDiscountDetails> lstInv_PermissionDiscountDetails, enTable_Inv_PermissionDiscountDetails enTable)
	{
	if (enTable == enTable_Inv_PermissionDiscountDetails.ID) {
		return lstInv_PermissionDiscountDetails.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.IDPermission) {
		return lstInv_PermissionDiscountDetails.map((col) => col.IDPermission).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.IDProduct) {
		return lstInv_PermissionDiscountDetails.map((col) => col.IDProduct).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.Barcode) {
		return lstInv_PermissionDiscountDetails.map((col) => col.Barcode).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.IDClassefication) {
		return lstInv_PermissionDiscountDetails.map((col) => col.IDClassefication).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.IDProductionCompanies) {
		return lstInv_PermissionDiscountDetails.map((col) => col.IDProductionCompanies).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.UnitBig_ID) {
		return lstInv_PermissionDiscountDetails.map((col) => col.UnitBig_ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.UnitBig_Price) {
		return lstInv_PermissionDiscountDetails.map((col) => col.UnitBig_Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.UnitBig_Qty) {
		return lstInv_PermissionDiscountDetails.map((col) => col.UnitBig_Qty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.UnitCountOf) {
		return lstInv_PermissionDiscountDetails.map((col) => col.UnitCountOf).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.UnitSmall_ID) {
		return lstInv_PermissionDiscountDetails.map((col) => col.UnitSmall_ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.UnitSmall_Price) {
		return lstInv_PermissionDiscountDetails.map((col) => col.UnitSmall_Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.UnitSmall_Qty) {
		return lstInv_PermissionDiscountDetails.map((col) => col.UnitSmall_Qty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.isBigUnit) {
		return lstInv_PermissionDiscountDetails.map((col) => col.isBigUnit).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.Balance) {
		return lstInv_PermissionDiscountDetails.map((col) => col.Balance).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.TotalPrice) {
		return lstInv_PermissionDiscountDetails.map((col) => col.TotalPrice).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.PriceType) {
		return lstInv_PermissionDiscountDetails.map((col) => col.PriceType).toSet().toList() as List<int>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Inv_PermissionDiscountDetails> lstInv_PermissionDiscountDetails, enTable_Inv_PermissionDiscountDetails enTable)
	{
	if (enTable == enTable_Inv_PermissionDiscountDetails.ID) {
		return lstInv_PermissionDiscountDetails.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.IDPermission) {
		return lstInv_PermissionDiscountDetails.map((col) => col.IDPermission.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.IDProduct) {
		return lstInv_PermissionDiscountDetails.map((col) => col.IDProduct.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.Barcode) {
		return lstInv_PermissionDiscountDetails.map((col) => col.Barcode.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.IDClassefication) {
		return lstInv_PermissionDiscountDetails.map((col) => col.IDClassefication.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.IDProductionCompanies) {
		return lstInv_PermissionDiscountDetails.map((col) => col.IDProductionCompanies.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.UnitBig_ID) {
		return lstInv_PermissionDiscountDetails.map((col) => col.UnitBig_ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.UnitBig_Price) {
		return lstInv_PermissionDiscountDetails.map((col) => col.UnitBig_Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.UnitBig_Qty) {
		return lstInv_PermissionDiscountDetails.map((col) => col.UnitBig_Qty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.UnitCountOf) {
		return lstInv_PermissionDiscountDetails.map((col) => col.UnitCountOf.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.UnitSmall_ID) {
		return lstInv_PermissionDiscountDetails.map((col) => col.UnitSmall_ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.UnitSmall_Price) {
		return lstInv_PermissionDiscountDetails.map((col) => col.UnitSmall_Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.UnitSmall_Qty) {
		return lstInv_PermissionDiscountDetails.map((col) => col.UnitSmall_Qty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.isBigUnit) {
		return lstInv_PermissionDiscountDetails.map((col) => col.isBigUnit.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.Balance) {
		return lstInv_PermissionDiscountDetails.map((col) => col.Balance.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.TotalPrice) {
		return lstInv_PermissionDiscountDetails.map((col) => col.TotalPrice.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_PermissionDiscountDetails.PriceType) {
		return lstInv_PermissionDiscountDetails.map((col) => col.PriceType.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}


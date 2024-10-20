

enum enTable_Inv_RecivedQtyDetails{ ID, IDRecived, IDProduct, Barcode, IDClassefication, IDProductionCompanies, UnitBig_ID, UnitBig_Price, UnitBig_Qty, UnitCountOf, UnitSmall_ID, UnitSmall_Price, UnitSmall_Qty, isBigUnit, TotalPrice, PriceType, RecivedUnitBig_ID, RecivedUnitBig_Price, RecivedUnitBig_Qty, RecivedUnitSmall_ID, RecivedUnitSmall_Price, RecivedUnitSmall_Qty, RecivedisBigUnit, RecivedTotalPrice }

class Inv_RecivedQtyDetails
	{
		static List<String> ColumnsName = enTable_Inv_RecivedQtyDetails.values.map((item) => item.name).toList();

 int? ID;
 int? IDRecived;
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
 double? TotalPrice;
 int? PriceType;
 int? RecivedUnitBig_ID;
 double? RecivedUnitBig_Price;
 int? RecivedUnitBig_Qty;
 int? RecivedUnitSmall_ID;
 double? RecivedUnitSmall_Price;
 int? RecivedUnitSmall_Qty;
 bool? RecivedisBigUnit;
 double? RecivedTotalPrice;

Inv_RecivedQtyDetails({
 		this.ID,
 		this.IDRecived,
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
 		this.TotalPrice,
 		this.PriceType,
 		this.RecivedUnitBig_ID,
 		this.RecivedUnitBig_Price,
 		this.RecivedUnitBig_Qty,
 		this.RecivedUnitSmall_ID,
 		this.RecivedUnitSmall_Price,
 		this.RecivedUnitSmall_Qty,
 		this.RecivedisBigUnit,
 		this.RecivedTotalPrice,
});


//**************************** general function ****************************

Inv_RecivedQtyDetails.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 IDRecived = json['IDRecived'];
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
		 TotalPrice = json['TotalPrice'];
		 PriceType = json['PriceType'];
		 RecivedUnitBig_ID = json['RecivedUnitBig_ID'];
		 RecivedUnitBig_Price = json['RecivedUnitBig_Price'];
		 RecivedUnitBig_Qty = json['RecivedUnitBig_Qty'];
		 RecivedUnitSmall_ID = json['RecivedUnitSmall_ID'];
		 RecivedUnitSmall_Price = json['RecivedUnitSmall_Price'];
		 RecivedUnitSmall_Qty = json['RecivedUnitSmall_Qty'];
		 RecivedisBigUnit = json['RecivedisBigUnit'];
		 RecivedTotalPrice = json['RecivedTotalPrice'];
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'IDRecived' : IDRecived,
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
	 'TotalPrice' : TotalPrice,
	 'PriceType' : PriceType,
	 'RecivedUnitBig_ID' : RecivedUnitBig_ID,
	 'RecivedUnitBig_Price' : RecivedUnitBig_Price,
	 'RecivedUnitBig_Qty' : RecivedUnitBig_Qty,
	 'RecivedUnitSmall_ID' : RecivedUnitSmall_ID,
	 'RecivedUnitSmall_Price' : RecivedUnitSmall_Price,
	 'RecivedUnitSmall_Qty' : RecivedUnitSmall_Qty,
	 'RecivedisBigUnit' : RecivedisBigUnit,
	 'RecivedTotalPrice' : RecivedTotalPrice,
		};
}

static List<dynamic> getColumnAsList(List<Inv_RecivedQtyDetails> lstInv_RecivedQtyDetails, enTable_Inv_RecivedQtyDetails enTable)
	{
	if (enTable == enTable_Inv_RecivedQtyDetails.ID) {
		return lstInv_RecivedQtyDetails.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.IDRecived) {
		return lstInv_RecivedQtyDetails.map((col) => col.IDRecived).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.IDProduct) {
		return lstInv_RecivedQtyDetails.map((col) => col.IDProduct).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.Barcode) {
		return lstInv_RecivedQtyDetails.map((col) => col.Barcode).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.IDClassefication) {
		return lstInv_RecivedQtyDetails.map((col) => col.IDClassefication).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.IDProductionCompanies) {
		return lstInv_RecivedQtyDetails.map((col) => col.IDProductionCompanies).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.UnitBig_ID) {
		return lstInv_RecivedQtyDetails.map((col) => col.UnitBig_ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.UnitBig_Price) {
		return lstInv_RecivedQtyDetails.map((col) => col.UnitBig_Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.UnitBig_Qty) {
		return lstInv_RecivedQtyDetails.map((col) => col.UnitBig_Qty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.UnitCountOf) {
		return lstInv_RecivedQtyDetails.map((col) => col.UnitCountOf).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.UnitSmall_ID) {
		return lstInv_RecivedQtyDetails.map((col) => col.UnitSmall_ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.UnitSmall_Price) {
		return lstInv_RecivedQtyDetails.map((col) => col.UnitSmall_Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.UnitSmall_Qty) {
		return lstInv_RecivedQtyDetails.map((col) => col.UnitSmall_Qty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.isBigUnit) {
		return lstInv_RecivedQtyDetails.map((col) => col.isBigUnit).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.TotalPrice) {
		return lstInv_RecivedQtyDetails.map((col) => col.TotalPrice).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.PriceType) {
		return lstInv_RecivedQtyDetails.map((col) => col.PriceType).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedUnitBig_ID) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedUnitBig_ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedUnitBig_Price) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedUnitBig_Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedUnitBig_Qty) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedUnitBig_Qty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedUnitSmall_ID) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedUnitSmall_ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedUnitSmall_Price) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedUnitSmall_Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedUnitSmall_Qty) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedUnitSmall_Qty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedisBigUnit) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedisBigUnit).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedTotalPrice) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedTotalPrice).toSet().toList() as List<double>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Inv_RecivedQtyDetails> lstInv_RecivedQtyDetails, enTable_Inv_RecivedQtyDetails enTable)
	{
	if (enTable == enTable_Inv_RecivedQtyDetails.ID) {
		return lstInv_RecivedQtyDetails.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.IDRecived) {
		return lstInv_RecivedQtyDetails.map((col) => col.IDRecived.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.IDProduct) {
		return lstInv_RecivedQtyDetails.map((col) => col.IDProduct.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.Barcode) {
		return lstInv_RecivedQtyDetails.map((col) => col.Barcode.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.IDClassefication) {
		return lstInv_RecivedQtyDetails.map((col) => col.IDClassefication.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.IDProductionCompanies) {
		return lstInv_RecivedQtyDetails.map((col) => col.IDProductionCompanies.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.UnitBig_ID) {
		return lstInv_RecivedQtyDetails.map((col) => col.UnitBig_ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.UnitBig_Price) {
		return lstInv_RecivedQtyDetails.map((col) => col.UnitBig_Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.UnitBig_Qty) {
		return lstInv_RecivedQtyDetails.map((col) => col.UnitBig_Qty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.UnitCountOf) {
		return lstInv_RecivedQtyDetails.map((col) => col.UnitCountOf.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.UnitSmall_ID) {
		return lstInv_RecivedQtyDetails.map((col) => col.UnitSmall_ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.UnitSmall_Price) {
		return lstInv_RecivedQtyDetails.map((col) => col.UnitSmall_Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.UnitSmall_Qty) {
		return lstInv_RecivedQtyDetails.map((col) => col.UnitSmall_Qty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.isBigUnit) {
		return lstInv_RecivedQtyDetails.map((col) => col.isBigUnit.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.TotalPrice) {
		return lstInv_RecivedQtyDetails.map((col) => col.TotalPrice.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.PriceType) {
		return lstInv_RecivedQtyDetails.map((col) => col.PriceType.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedUnitBig_ID) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedUnitBig_ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedUnitBig_Price) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedUnitBig_Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedUnitBig_Qty) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedUnitBig_Qty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedUnitSmall_ID) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedUnitSmall_ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedUnitSmall_Price) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedUnitSmall_Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedUnitSmall_Qty) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedUnitSmall_Qty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedisBigUnit) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedisBigUnit.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_RecivedQtyDetails.RecivedTotalPrice) {
		return lstInv_RecivedQtyDetails.map((col) => col.RecivedTotalPrice.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}


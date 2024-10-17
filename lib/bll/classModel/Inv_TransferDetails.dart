

enum enTable_Inv_TransferDetails{ ID, IDTranfer, IDProduct, Barcode, IDClassefication, IDProductionCompanies, UnitBig_ID, UnitBig_Price, UnitBig_Qty, UnitCountOf, UnitSmall_ID, UnitSmall_Price, UnitSmall_Qty, isBigUnit, TotalPrice, PriceType }

class Inv_TransferDetails
	{
		static List<String> ColumnsName = enTable_Inv_TransferDetails.values.map((item) => item.name).toList();

 int? ID;
 int? IDTranfer;
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

Inv_TransferDetails({
 		this.ID,
 		this.IDTranfer,
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
});


//**************************** general function ****************************

Inv_TransferDetails.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 IDTranfer = json['IDTranfer'];
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
}

Map<String, dynamic> toMap() {
	return {
 'ID' : ID,
	 'IDTranfer' : IDTranfer,
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
		};
}

static List<dynamic> getColumnAsList(List<Inv_TransferDetails> lstInv_TransferDetails, enTable_Inv_TransferDetails enTable)
	{
	if (enTable == enTable_Inv_TransferDetails.ID) {
		return lstInv_TransferDetails.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_TransferDetails.IDTranfer) {
		return lstInv_TransferDetails.map((col) => col.IDTranfer).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_TransferDetails.IDProduct) {
		return lstInv_TransferDetails.map((col) => col.IDProduct).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_TransferDetails.Barcode) {
		return lstInv_TransferDetails.map((col) => col.Barcode).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_TransferDetails.IDClassefication) {
		return lstInv_TransferDetails.map((col) => col.IDClassefication).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_TransferDetails.IDProductionCompanies) {
		return lstInv_TransferDetails.map((col) => col.IDProductionCompanies).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_TransferDetails.UnitBig_ID) {
		return lstInv_TransferDetails.map((col) => col.UnitBig_ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_TransferDetails.UnitBig_Price) {
		return lstInv_TransferDetails.map((col) => col.UnitBig_Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_TransferDetails.UnitBig_Qty) {
		return lstInv_TransferDetails.map((col) => col.UnitBig_Qty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_TransferDetails.UnitCountOf) {
		return lstInv_TransferDetails.map((col) => col.UnitCountOf).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_TransferDetails.UnitSmall_ID) {
		return lstInv_TransferDetails.map((col) => col.UnitSmall_ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_TransferDetails.UnitSmall_Price) {
		return lstInv_TransferDetails.map((col) => col.UnitSmall_Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_TransferDetails.UnitSmall_Qty) {
		return lstInv_TransferDetails.map((col) => col.UnitSmall_Qty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Inv_TransferDetails.isBigUnit) {
		return lstInv_TransferDetails.map((col) => col.isBigUnit).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Inv_TransferDetails.TotalPrice) {
		return lstInv_TransferDetails.map((col) => col.TotalPrice).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Inv_TransferDetails.PriceType) {
		return lstInv_TransferDetails.map((col) => col.PriceType).toSet().toList() as List<int>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Inv_TransferDetails> lstInv_TransferDetails, enTable_Inv_TransferDetails enTable)
	{
	if (enTable == enTable_Inv_TransferDetails.ID) {
		return lstInv_TransferDetails.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_TransferDetails.IDTranfer) {
		return lstInv_TransferDetails.map((col) => col.IDTranfer.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_TransferDetails.IDProduct) {
		return lstInv_TransferDetails.map((col) => col.IDProduct.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_TransferDetails.Barcode) {
		return lstInv_TransferDetails.map((col) => col.Barcode.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_TransferDetails.IDClassefication) {
		return lstInv_TransferDetails.map((col) => col.IDClassefication.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_TransferDetails.IDProductionCompanies) {
		return lstInv_TransferDetails.map((col) => col.IDProductionCompanies.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_TransferDetails.UnitBig_ID) {
		return lstInv_TransferDetails.map((col) => col.UnitBig_ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_TransferDetails.UnitBig_Price) {
		return lstInv_TransferDetails.map((col) => col.UnitBig_Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_TransferDetails.UnitBig_Qty) {
		return lstInv_TransferDetails.map((col) => col.UnitBig_Qty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_TransferDetails.UnitCountOf) {
		return lstInv_TransferDetails.map((col) => col.UnitCountOf.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_TransferDetails.UnitSmall_ID) {
		return lstInv_TransferDetails.map((col) => col.UnitSmall_ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_TransferDetails.UnitSmall_Price) {
		return lstInv_TransferDetails.map((col) => col.UnitSmall_Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_TransferDetails.UnitSmall_Qty) {
		return lstInv_TransferDetails.map((col) => col.UnitSmall_Qty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_TransferDetails.isBigUnit) {
		return lstInv_TransferDetails.map((col) => col.isBigUnit.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_TransferDetails.TotalPrice) {
		return lstInv_TransferDetails.map((col) => col.TotalPrice.toString()).toSet().toList();
	}
	else if (enTable == enTable_Inv_TransferDetails.PriceType) {
		return lstInv_TransferDetails.map((col) => col.PriceType.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}


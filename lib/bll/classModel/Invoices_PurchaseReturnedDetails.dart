

enum enTable_Invoices_PurchaseReturnedDetails{ ID, IDPurchaseInvoice, IDProduct, Barcode, IDClassefication, IDProductionCompanies, UnitBig_ID, UnitBig_Qty, UnitBig_Price, UnitCountOf, UnitSmall_ID, UnitSmall_Price, UnitSmall_Qty, isBigUnit, TotalPrice, PriceType }

class Invoices_PurchaseReturnedDetails
	{
		static List<String> ColumnsName = enTable_Invoices_PurchaseReturnedDetails.values.map((item) => item.name).toList();

 int? ID;
 int? IDPurchaseInvoice;
 int? IDProduct;
 int? Barcode;
 int? IDClassefication;
 int? IDProductionCompanies;
 int? UnitBig_ID;
 int? UnitBig_Qty;
 double? UnitBig_Price;
 int? UnitCountOf;
 int? UnitSmall_ID;
 double? UnitSmall_Price;
 int? UnitSmall_Qty;
 bool? isBigUnit;
 double? TotalPrice;
 int? PriceType;

Invoices_PurchaseReturnedDetails({
 		this.ID,
 		this.IDPurchaseInvoice,
 		this.IDProduct,
 		this.Barcode,
 		this.IDClassefication,
 		this.IDProductionCompanies,
 		this.UnitBig_ID,
 		this.UnitBig_Qty,
 		this.UnitBig_Price,
 		this.UnitCountOf,
 		this.UnitSmall_ID,
 		this.UnitSmall_Price,
 		this.UnitSmall_Qty,
 		this.isBigUnit,
 		this.TotalPrice,
 		this.PriceType,
});


//**************************** general function ****************************

Invoices_PurchaseReturnedDetails.fromJson(Map<String, dynamic> json) {
 ID = json['ID'];
		 IDPurchaseInvoice = json['IDPurchaseInvoice'];
		 IDProduct = json['IDProduct'];
		 Barcode = json['Barcode'];
		 IDClassefication = json['IDClassefication'];
		 IDProductionCompanies = json['IDProductionCompanies'];
		 UnitBig_ID = json['UnitBig_ID'];
		 UnitBig_Qty = json['UnitBig_Qty'];
		 UnitBig_Price = json['UnitBig_Price'];
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
	 'IDPurchaseInvoice' : IDPurchaseInvoice,
	 'IDProduct' : IDProduct,
	 'Barcode' : Barcode,
	 'IDClassefication' : IDClassefication,
	 'IDProductionCompanies' : IDProductionCompanies,
	 'UnitBig_ID' : UnitBig_ID,
	 'UnitBig_Qty' : UnitBig_Qty,
	 'UnitBig_Price' : UnitBig_Price,
	 'UnitCountOf' : UnitCountOf,
	 'UnitSmall_ID' : UnitSmall_ID,
	 'UnitSmall_Price' : UnitSmall_Price,
	 'UnitSmall_Qty' : UnitSmall_Qty,
	 'isBigUnit' : isBigUnit,
	 'TotalPrice' : TotalPrice,
	 'PriceType' : PriceType,
		};
}

static List<dynamic> getColumnAsList(List<Invoices_PurchaseReturnedDetails> lstInvoices_PurchaseReturnedDetails, enTable_Invoices_PurchaseReturnedDetails enTable)
	{
	if (enTable == enTable_Invoices_PurchaseReturnedDetails.ID) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.IDPurchaseInvoice) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.IDPurchaseInvoice).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.IDProduct) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.IDProduct).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.Barcode) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.Barcode).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.IDClassefication) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.IDClassefication).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.IDProductionCompanies) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.IDProductionCompanies).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.UnitBig_ID) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.UnitBig_ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.UnitBig_Qty) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.UnitBig_Qty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.UnitBig_Price) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.UnitBig_Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.UnitCountOf) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.UnitCountOf).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.UnitSmall_ID) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.UnitSmall_ID).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.UnitSmall_Price) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.UnitSmall_Price).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.UnitSmall_Qty) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.UnitSmall_Qty).toSet().toList() as List<int>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.isBigUnit) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.isBigUnit).toSet().toList() as List<bool>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.TotalPrice) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.TotalPrice).toSet().toList() as List<double>;
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.PriceType) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.PriceType).toSet().toList() as List<int>;
	}
else { return Null as List<dynamic>;}
}

static List<String> getColumnAsListString(List<Invoices_PurchaseReturnedDetails> lstInvoices_PurchaseReturnedDetails, enTable_Invoices_PurchaseReturnedDetails enTable)
	{
	if (enTable == enTable_Invoices_PurchaseReturnedDetails.ID) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.IDPurchaseInvoice) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.IDPurchaseInvoice.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.IDProduct) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.IDProduct.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.Barcode) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.Barcode.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.IDClassefication) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.IDClassefication.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.IDProductionCompanies) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.IDProductionCompanies.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.UnitBig_ID) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.UnitBig_ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.UnitBig_Qty) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.UnitBig_Qty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.UnitBig_Price) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.UnitBig_Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.UnitCountOf) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.UnitCountOf.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.UnitSmall_ID) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.UnitSmall_ID.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.UnitSmall_Price) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.UnitSmall_Price.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.UnitSmall_Qty) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.UnitSmall_Qty.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.isBigUnit) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.isBigUnit.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.TotalPrice) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.TotalPrice.toString()).toSet().toList();
	}
	else if (enTable == enTable_Invoices_PurchaseReturnedDetails.PriceType) {
		return lstInvoices_PurchaseReturnedDetails.map((col) => col.PriceType.toString()).toSet().toList();
	}
else { return '' as List<String>;}
}

	}

